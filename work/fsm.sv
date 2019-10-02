/*
 * Here is the main FSM module
 */

module fsm(
	input logic clk,
	input logic reset,

	input logic power_btn,

	input logic mode_inc,
	input logic mode_dec,
	input logic fstop_inc,
	input logic fstop_dec,
	input logic shutter_inc,
	input logic shutter_dec,

	input logic shutter_btn,

	input logic [15:0] sensor_data,

	output logic [15:0] output_data,
	output logic output_data_valid
);

	/* Power button FF async */
	logic power_on;
	always_ff @(posedge power_btn, posedge reset) begin
		if (reset) begin
			power_on <= 0;
		end else begin
			power_on <= ~power_on;
		end
	end

	/* Countdown module required for waiting on shutter (based on shutter speed) */
	/* Let SCD stand for shutter-countdown */
	logic scd_reset, scd_wr_en, scd_cd_en;
	logic [31:0] scd_cycles;
	logic scd_done;

	countdown COUNTDOWN_MODULE(
		.clk(clk), .reset(scd_reset), .wait_cycles(scd_cycles),
		.write_enable(scd_wr_en), .countdown_enable(scd_cd_en),
		.done(scd_done)
	);

	/* DFF to contain memory for aperture and shutter settings */
	/* There are 8 aperture and shutter settings, so only 3 bits is required */
	logic [2:0] next_aperture_setting, aperture_setting;
	logic aperture_setting_en;
	dffs #(3) APERTURE_SETTING_FF(
		.d(next_aperture_setting), .q(aperture_setting),
		.en(aperture_setting_en), .clk(clk), .rst(reset)
	);

	logic [2:0] next_shutter_setting, shutter_setting;
	logic shutter_setting_en;
	dffs #(3) SHUTTER_SETTING_FF(
		.d(next_shutter_setting), .q(shutter_setting),
		.en(shutter_setting_en), .clk(clk), .rst(reset)
	);

	/* Decoder to take aperture/shutter settings and turn them */
	/* into usable values */
	logic [7:0] aperture_multiplier;
	aperture_decoder FSTOP_DECODER(
		.input_setting(aperture_setting),
		.output_multiplier(aperture_multiplier)
	);
	shutter_decoder SHUTTER_DECODER(
		.input_setting(shutter_setting),
		.shutter_wait_time(scd_cycles)
	);

	/* State definitions */
	/* Since we're not using more than 32 states, 5 bit width should be more than enough */
	enum logic[4:0] {
		ST_IDLE,                /* [1]  The idle / reset state */

		ST_APERTURE_PRIORITY,   /* [2]  The default home state for aperture priority mode */
		ST_SHUTTER_PRIORITY,    /* [3]  The default home state for shutter priority mode */
		ST_MANUAL,              /* [4]  The default home state for manual exposure mode */

		ST_INC_FSTOP,           /* [5]  State for increasing f-stop number */
		ST_DEC_FSTOP,           /* [6]  State for decreasing f-stop number */
		ST_INC_SHUTTER,         /* [7]  State for increasing shutter speed */
		ST_DEC_SHUTTER,         /* [8]  State for decreasing shutter speed */

		ST_CALC_SHUTTER,        /* [9]  Intermediate state for aperture priority to caluclate shutter speed needed */
		ST_CALC_APERTURE,       /* [10] Intermediate state for shutter speed priority to caluclate aperture needed */

		ST_WAIT_SHUTTER,        /* [11] State for waiting for the shutter to open and close */
		ST_DONE                 /* [12] state for outputting shutter */
	} current_state, next_state, prev_mode_state;

	/* Save the camera operating mode state */
	logic prev_mode_en;
	always_ff @(posedge clk, posedge reset) begin
		if (reset) begin
			prev_mode_state <= ST_APERTURE_PRIORITY;
		end else if (prev_mode_en) begin
			prev_mode_state <= current_state;
		end else begin
			prev_mode_state <= prev_mode_state;
		end
	end

	/* Next state combinational logic */
	always_comb begin

		// Default (cover all combinational cases)
		next_state = current_state;

		case (current_state)

			ST_IDLE: next_state <= power_on == 1 ? prev_mode_state : ST_IDLE;

			ST_APERTURE_PRIORITY: begin
				if (~power_on)          next_state <= ST_IDLE;
				else if (mode_inc)      next_state <= ST_SHUTTER_PRIORITY;
				else if (mode_dec)      next_state <= ST_MANUAL;
				else if (fstop_inc & (aperture_setting != 3'b111))
										next_state <= ST_INC_FSTOP;
				else if (fstop_dec & (aperture_setting != 3'b000)) 
										next_state <= ST_DEC_FSTOP;
				else if (shutter_btn)   next_state <= ST_CALC_SHUTTER; /* We need to calculate what shutter we need because the user sets the aperture */
			end

			ST_SHUTTER_PRIORITY: begin
				if (~power_on)          next_state <= ST_IDLE;
				else if (mode_inc)      next_state <= ST_MANUAL;
				else if (mode_dec)      next_state <= ST_APERTURE_PRIORITY;
				else if (shutter_inc & (shutter_setting != 3'b111))
										next_state <= ST_INC_SHUTTER;
				else if (shutter_dec & (shutter_setting != 3'b000))
										next_state <= ST_DEC_SHUTTER;
				else if (shutter_btn)   next_state <= ST_CALC_APERTURE;
			end

			ST_MANUAL: begin
				if (~power_on)          next_state <= ST_IDLE;
				else if (mode_inc)      next_state <= ST_APERTURE_PRIORITY;
				else if (mode_dec)      next_state <= ST_SHUTTER_PRIORITY;
				else if ((fstop_inc) & (aperture_setting != 3'b111))
										next_state <= ST_INC_FSTOP;
				else if ((fstop_dec) & (aperture_setting != 3'b000)) 
										next_state <= ST_DEC_FSTOP;
				else if (shutter_inc & (shutter_setting != 3'b111))
										next_state <= ST_INC_SHUTTER;
				else if (shutter_dec & (shutter_setting != 3'b000))
										next_state <= ST_DEC_SHUTTER;
				else if (shutter_btn)   next_state <= ST_WAIT_SHUTTER;
			end

			ST_INC_FSTOP: next_state <= prev_mode_state;
			ST_DEC_FSTOP: next_state <= prev_mode_state;
			ST_INC_SHUTTER: next_state <= prev_mode_state;
			ST_DEC_SHUTTER: next_state <= prev_mode_state;

			ST_CALC_APERTURE: next_state <= ST_WAIT_SHUTTER;
			ST_CALC_SHUTTER: next_state <= ST_WAIT_SHUTTER;

			ST_WAIT_SHUTTER: next_state <= scd_done ? ST_DONE : ST_WAIT_SHUTTER;
			ST_DONE: next_state <= prev_mode_state;
		endcase
	end

	/* State sequential logic */
	always_ff @(posedge clk, negedge reset) begin
		if (reset) begin
			current_state <= ST_IDLE;
		end else begin
			current_state <= next_state;
		end
	end

	/* FSM states to module connection logic */
	always_comb begin

		// Reset all output to 0 (to cover all combinations)
		// All assignments are non-blocking on purpose
		scd_reset <= 0;
		prev_mode_en <= 0;
		scd_wr_en <= 0;
		scd_cd_en <= 0;
		next_aperture_setting <= 0;
		aperture_setting_en <= 0;
		next_shutter_setting <= 0;
		shutter_setting_en <= 0;

		// Turn on specific signals to overwrite default settings
		if (current_state == ST_IDLE) begin
			scd_reset <= 1;
		end
		
		if (current_state == ST_APERTURE_PRIORITY) begin
			prev_mode_en <= 1;
			// scd_wr_en <= 1;

			shutter_setting_en <= 1;
			next_shutter_setting <= 3'b111 - aperture_setting;
		end

		if (current_state == ST_SHUTTER_PRIORITY) begin
			prev_mode_en <= 1;
			scd_wr_en <= 1;

			aperture_setting_en <= 1;
			next_aperture_setting <= 3'b111 - shutter_setting;
		end

		if (current_state == ST_MANUAL) begin
			prev_mode_en <= 1;
			scd_wr_en <= 1;
		end

		if (current_state == ST_INC_FSTOP) begin
			aperture_setting_en <= 1;
			next_aperture_setting <= aperture_setting + 1;
		end

		if (current_state == ST_DEC_FSTOP) begin
			aperture_setting_en <= 1;
			next_aperture_setting <= aperture_setting - 1;
		end

		if (current_state == ST_INC_SHUTTER) begin
			shutter_setting_en <= 1;
			next_shutter_setting <= shutter_setting + 1;
		end

		if (current_state == ST_DEC_SHUTTER) begin
			shutter_setting_en <= 1;
			next_shutter_setting <= shutter_setting - 1;
		end

		if (current_state == ST_CALC_APERTURE) begin
			/* nothing */
		end

		if (current_state == ST_CALC_SHUTTER) begin
			scd_wr_en <= 1;
		end

		if (current_state == ST_WAIT_SHUTTER) begin
			scd_cd_en <= 1;
		end
	end

	/* Output combination logic */
	always_comb begin
		// Reset all output to 0 to cover all comb cases
		output_data = 0;
		output_data_valid = 0;

		// State based output
		if (current_state == ST_DONE) begin
			output_data = sensor_data * aperture_multiplier * scd_cycles;
			output_data_valid = 1;
		end
	end
	
endmodule