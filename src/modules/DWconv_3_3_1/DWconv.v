//every cycle use 4*4 *8bit input_data, 1 weight core ,output 2*2 *8bit output_data
//select data/weight/bias -> Mult -> Add -> RescaleReLu(Output)
module DWconv (
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,  // 32
    input [3:0] pos_in,  // 9
    input [0:9*8-1] select_weight,
    input [0:16*8-1] input_data,
    output [4:0] cnt_out,
    output [3:0] pos_out,
    output [0:32*8-1] pwconv_weight,
    output [0:32*8-1] output_data0,
    output [0:32*8-1] output_data1,
    output [0:32*8-1] output_data2,
    output [0:32*8-1] output_data3
);

    // selct data/weight/bias
    wire [0:9*8-1] select_data0;  // group
    wire [0:9*8-1] select_data1;
    wire [0:9*8-1] select_data2;
    wire [0:9*8-1] select_data3;
    wire signed [31:0] select_bias;
    // 输入信号分组
    DWconv_DataGroup u_dwconv_datagroup (
        .input_data(input_data),
        .clk(clk),
        .rst_b(rst_b),
        .select_data0(select_data0),
        .select_data1(select_data1),
        .select_data2(select_data2),
        .select_data3(select_data3)
    );
    // bias选择
    DWconv_BiasSelector u_dwconv_biasselector (
        .rst_b(rst_b),
        .clk(clk),
        .cnt_in(cnt_in),
        .en(en),
        .select_bias(select_bias)
    );

    /////////////////////////////////////////////////////////////
    // MultAdd
    wire [4:0] cnt_multadd;
    wire [3:0] pos_multadd;
    wire [0:2*32-1] data_multadd0;
    wire [0:2*32-1] data_multadd1;
    wire [0:2*32-1] data_multadd2;
    wire [0:2*32-1] data_multadd3;
    DWconv_MultAdd u_dwconv_multadd (
        .input_data0(select_data0),
        .input_data1(select_data1),
        .input_data2(select_data2),
        .input_data3(select_data3),
        .input_weight(select_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt_in),
        .pos_in(pos_in),
        .cnt_out(cnt_multadd),
        .pos_out(pos_multadd),
        .output_data0(data_multadd0),
        .output_data1(data_multadd1),
        .output_data2(data_multadd2),
        .output_data3(data_multadd3)
    );

    // Add
    wire [ 4:0] cnt_add;
    wire [ 3:0] pos_add;
    wire [31:0] data_add0;
    wire [31:0] data_add1;
    wire [31:0] data_add2;
    wire [31:0] data_add3;
    DWconv_Add u_dwconv_add (
        .input_data0(data_multadd0),
        .input_data1(data_multadd1),
        .input_data2(data_multadd2),
        .input_data3(data_multadd3),
        .input_bias(select_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt_multadd),
        .pos_in(pos_multadd),
        .cnt_out(cnt_add),
        .pos_out(pos_add),
        .output_data0(data_add0),
        .output_data1(data_add1),
        .output_data2(data_add2),
        .output_data3(data_add3)
    );

    // RescaleRelu
    wire [4:0] cnt_rescalerelu;
    wire [3:0] pos_rescalerelu;
    wire signed [7:0] data_rescalerelu0;
    wire signed [7:0] data_rescalerelu1;
    wire signed [7:0] data_rescalerelu2;
    wire signed [7:0] data_rescalerelu3;
    DWconv_RescaleReLu u_dwconv_rescalerelu (
        .input_data0(data_add0),
        .input_data1(data_add1),
        .input_data2(data_add2),
        .input_data3(data_add3),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt_add),
        .pos_in(pos_add),
        .cnt_out(cnt_rescalerelu),
        .pos_out(pos_rescalerelu),
        .output_data0(data_rescalerelu0),
        .output_data1(data_rescalerelu1),
        .output_data2(data_rescalerelu2),
        .output_data3(data_rescalerelu3)
    );

    // DWconv_OutputControl
    DWconv_OutputControl u_dwconv_outputcontrol (
        .input_data0(data_rescalerelu0),
        .input_data1(data_rescalerelu1),
        .input_data2(data_rescalerelu2),
        .input_data3(data_rescalerelu3),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt_rescalerelu),
        .pos_in(pos_rescalerelu),
        .cnt_out(cnt_out),
        .pos_out(pos_out),
        .pwconv_weight(pwconv_weight),
        .output_data0(output_data0),
        .output_data1(output_data1),
        .output_data2(output_data2),
        .output_data3(output_data3)
    );

endmodule
