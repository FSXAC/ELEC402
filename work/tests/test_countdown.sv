module test_countdown();
    reg unsigned [31:0] count;
    reg clk;
    reg reset;
    reg wr_en;
    reg cd_en;

    // DUT output
    reg done;

    countdown DUT(
        .clk(clk),
        .reset(reset),
        .wait_cycles(count),
        .write_enable(wr_en),
        .countdown_enable(cd_en),
        .done(done)
    );

    // Clock generator
    always #1 clk = ~clk;

    initial begin
        // Initial value of clock
        clk = 1'b1;

        // Offset signals by half clock to avoid confusion
        #1;

        // Set up the countdown to do 10 clock cycles
        reset = 1'b1;
        count = 10;
        #2;

        reset = 1'b0;
        wr_en = 1'b1;
        #2;

        wr_en = 1'b0;
        cd_en = 1'b1;
        #20;

        if (done == 1) begin
            cd_en = 1'b0;
            #20;
            $stop;
        end
    end
endmodule