//every cycle use 14*10 *8bit input_data, 1 weight core ,output 4*4 *8bit output_data
//select data/weight/bias -> MultAdd -> Add2nd ->  Add3rd -> RescaleReLu(Output)
// 没有cnt和pos产生的部分，应该是放在这一层的外面
//包括从30*10里选择14*10的输入信号
module Conv (
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,  // 32
    input [3:0] pos_in,  // 9
    input [0:30*10*8-1] mem,  // 30*10*8
    output [4:0] cnt_out,
    output [3:0] pos_out,
    output [0:9*8-1] dwconv_weight,
    output wire [0:16*8-1] output_data
);

    // selct data/weight/bias
    wire [4:0] cnt_selector;
    wire [3:0] pos_selector;
    wire [0:14*10*8-1] select_data;
    wire [0:4*77*8-1] select_data0;  // group
    wire [0:4*77*8-1] select_data1;
    wire [0:4*77*8-1] select_data2;
    wire [0:4*77*8-1] select_data3;
    wire [0:77*8-1] select_weight;
    wire signed [31:0] select_bias;
    // 输入信号选择和分组
    Conv_DataSelector u_conv_dataselector (
        .mem(mem),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .cnt_in(cnt_in),
        .pos_in(pos_in),
        .cnt_out(cnt_selector),
        .pos_out(pos_selector),
        .select_data(select_data)
    );
    Conv_DataGroup u_conv_datagroup (
        .input_data(select_data),
        .clk(clk),
        .rst_b(rst_b),
        .select_data0(select_data0),
        .select_data1(select_data1),
        .select_data2(select_data2),
        .select_data3(select_data3)
    );
    // weight选择
    Conv_WeightSelector u_conv_weightselector (
        .rst_b(rst_b),
        .clk(clk),
        .cnt_in(cnt_in),
        .en(en),
        .select_weight(select_weight)
    );

    /////////////////////////////////////////////////////////////
    // Multadd
    wire [4:0] cnt_multadd;
    wire [3:0] pos_multadd;
    wire [0:4*11*32-1] data_multadd0;
    wire [0:4*11*32-1] data_multadd1;
    wire [0:4*11*32-1] data_multadd2;
    wire [0:4*11*32-1] data_multadd3;
    Conv_MultAdd u_conv_multadd (
        .input_data0(select_data0),
        .input_data1(select_data1),
        .input_data2(select_data2),
        .input_data3(select_data3),
        .input_weight(select_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt_selector),
        .pos_in(pos_selector),
        .cnt_out(cnt_multadd),
        .pos_out(pos_multadd),
        .output_data0(data_multadd0),
        .output_data1(data_multadd1),
        .output_data2(data_multadd2),
        .output_data3(data_multadd3)
    );
    // bias选择
    Conv_BiasSelector u_conv_biasselector (
        .rst_b(rst_b),
        .clk(clk),
        .cnt_in(cnt_selector),
        .en(en),
        .select_bias(select_bias)
    );

    // Add2nd
    wire [4:0] cnt_add2nd;
    wire [3:0] pos_add2nd;
    wire [0:16*32-1] data_add2nd0;
    wire [0:16*32-1] data_add2nd1;
    Conv_Add2nd u_conv_add2nd (
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
        .cnt_out(cnt_add2nd),
        .pos_out(pos_add2nd),
        .output_data0(data_add2nd0),
        .output_data1(data_add2nd1)
    );

    // Add3rd
    wire [4:0] cnt_add3rd;
    wire [3:0] pos_add3rd;
    wire [0:16*32-1] data_add3rd;
    Conv_Add3rd u_conv_add3rd (
        .input_data0(data_add2nd0),
        .input_data1(data_add2nd1),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt_add2nd),
        .pos_in(pos_add2nd),
        .cnt_out(cnt_add3rd),
        .pos_out(pos_add3rd),
        .output_data(data_add3rd)
    );

    // Activation
    Conv_Activation u_conv_activation (
        .input_data(data_add3rd),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .cnt_in(cnt_add3rd),
        .pos_in(pos_add3rd),
        .cnt_out(cnt_out),
        .pos_out(pos_out),
        .dwconv_weight(dwconv_weight),
        .output_data(output_data)
    );

endmodule
