module PostProcess_Linear_WeightSelector (
    input clk,
    input rst_b,
    input en,
    input [8:0] iter,
    output signed [7:0] weight0,
    output signed [7:0] weight1
);

    wire [8:0] ADR;
    assign ADR = iter;
    wire [0:15] Q;
    assign weight0 = Q[0:8-1];
    assign weight1 = Q[8:2*8-1];
    asdrlspkb1p64x16cm2sw0_linear_weight linear_weight (
        .Q(Q),
        .ADR(ADR),
        .D(16'h0000),
        .WE(1'b0),
        .ME(en),
        .CLK(clk),
        .TEST1(1'b0),
        .RM(4'b0000),
        .RME(1'b0)
    );

endmodule
