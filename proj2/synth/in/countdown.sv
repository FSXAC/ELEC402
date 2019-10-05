/* This module is used for shutter counter
 *
 * Set the counter timer and enable signal to set the start time
 * each clock will tick down once
 * when the timer hits zero, the timer will stop
 * and the output signal "done" will turn HIGH
 *
 * Input signal RESET will reset the counter to its initial state
 */

module countdown(
    input logic clk,
    input logic reset,

    input logic [31:0] wait_cycles,
    input logic write_enable,
    input logic countdown_enable,

    output logic done
);

    // internal flip flop to hold the countdown number
    logic [31:0] count;

    // sequential logic
    always_ff @(posedge clk) begin
        if (reset) begin
            count <= 0;
        end else if (write_enable) begin
            count <= wait_cycles - 1;
        end else if (countdown_enable) begin

            // Decrement count as long as it's not 0
            if (count != 0) begin
                count <= count - 1;
            end
        end else begin
            count <= count;
        end
    end

    // Output logic
    assign done = (count == 0);

endmodule