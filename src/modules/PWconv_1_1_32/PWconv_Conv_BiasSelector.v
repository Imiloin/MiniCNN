module PWconv_Conv_BiasSelector (
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt,
    output signed [31:0] bias
);

    wire [4:0] ADR;
    assign ADR = cnt;
    asdrlspkb1p64x16cm2sw0_pwconv_bias pwconv_bias (
        .Q(bias),
        .ADR(ADR),
        .D(32'h0),
        .WE(1'b0),
        .ME(en),
        .CLK(clk),
        .TEST1(1'b0),
        .RM(4'b0000),
        .RME(1'b0)
    );

endmodule
