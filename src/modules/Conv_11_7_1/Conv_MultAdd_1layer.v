// 1层卷积运算, include 11*multadd_cell(7个数乘加)
// 77*input --> 11*output

module Conv_MultAdd_1layer (
    input [0:77*8-1] input_data,
    input [0:77*8-1] input_weight,  // 一层 11*7个8 Bit数
    input rst_b,
    input clk,
    input en,
    output wire [0:11*32-1] output_data
);

    // 输入拆分 
    localparam WORDS = 77;
    wire signed [7:0] data_in  [0:WORDS-1];
    wire signed [7:0] weight_in[0:WORDS-1];

    generate
        genvar i;
        for (i = 0; i < WORDS; i = i + 1) begin : u_conv_multadd_unpack_input0
            assign data_in[i][7:0] = input_data[(8*i):(8*i+7)];
        end
    endgenerate

    generate
        genvar j;
        for (j = 0; j < WORDS; j = j + 1) begin : u_conv_multadd_unpack_input1
            assign weight_in[j][7:0] = input_weight[(8*j):(8*j+7)];
        end
    endgenerate

    // 11 * multadd(7 data)
    Conv_MultAdd_cell u_conv_multadd_cell0 (
        .input_data0(data_in[0]),
        .input_data1(data_in[1]),
        .input_data2(data_in[2]),
        .input_data3(data_in[3]),
        .input_data4(data_in[4]),
        .input_data5(data_in[5]),
        .input_data6(data_in[6]),
        .input_weight0(weight_in[0]),
        .input_weight1(weight_in[1]),
        .input_weight2(weight_in[2]),
        .input_weight3(weight_in[3]),
        .input_weight4(weight_in[4]),
        .input_weight5(weight_in[5]),
        .input_weight6(weight_in[6]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[0:32-1])
    );
    Conv_MultAdd_cell u_conv_multadd_cell1 (
        .input_data0(data_in[7]),
        .input_data1(data_in[8]),
        .input_data2(data_in[9]),
        .input_data3(data_in[10]),
        .input_data4(data_in[11]),
        .input_data5(data_in[12]),
        .input_data6(data_in[13]),
        .input_weight0(weight_in[7]),
        .input_weight1(weight_in[8]),
        .input_weight2(weight_in[9]),
        .input_weight3(weight_in[10]),
        .input_weight4(weight_in[11]),
        .input_weight5(weight_in[12]),
        .input_weight6(weight_in[13]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[32:2*32-1])
    );

    Conv_MultAdd_cell u_conv_multadd_cell2 (
        .input_data0(data_in[14]),
        .input_data1(data_in[15]),
        .input_data2(data_in[16]),
        .input_data3(data_in[17]),
        .input_data4(data_in[18]),
        .input_data5(data_in[19]),
        .input_data6(data_in[20]),
        .input_weight0(weight_in[14]),
        .input_weight1(weight_in[15]),
        .input_weight2(weight_in[16]),
        .input_weight3(weight_in[17]),
        .input_weight4(weight_in[18]),
        .input_weight5(weight_in[19]),
        .input_weight6(weight_in[20]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[2*32:3*32-1])
    );

    Conv_MultAdd_cell u_conv_multadd_cell3 (
        .input_data0(data_in[21]),
        .input_data1(data_in[22]),
        .input_data2(data_in[23]),
        .input_data3(data_in[24]),
        .input_data4(data_in[25]),
        .input_data5(data_in[26]),
        .input_data6(data_in[27]),
        .input_weight0(weight_in[21]),
        .input_weight1(weight_in[22]),
        .input_weight2(weight_in[23]),
        .input_weight3(weight_in[24]),
        .input_weight4(weight_in[25]),
        .input_weight5(weight_in[26]),
        .input_weight6(weight_in[27]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[3*32:4*32-1])
    );

    Conv_MultAdd_cell u_conv_multadd_cell4 (
        .input_data0(data_in[28]),
        .input_data1(data_in[29]),
        .input_data2(data_in[30]),
        .input_data3(data_in[31]),
        .input_data4(data_in[32]),
        .input_data5(data_in[33]),
        .input_data6(data_in[34]),
        .input_weight0(weight_in[28]),
        .input_weight1(weight_in[29]),
        .input_weight2(weight_in[30]),
        .input_weight3(weight_in[31]),
        .input_weight4(weight_in[32]),
        .input_weight5(weight_in[33]),
        .input_weight6(weight_in[34]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[4*32:5*32-1])
    );

    Conv_MultAdd_cell u_conv_multadd_cell5 (
        .input_data0(data_in[35]),
        .input_data1(data_in[36]),
        .input_data2(data_in[37]),
        .input_data3(data_in[38]),
        .input_data4(data_in[39]),
        .input_data5(data_in[40]),
        .input_data6(data_in[41]),
        .input_weight0(weight_in[35]),
        .input_weight1(weight_in[36]),
        .input_weight2(weight_in[37]),
        .input_weight3(weight_in[38]),
        .input_weight4(weight_in[39]),
        .input_weight5(weight_in[40]),
        .input_weight6(weight_in[41]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[5*32:6*32-1])
    );

    Conv_MultAdd_cell u_conv_multadd_cell6 (
        .input_data0(data_in[42]),
        .input_data1(data_in[43]),
        .input_data2(data_in[44]),
        .input_data3(data_in[45]),
        .input_data4(data_in[46]),
        .input_data5(data_in[47]),
        .input_data6(data_in[48]),
        .input_weight0(weight_in[42]),
        .input_weight1(weight_in[43]),
        .input_weight2(weight_in[44]),
        .input_weight3(weight_in[45]),
        .input_weight4(weight_in[46]),
        .input_weight5(weight_in[47]),
        .input_weight6(weight_in[48]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[6*32:7*32-1])
    );

    Conv_MultAdd_cell u_conv_multadd_cell7 (
        .input_data0(data_in[49]),
        .input_data1(data_in[50]),
        .input_data2(data_in[51]),
        .input_data3(data_in[52]),
        .input_data4(data_in[53]),
        .input_data5(data_in[54]),
        .input_data6(data_in[55]),
        .input_weight0(weight_in[49]),
        .input_weight1(weight_in[50]),
        .input_weight2(weight_in[51]),
        .input_weight3(weight_in[52]),
        .input_weight4(weight_in[53]),
        .input_weight5(weight_in[54]),
        .input_weight6(weight_in[55]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[7*32:8*32-1])
    );

    Conv_MultAdd_cell u_conv_multadd_cell8 (
        .input_data0(data_in[56]),
        .input_data1(data_in[57]),
        .input_data2(data_in[58]),
        .input_data3(data_in[59]),
        .input_data4(data_in[60]),
        .input_data5(data_in[61]),
        .input_data6(data_in[62]),
        .input_weight0(weight_in[56]),
        .input_weight1(weight_in[57]),
        .input_weight2(weight_in[58]),
        .input_weight3(weight_in[59]),
        .input_weight4(weight_in[60]),
        .input_weight5(weight_in[61]),
        .input_weight6(weight_in[62]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[8*32:9*32-1])
    );

    Conv_MultAdd_cell u_conv_multadd_cell9 (
        .input_data0(data_in[63]),
        .input_data1(data_in[64]),
        .input_data2(data_in[65]),
        .input_data3(data_in[66]),
        .input_data4(data_in[67]),
        .input_data5(data_in[68]),
        .input_data6(data_in[69]),
        .input_weight0(weight_in[63]),
        .input_weight1(weight_in[64]),
        .input_weight2(weight_in[65]),
        .input_weight3(weight_in[66]),
        .input_weight4(weight_in[67]),
        .input_weight5(weight_in[68]),
        .input_weight6(weight_in[69]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[9*32:10*32-1])
    );

    Conv_MultAdd_cell u_conv_multadd_cell10 (
        .input_data0(data_in[70]),
        .input_data1(data_in[71]),
        .input_data2(data_in[72]),
        .input_data3(data_in[73]),
        .input_data4(data_in[74]),
        .input_data5(data_in[75]),
        .input_data6(data_in[76]),
        .input_weight0(weight_in[70]),
        .input_weight1(weight_in[71]),
        .input_weight2(weight_in[72]),
        .input_weight3(weight_in[73]),
        .input_weight4(weight_in[74]),
        .input_weight5(weight_in[75]),
        .input_weight6(weight_in[76]),
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .output_data(output_data[10*32:11*32-1])
    );

endmodule
