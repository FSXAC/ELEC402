module dff(d, q, en, clk, rst);
    input logic d;
    input logic en, clk, rst;
    output logic q;

    always_ff @(posedge clk, posedge rst) begin
        q <= rst ? 0 : (en ? d : q);
    end
endmodule

module dffs(d, q, en, clk, rst);
    parameter WIDTH = 32;

    input logic [WIDTH-1:0] d;
    input logic en, clk, rst;
    output logic [WIDTH-1:0] q;

    always_ff @(posedge clk, posedge rst) begin
        q <= rst ? 0 : (en ? d : q);
    end
endmodule