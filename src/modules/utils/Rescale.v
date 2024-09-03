module Rescale #(  // 只 rescale 不 relu
    // Rescale parameters, modify these for different layers
    parameter [7:0] M0 = 8'sd59,
    parameter [7:0] N  = 8'd11
) (
    input rst_b,
    input clk,
    input en,
    input signed [31:0] data_in,
    output signed [7:0] data_out  // signed
);

    wire signed [31:0] data_out_mult;

    RescaleReLu_Mult #(
        .M0(M0)
    ) rescale_mult (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(data_in),
        .data_out(data_out_mult)
    );

    Rescale_Shifter #(
        .N(N)
    ) rescale_shifter (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(data_out_mult),
        .data_out(data_out)
    );

endmodule


// instantiate the module like this:
// Rescale #(
//     .M0(8'd59),
//     .N(8'd11)
// ) rescale (
//     .rst_b(rst_b),
//     .clk(clk),
//     .en(en),
//     .data_in(data_in),
//     .data_out(data_out)
// );
