module CNN (  // 不含 memory
    input clk,
    input rst_b,
    input en,
    input [0:30*10*8-1] mem,
    output valid,
    output [31:0] float_out0,
    output [31:0] float_out1
);

    // controller
    wire [4:0] cnt;
    wire [3:0] pos;
    CNN_DataController u_cnn_data_controller (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt(cnt),
        .pos(pos)
    );

    // conv layer
    wire [4:0] cnt_conv;
    wire [3:0] pos_conv;
    wire [0:16*8-1] data_conv;
    wire [0:9*8-1] dwconv_weight;
    Conv u_cnn_conv (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt),
        .pos_in(pos),
        .mem(mem),
        .cnt_out(cnt_conv),
        .pos_out(pos_conv),
        .dwconv_weight(dwconv_weight),
        .output_data(data_conv)
    );

    // dwconv layer
    wire [4:0] cnt_dwconv;
    wire [3:0] pos_dwconv;
    wire [0:32*8-1] data_dwconv0;
    wire [0:32*8-1] data_dwconv1;
    wire [0:32*8-1] data_dwconv2;
    wire [0:32*8-1] data_dwconv3;
    wire [0:32*8-1] pwconv_weight;
    DWconv u_cnn_dwconv (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt_conv),
        .pos_in(pos_conv),
        .select_weight(dwconv_weight),
        .input_data(data_conv),
        .cnt_out(cnt_dwconv),
        .pos_out(pos_dwconv),
        .pwconv_weight(pwconv_weight),
        .output_data0(data_dwconv0),
        .output_data1(data_dwconv1),
        .output_data2(data_dwconv2),
        .output_data3(data_dwconv3)
    );

    // pwconv layer
    wire [4:0] cnt_pwconv;
    wire [3:0] pos_pwconv;
    wire signed [7:0] data_pwconv0;
    wire signed [7:0] data_pwconv1;
    wire signed [7:0] data_pwconv2;
    wire signed [7:0] data_pwconv3;
    PWconv u_cnn_pwconv (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt_dwconv),
        .pos_in(pos_dwconv),
        .pwconv_weight(pwconv_weight),
        .data_in0(data_dwconv0),
        .data_in1(data_dwconv1),
        .data_in2(data_dwconv2),
        .data_in3(data_dwconv3),
        .cnt_out(cnt_pwconv),
        .pos_out(pos_pwconv),
        .data_out0(data_pwconv0),
        .data_out1(data_pwconv1),
        .data_out2(data_pwconv2),
        .data_out3(data_pwconv3)
    );

    // post-processing
    wire [8:0] iter_out;
    PostProcess u_cnn_postprocess (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt_pwconv),
        .pos_in(pos_pwconv),
        .data_in0(data_pwconv0),
        .data_in1(data_pwconv1),
        .data_in2(data_pwconv2),
        .data_in3(data_pwconv3),
        .valid(valid),
        .iter_out(iter_out),
        .float_out0(float_out0),
        .float_out1(float_out1)
    );

endmodule
