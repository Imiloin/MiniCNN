// 2* Conv_Add2nd_cell

module Conv_Add2nd_1layer (
    input [0:11*32-1] input_data,
    input signed [31:0] input_bias,
    input clk,
    input rst_b,
    input en,
    output wire [0:31] output_data0,
    output wire [0:31] output_data1
);

    localparam KERNELS = 11;
    wire signed [31:0] data_in[0:KERNELS-1];

    generate
        genvar i;
        for (i = 0; i < KERNELS; i = i + 1) begin : u_conv_add2nd_unpack_input
            assign data_in[i][31:0] = input_data[(32*i):(32*i+31)];
        end
    endgenerate

    Conv_Add2nd_cell conv_add2nd_cell0 (
        .input_data0(data_in[0]),
        .input_data1(data_in[1]),
        .input_data2(data_in[2]),
        .input_data3(data_in[3]),
        .input_data4(data_in[4]),
        .input_data5(data_in[5]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data0)
    );

    Conv_Add2nd_cell conv_add2nd_cell1 (
        .input_data0(data_in[6]),
        .input_data1(data_in[7]),
        .input_data2(data_in[8]),
        .input_data3(data_in[9]),
        .input_data4(data_in[10]),
        .input_data5(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data1)
    );

endmodule
