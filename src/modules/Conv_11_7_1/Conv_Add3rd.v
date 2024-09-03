// include 2 * Conv_Add3rd_1layer
// cnt pos flow

module Conv_Add3rd (
    input [0:16*32-1] input_data0,  // 0 2 4 6
    input [0:16*32-1] input_data1,  // 1 3 5 7
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,  // 32
    input [3:0] pos_in,  // 9
    output reg [4:0] cnt_out,
    output reg [3:0] pos_out,
    output [0:16*32-1] output_data
);

    // cnt flow
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            cnt_out <= 0;
        end else begin
            if (en) cnt_out <= cnt_in;
            else cnt_out <= cnt_out;
        end
    end

    // pos flow
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            pos_out <= 0;
        end else begin
            if (en) pos_out <= pos_in;
            else pos_out <= pos_out;
        end
    end

    // 输入拆分 
    localparam KERNELS = 16;
    wire signed [31:0] data_in0[0:KERNELS-1];
    wire signed [31:0] data_in1[0:KERNELS-1];

    generate
        genvar i;
        for (i = 0; i < KERNELS; i = i + 1) begin : u_conv_add3rd_unpack_input0
            assign data_in0[i][31:0] = input_data0[(32*i):(32*i+31)];
        end
    endgenerate

    generate
        genvar j;
        for (j = 0; j < KERNELS; j = j + 1) begin : u_conv_add3rd_unpack_input1
            assign data_in1[j][31:0] = input_data1[(32*j):(32*j+31)];
        end
    endgenerate

    ////////////////////// 16 * Conv_Add2nd_1layer  ///////////////////////
    Conv_Add3rd_1layer u_conv_add3rd_1layer_0 (
        .input_data0(data_in0[0]),
        .input_data1(data_in1[0]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[0*32:1*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_1 (
        .input_data0(data_in0[1]),
        .input_data1(data_in1[1]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[1*32:2*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_2 (
        .input_data0(data_in0[2]),
        .input_data1(data_in1[2]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[2*32:3*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_3 (
        .input_data0(data_in0[3]),
        .input_data1(data_in1[3]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[3*32:4*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_4 (
        .input_data0(data_in0[4]),
        .input_data1(data_in1[4]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[4*32:5*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_5 (
        .input_data0(data_in0[5]),
        .input_data1(data_in1[5]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[5*32:6*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_6 (
        .input_data0(data_in0[6]),
        .input_data1(data_in1[6]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[6*32:7*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_7 (
        .input_data0(data_in0[7]),
        .input_data1(data_in1[7]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[7*32:8*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_8 (
        .input_data0(data_in0[8]),
        .input_data1(data_in1[8]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[8*32:9*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_9 (
        .input_data0(data_in0[9]),
        .input_data1(data_in1[9]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[9*32:10*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_10 (
        .input_data0(data_in0[10]),
        .input_data1(data_in1[10]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[10*32:11*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_11 (
        .input_data0(data_in0[11]),
        .input_data1(data_in1[11]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[11*32:12*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_12 (
        .input_data0(data_in0[12]),
        .input_data1(data_in1[12]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[12*32:13*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_13 (
        .input_data0(data_in0[13]),
        .input_data1(data_in1[13]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[13*32:14*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_14 (
        .input_data0(data_in0[14]),
        .input_data1(data_in1[14]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[14*32:15*32-1])
    );

    Conv_Add3rd_1layer u_conv_add3rd_1layer_15 (
        .input_data0(data_in0[15]),
        .input_data1(data_in1[15]),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data[15*32:16*32-1])
    );

endmodule
