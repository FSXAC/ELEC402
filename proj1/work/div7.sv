/* Clock divider - division by 7 with 50% duty cycle */

module div7(
	input logic clk,
	input logic rst,
	output logic out_clk
);

	logic [2:0] a_state, a_state_next, b_state, b_state_next;

	always_ff(@posedge clk, posedge rst) begin
		if (rst) begin
			a_state <= 3'b000;
		end
	end

endmodule