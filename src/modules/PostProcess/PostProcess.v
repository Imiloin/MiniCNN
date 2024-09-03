module PostProcess (
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,
    input [3:0] pos_in,
    input signed [7:0] data_in0,
    input signed [7:0] data_in1,
    input signed [7:0] data_in2,
    input signed [7:0] data_in3,
    output valid,
    output [8:0] iter_out,
    output [31:0] float_out0,
    output [31:0] float_out1
);

    wire [8:0] iter_in;
    assign iter_in = {pos_in, cnt_in};

    // maxpool
    wire [8:0] iter_maxpool;
    wire signed [7:0] data_maxpool;
    PostProcess_Maxpool u_postprocess_maxpool (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .iter_in(iter_in),
        .data_in0(data_in0),
        .data_in1(data_in1),
        .data_in2(data_in2),
        .data_in3(data_in3),
        .iter_out(iter_maxpool),
        .data_out(data_maxpool)
    );
    // weight
    wire signed [7:0] weight0;
    wire signed [7:0] weight1;
    PostProcess_Linear_WeightSelector u_linear_weightselector (
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .iter(iter_in),
       .weight0(weight0),
       .weight1(weight1)
    );
    // bias
    wire signed [31:0] bias0;
    wire signed [31:0] bias1;
    PostProcess_Linear_BiasSelector u_linear_biasselector (
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .bias0(bias0),
       .bias1(bias1)
    );

    // linear
    wire [8:0] iter_linear;
    wire signed [31:0] data_linear0;
    wire signed [31:0] data_linear1;
    PostProcess_Linear u_postprocess_linear (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .iter_in(iter_maxpool),
        .weight0(weight0),
        .weight1(weight1),
        .bias0(bias0),
        .bias1(bias1),
        .data_in(data_maxpool),
        .iter_out(iter_linear),
        .data_out0(data_linear0),
        .data_out1(data_linear1)
    );

    // rescalerelu
    wire [8:0] iter_rescale;
    wire signed [7:0] data_rescale0;
    wire signed [7:0] data_rescale1;
    PostProcess_Rescale u_postprocess_rescale (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .iter_in(iter_linear),
        .data_in0(data_linear0),
        .data_in1(data_linear1),
        .iter_out(iter_rescale),
        .data_out0(data_rescale0),
        .data_out1(data_rescale1)
    );

    // sigmoid
    PostProcess_Sigmoid u_postprocess_sigmoid (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .iter_in(iter_rescale),
        .data_in0(data_rescale0),
        .data_in1(data_rescale1),
        .iter_out(iter_out),  /////// can be removed
        .valid(valid),
        .float32_output0(float_out0),
        .float32_output1(float_out1)
    );

endmodule
