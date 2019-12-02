// This is a modified version of the test_fsm.sv from project 1
// CHANGES INCLUDE:
// - Added timescale specification at the top
// - Commented out asserts that acces DUT.ST_...  since those are reduced to bits

`timescale 1ps/1ps

module test_fsm();
	logic clk;
	logic reset;
	logic power_btn;
	logic mode_inc;
	logic mode_dec;
	logic fstop_inc;
	logic fstop_dec;
	logic shutter_inc;
	logic shutter_dec;
	logic shutter_btn;
	logic [15:0] sensor_data;

	logic [15:0] fsm_output;
	logic fsm_output_valid;

	// For simulation debugging
	logic [799:0] current_test;

	fsm DUT(
		.output_data(fsm_output),
		.output_data_valid(fsm_output_valid),
		.*
	);

	// Clock generator
	always #2 clk = ~clk;

	initial begin
		// Initial values
		clk = 1;
		reset = 0;
		power_btn = 0;
		mode_inc = 0;
		mode_dec = 0;
		fstop_inc = 0;
		fstop_dec = 0;
		shutter_inc = 0;
		shutter_dec = 0;
		shutter_btn = 0;
		sensor_data = 0;

		// Offset signals by half clock to avoid confusion
		#3;

		/* TEST: reset */
		current_test = "reset";
		reset = 1;
		#4;
		reset = 0;
		#4;
		reset = 1;
		#4;
		reset = 0;
		#4;
		#20;
		// assert (DUT.current_state == DUT.ST_IDLE);
		// assert (DUT.prev_mode_state == DUT.ST_APERTURE_PRIORITY);
		// $stop;

		/* TEST: power button */
		/* we should see the state go from idle to aperture priority */
		current_test = "power button 1";
		power_btn = 1;
		#4;
		power_btn = 0;
		#20;
		// assert (DUT.current_state == DUT.ST_APERTURE_PRIORITY);
		// $stop;

		/* TEST: power button 2 */
		/* Pressing power button again gets us back to idle */
		current_test = "power button 2";
		power_btn = 1;
		#4;
		power_btn = 0;
		#20;
		// assert (DUT.current_state == DUT.ST_IDLE);
		// $stop;

		/* TEST: IDLE state should ignore inputs */
		current_test = "idle ignore input";
		mode_inc = 1;
		#4;
		// assert (DUT.current_state == DUT.ST_IDLE);
		mode_inc = 0;
		mode_dec = 1;
		#4;
		// assert (DUT.current_state == DUT.ST_IDLE);
		mode_dec = 0;
		fstop_inc = 1;
		#4;
		// assert (DUT.current_state == DUT.ST_IDLE);
		fstop_inc = 0;
		fstop_dec = 1;
		#4;
		// assert (DUT.current_state == DUT.ST_IDLE);
		fstop_dec = 0;
		shutter_inc = 1;
		#4;
		// assert (DUT.current_state == DUT.ST_IDLE);
		shutter_inc = 0;
		shutter_dec = 1;
		#4;
		// assert (DUT.current_state == DUT.ST_IDLE);
		shutter_dec = 0;
		shutter_btn = 1;
		#4;
		// assert (DUT.current_state == DUT.ST_IDLE);
		shutter_btn = 0;
		#20;
		// assert (DUT.current_state == DUT.ST_IDLE);
		// $stop;

		/* TEST: mode increment */
		current_test = "mode increment";
		power_btn = 1;
		#4;
		// assert (DUT.current_state == DUT.ST_APERTURE_PRIORITY);
		power_btn = 0;
		#4;
		mode_inc = 1;
		#20;
		mode_inc = 0;
		#20;
		// assert (DUT.current_state == DUT.ST_MANUAL);
		// $stop;

		/* TEST: mode decrement */
		current_test = "mode decrement";
		mode_dec = 1;
		#20;
		mode_dec = 0;
		#20;
		// assert (DUT.current_state == DUT.ST_APERTURE_PRIORITY);
		// $stop;

		/* TEST: Aperture increment test */
		current_test = "aperture inc test";
		fstop_inc = 1;
		#80;
		fstop_inc = 0;
		#20;
		assert (DUT.aperture_setting == 3'b111);
		// $stop;

		/* TEST: Aperture decrement test */
		current_test = "aperture dec test";
		fstop_dec = 1;
		#80;
		fstop_dec = 0;
		#20;
		assert (DUT.aperture_setting == 3'b000);
		// $stop;

		/* TEST: Shutter increment in aperture mode test (nothing should happen) */
		current_test = "ignore shutter inc test";
		shutter_inc = 1;
		#20;
		shutter_inc = 0;
		#20;
		assert (DUT.aperture_setting == 3'b000);
		assert (DUT.shutter_setting == 3'b111);
		// $stop;

		/* TEST: Shutter decrement in aperture mode test (nothing should happen) */
		current_test = "ignore shutter dec test";
		shutter_dec = 1;
		#20;
		shutter_dec = 0;
		#20;
		assert (DUT.aperture_setting == 3'b000);
		assert (DUT.shutter_setting == 3'b111);
		// $stop;

		/* TEST: switching to shutter priority */
		current_test = "switching to shutter priority";
		mode_inc = 1;
		#4;
		mode_inc = 0;
		#4;
		// assert (DUT.current_state == DUT.ST_SHUTTER_PRIORITY);

		/* TEST: Shutter decrement test */
		current_test = "shutter dec test";
		shutter_dec = 1;
		#80;
		shutter_dec = 0;
		#20;
		assert (DUT.shutter_setting == 3'b000);
		// $stop;

		/* TEST: Shutter increment test */
		current_test = "shutter inc test";
		shutter_inc = 1;
		#80;
		shutter_inc = 0;
		#20;
		assert (DUT.shutter_setting == 3'b111);
		// $stop;

		/* TEST: Aperture increment in shutter mode test (nothing should happen) */
		current_test = "ignore aperture inc test";
		fstop_inc = 1;
		#20;
		fstop_inc = 0;
		#20;
		assert (DUT.aperture_setting == 3'b000);
		assert (DUT.shutter_setting == 3'b111);
		// $stop;

		/* TEST: Aperture decrement in shutter mode test (nothing should happen) */
		current_test = "ignore aperture dec test";
		fstop_dec = 1;
		#20;
		fstop_dec = 0;
		#20;
		assert (DUT.aperture_setting == 3'b000);
		assert (DUT.shutter_setting == 3'b111);
		// $stop;

		/* TEST: Switch to Manual mode */
		current_test = "switch to manual mode test";
		mode_inc = 1;
		#4;
		mode_inc = 0;
		#4;
		// assert (DUT.current_state == DUT.ST_MANUAL);

		/* TEST: set every setting to 000 */
		current_test = "set aperture & shutter to 0";
		shutter_dec = 1;
		#80;
		shutter_dec = 0;
		#4;
		assert (DUT.aperture_setting == 3'b000);
		assert (DUT.shutter_setting == 3'b000);

		/* TEST: manul mode test */
		current_test = "manual mode test";
		fstop_inc = 1;
		#4;
		fstop_inc = 0;
		#4;
		shutter_inc = 1;
		#4;
		shutter_inc = 0;
		#4;
		assert (DUT.aperture_setting == 3'b001);
		assert (DUT.shutter_setting == 3'b001);
		fstop_inc = 1;
		#4;
		fstop_inc = 0;
		#4;
		shutter_inc = 1;
		#4;
		shutter_inc = 0;
		#4;
		assert (DUT.aperture_setting == 3'b010);
		assert (DUT.shutter_setting == 3'b010);
		fstop_dec = 1;
		#40;
		fstop_dec = 0;
		#4;
		shutter_inc = 1;
		#40;
		shutter_inc = 0;
		#4;
		assert (DUT.aperture_setting == 3'b000);
		assert (DUT.shutter_setting == 3'b111);
		#20;
		// $stop;

		/* TEST: taking a manual picture 1: highest setting (highest fstop, fastest shutter, darkest picture) */
		current_test = "manual photo 1";
		fstop_inc = 1;
		#64;
		fstop_inc = 0;
		// assert (DUT.current_state == DUT.ST_MANUAL);
		assert (DUT.aperture_setting == 3'b111);
		assert (DUT.shutter_setting == 3'b111);
		shutter_btn = 1;
		sensor_data = 42;
		#4;
		shutter_btn = 0;
		@(posedge fsm_output_valid); /* Continue waiting until we see output signal posedge */
		#3;
		assert (fsm_output == 84);
		#8;
		// $stop;

		/* TEST: manual photo 2: lowest fstop fastest shutter */
		/* input data is 100, output should be 2,560 */
		current_test = "manual photo 2";
		fstop_dec = 1;
		#64;
		fstop_dec = 0;
		// assert (DUT.current_state == DUT.ST_MANUAL);
		assert (DUT.aperture_setting == 3'b000);
		assert (DUT.shutter_setting == 3'b111);
		shutter_btn = 1;
		sensor_data = 100;
		#4;
		shutter_btn = 0;
		@(posedge fsm_output_valid);
		#3;
		assert (fsm_output == 25600);
		#8;
		// $stop;

		/* TEST: manual photo 2: lowest fstop slowest shutter */
		/* input data is 1, Output should be */
		current_test = "manual photo 3";
		shutter_dec = 1;
		#64;
		shutter_dec = 0;
		// assert (DUT.current_state == DUT.ST_MANUAL);
		assert (DUT.aperture_setting == 3'b000);
		assert (DUT.shutter_setting == 3'b000);
		shutter_btn = 1;
		sensor_data = 1;
		#4;
		shutter_btn = 0;
		@(posedge fsm_output_valid);
		#3;
		assert (fsm_output == 32768); /* 256 * 128 * 1 = 32768 */
		#8;
		// $stop;

		/* TEST: burst mode */
		/* Setting shutter speed to the fastest */
		current_test = "manual 10-burst";
		shutter_inc = 1;
		#64;
		shutter_inc = 0;
		// assert (DUT.current_state == DUT.ST_MANUAL);
		assert (DUT.aperture_setting == 3'b000);
		assert (DUT.shutter_setting == 3'b111);
		shutter_btn = 1;
		for (int i = 1; i <= 10; i = i + 1) begin
			#4;
			sensor_data = i;
			@(posedge fsm_output_valid);
			#3;
			assert (fsm_output == (i * 2 * 128));
		end
		shutter_btn = 0;
		#8;
		// $stop;

		/* TEST: power off and on */
		current_test = "power off and on";
		power_btn = 1;
		#8;
		power_btn = 0;
		#8;
		power_btn = 1;
		#8;
		power_btn = 0;
		#8;
		// assert (DUT.current_state != DUT.ST_IDLE);
		#8;
		// $stop;

		/* TEST: Aperture priority picture 1: min-f-stop */
		current_test = "aperture priority 1: smallest fstop";
		mode_inc = 1;
		#4;
		mode_inc = 0;
		assert (DUT.aperture_setting == 3'b000);
		shutter_btn = 1;
		sensor_data = 1;
		#4;
		shutter_btn = 0;
		@(posedge fsm_output_valid);
		#3;
		assert (fsm_output == 256); /* 128 (ap) * 2 (shutter cycle) * 1 (sensor) = 256 */
		#8;
		// $stop;

		/* TEST: Aperture priority picture 2: small-f-stop */
		current_test = "aperture priority 2: small fstop";
		fstop_inc = 1;
		#4;
		fstop_inc = 0;
		#4;
		assert (DUT.aperture_setting == 3'b001);
		shutter_btn = 1;
		sensor_data = 1;
		#4;
		shutter_btn = 0;
		@(posedge fsm_output_valid);
		#3;
		assert (fsm_output == 256); /* 64 (ap) * 4 (shutter cycle) * 1 (sensor) = 256 */
		#8;
		// $stop;

		/* TEST: Aperture priority picture 3: medium-f-stop */
		current_test = "aperture priority 3: medium fstop";
		fstop_inc = 1;
		#12;
		fstop_inc = 0;
		#4;
		assert (DUT.aperture_setting == 3'b011);
		shutter_btn = 1;
		sensor_data = 1;
		#4;
		shutter_btn = 0;
		@(posedge fsm_output_valid);
		#3;
		assert (fsm_output == 256); /* 16 (ap) * 16 (shutter cycle) * 1 (sensor) = 256 */
		#8;
		// $stop;

		/* TEST: Aperture priority picture 3: larget-f-stop */
		current_test = "aperture priority 4: largest fstop";
		fstop_inc = 1;
		#40;
		fstop_inc = 0;
		#4;
		assert (DUT.aperture_setting == 3'b111);
		shutter_btn = 1;
		sensor_data = 1;
		#4;
		shutter_btn = 0;
		@(posedge fsm_output_valid);
		#3;
		assert (fsm_output == 256); /* 1 (ap) * 256 (shutter cycle) * 1 (sensor) = 256 */
		#8;
		// $stop;

		/* TEST: dial aperture back to largest f-stop */
		current_test = "reset largest aperture";
		fstop_dec = 1;
		#80;
		fstop_dec = 0;
		assert (DUT.aperture_setting == 3'b000);

		/* TEST: burst mode aperture priority */
		current_test = "aperture priority 10-burst";
		// assert (DUT.current_state == DUT.ST_APERTURE_PRIORITY);
		assert (DUT.aperture_setting == 3'b000);
		assert (DUT.shutter_setting == 3'b111);
		shutter_btn = 1;
		for (int i = 1; i <= 10; i = i + 1) begin
			#4;
			sensor_data = i;
			@(posedge fsm_output_valid);
			#3;
			assert (fsm_output == (i * 2 * 128)); /* 2 cycles * 128 aperture mult */
		end
		shutter_btn = 0;
		#8;

		/* TEST: switch mode to shutter priority */
		current_test = "switch to shutter priority";
		mode_inc = 1;
		#4;
		mode_inc = 0;
		#4;
		// assert (DUT.current_state == DUT.ST_SHUTTER_PRIORITY);

		/* TEST: fastest shutter speed */
		current_test = "shutter priority 1: fastest";
		sensor_data = 1;
		assert (DUT.shutter_setting == 3'b111);
		shutter_btn = 1;
		#4;
		shutter_btn = 0;
		@(posedge fsm_output_valid);
		#3;
		assert (fsm_output == 256);
		#8;
		$stop;

		/* TEST: fast shutter speed */
		current_test = "shutter priority 2: fast";
		sensor_data = 1;
		shutter_dec = 1;
		#8;
		shutter_dec = 0;
		assert (DUT.shutter_setting == 3'b110);
		shutter_btn = 1;
		#4;
		shutter_btn = 0;
		@(posedge fsm_output_valid);
		#3;
		assert (fsm_output == 256);
		#8;

		/* TEST: fast shutter speed burst */
		current_test = "shutter priority 3: fast burst";
		assert (DUT.shutter_setting == 3'b110);
		assert (DUT.aperture_setting == 3'b001);
		shutter_btn = 1;
		for (int i = 1; i <= 10; i = i + 1) begin
			#4;
			sensor_data = i;
			@(posedge fsm_output_valid);
			assert (fsm_output == (i * 4 * 64)); /* 4 cycles * 64 aperture mult */
			#4;
			#3;
		end
		shutter_btn = 0;
		#40;

		/* TEST: slowest shutter speed */
		current_test = "shutter priority 4: slowest";
		sensor_data = 1;
		shutter_dec = 1;
		#60;
		shutter_dec = 0;
		assert (DUT.shutter_setting == 3'b000);
		assert (DUT.aperture_setting == 3'b111);
		shutter_btn = 1;
		#4;
		shutter_btn = 0;
		@(posedge fsm_output_valid);
		#3;
		assert (fsm_output == 256);
		#8;

		/* TEST: Power off */
		current_test = "power off";
		power_btn = 1;
		#4;
		power_btn = 0;
		#8;
		// assert (DUT.current_state == DUT.ST_IDLE);

		/* TEST: reset */
		current_test = "reset";
		reset = 1;
		#8;
		reset = 0;
		#20;

		$stop;
	end
endmodule