module PWconv(
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,
    input [3:0] pos_in,
    input [0:32*8-1] pwconv_weight,
    input [0:32*8-1] data_in0,
    input [0:32*8-1] data_in1,
    input [0:32*8-1] data_in2,
    input [0:32*8-1] data_in3,
    output [4:0] cnt_out,
    output [3:0] pos_out,
    output signed [7:0] data_out0,
    output signed [7:0] data_out1,
    output signed [7:0] data_out2,
    output signed [7:0] data_out3
);

    wire [4:0] cnt_datacontroller;
    wire [3:0] pos_datacontroller;
    wire signed [0:32*8-1] data_datacontroller0;
    wire signed [0:32*8-1] data_datacontroller1;
    wire signed [0:32*8-1] data_datacontroller2;
    wire signed [0:32*8-1] data_datacontroller3;
    PWconv_DataController u_pwconv_data_controller(
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .cnt_in(cnt_in),
       .pos_in(pos_in),
       .data_in0(data_in0),
       .data_in1(data_in1),
       .data_in2(data_in2),
       .data_in3(data_in3),
       .cnt_out(cnt_datacontroller),
       .pos_out(pos_datacontroller),
       .data_out0(data_datacontroller0),
       .data_out1(data_datacontroller1),
       .data_out2(data_datacontroller2),
       .data_out3(data_datacontroller3)
    );

    wire [4:0] cnt_conv;
    wire [3:0] pos_conv;
    wire signed [31:0] data_conv0;
    wire signed [31:0] data_conv1;
    wire signed [31:0] data_conv2;
    wire signed [31:0] data_conv3;
    PWconv_Conv u_pwconv_conv(
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .cnt_in(cnt_datacontroller),
       .pos_in(pos_datacontroller),
       .weight(pwconv_weight),
       .data_in0(data_datacontroller0),
       .data_in1(data_datacontroller1),
       .data_in2(data_datacontroller2),
       .data_in3(data_datacontroller3),
       .cnt_out(cnt_conv),
       .pos_out(pos_conv),
       .data_out0(data_conv0),
       .data_out1(data_conv1),
       .data_out2(data_conv2),
       .data_out3(data_conv3)
    );

    PWconv_RescaleReLu u_pwconv_rescale_relu(
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .cnt_in(cnt_conv),
       .pos_in(pos_conv),
       .data_in0(data_conv0),
       .data_in1(data_conv1),
       .data_in2(data_conv2),
       .data_in3(data_conv3),
       .cnt_out(cnt_out),
       .pos_out(pos_out),
       .data_out0(data_out0),
       .data_out1(data_out1),
       .data_out2(data_out2),
       .data_out3(data_out3)
    );

endmodule
