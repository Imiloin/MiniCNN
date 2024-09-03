module RescaleReLu #(
    // Rescale parameters, modify these for different layers
    parameter [7:0] M0 = 8'sd59,
    parameter [7:0] N  = 8'd11
) (
    input rst_b,
    input clk,
    input en,
    input signed [31:0] data_in,
    output signed [7:0] data_out
);
    
    wire signed [31:0] data_out_mult;

    RescaleReLu_Mult #(
        .M0(M0)
    ) rescalerelu_mult (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(data_in),
        .data_out(data_out_mult)
    );

    RescaleReLu_ShifterReLu #(
        .N(N)
    ) rescalerelu_shifter_relu (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(data_out_mult),
        .data_out(data_out)
    );

endmodule


// instantiate the module like this:
// RescaleReLu #(
//     .M0(8'sd59),
//     .N(8'd11)
// ) rescalerelu (
//     .rst_b(rst_b),
//     .clk(clk),
//     .en(en),
//     .data_in(data_in),
//     .data_out(data_out)
// );
