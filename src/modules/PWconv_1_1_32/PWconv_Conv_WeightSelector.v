module PWconv_Conv_WeightSelector (
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt,
    output [0:32*8-1] selected_weight
);

    // 实例化 2个 weight sram (256 / 128)
    wire [0:128-1] weight0, weight1;
    assign selected_weight = {weight0, weight1};
    wire [4:0] ADR;
    assign ADR = cnt;
    asdrlspkb1p64x16cm2sw0_pwconv_weight pwconv_weight_0 (
        .Q(weight0),
        .ADR(ADR),
        .D(128'h0),
        .WE(1'b0),
        .ME(en),
        .CLK(clk),
        .TEST1(1'b0),
        .RM(4'b0000),
        .RME(1'b0)
    );
    asdrlspkb1p64x16cm2sw0_pwconv_weight pwconv_weight_1 (
        .Q(weight1),
        .ADR(ADR),
        .D(128'h0),
        .WE(1'b0),
        .ME(en),
        .CLK(clk),
        .TEST1(1'b0),
        .RM(4'b0000),
        .RME(1'b0)
    );

endmodule
