module Conv_BiasSelector (
    input rst_b,
    input clk,
    input [4:0] cnt_in,  // 计数，每3个周期循环,每3个cycle换一次片选
    input en,
    output signed [31:0] select_bias
);

    wire [4:0] ADR;
    assign ADR = cnt_in;

    asdrlspkb1p64x16cm2sw0_conv_bias conv_bias (
        .Q(select_bias),
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
