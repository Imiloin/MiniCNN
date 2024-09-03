//include 16 * Conv_Add2nd_1layer
//cnt pos flow
module Conv_Add2nd (
    input [0:4*11*32-1] input_data0,
    input [0:4*11*32-1] input_data1,
    input [0:4*11*32-1] input_data2,
    input [0:4*11*32-1] input_data3,
    input signed [31:0] input_bias,
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,  // 32
    input [3:0] pos_in,  // 9
    output reg [4:0] cnt_out,
    output reg [3:0] pos_out,
    output [0:16*32-1] output_data0,  // 0 2 4 6
    output [0:16*32-1] output_data1  // 1 3 5 7
);

    //cnt flow
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            cnt_out <= 0;
        end else begin
            if (en) cnt_out <= cnt_in;
            else cnt_out <= cnt_out;
        end
    end

    //pos flow
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            pos_out <= 0;
        end else begin
            if (en) pos_out <= pos_in;
            else pos_out <= pos_out;
        end
    end

    ////////////////////// 16 * Conv_Add2nd_1layer  ///////////////////////
    Conv_Add2nd_1layer u_conv_add2nd_1layer_0 (
        .input_data(input_data0[0:11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[0:32-1]),
        .output_data1(output_data1[0:32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_1 (
        .input_data(input_data0[11*32:2*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[32:2*32-1]),
        .output_data1(output_data1[32:2*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_2 (
        .input_data(input_data0[2*11*32:3*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[2*32:3*32-1]),
        .output_data1(output_data1[2*32:3*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_3 (
        .input_data(input_data0[3*11*32:4*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[3*32:4*32-1]),
        .output_data1(output_data1[3*32:4*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_4 (
        .input_data(input_data1[0:11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[4*32:5*32-1]),
        .output_data1(output_data1[4*32:5*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_5 (
        .input_data(input_data1[11*32:2*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[5*32:6*32-1]),
        .output_data1(output_data1[5*32:6*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_6 (
        .input_data(input_data1[2*11*32:3*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[6*32:7*32-1]),
        .output_data1(output_data1[6*32:7*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_7 (
        .input_data(input_data1[3*11*32:4*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[7*32:8*32-1]),
        .output_data1(output_data1[7*32:8*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_8 (
        .input_data(input_data2[0:11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[8*32:9*32-1]),
        .output_data1(output_data1[8*32:9*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_9 (
        .input_data(input_data2[11*32:2*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[9*32:10*32-1]),
        .output_data1(output_data1[9*32:10*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_10 (
        .input_data(input_data2[2*11*32:3*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[10*32:11*32-1]),
        .output_data1(output_data1[10*32:11*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_11 (
        .input_data(input_data2[3*11*32:4*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[11*32:12*32-1]),
        .output_data1(output_data1[11*32:12*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_12 (
        .input_data(input_data3[0:11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[12*32:13*32-1]),
        .output_data1(output_data1[12*32:13*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_13 (
        .input_data(input_data3[11*32:2*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[13*32:14*32-1]),
        .output_data1(output_data1[13*32:14*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_14 (
        .input_data(input_data3[2*11*32:3*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[14*32:15*32-1]),
        .output_data1(output_data1[14*32:15*32-1])
    );

    Conv_Add2nd_1layer u_conv_add2nd_1layer_15 (
        .input_data(input_data3[3*11*32:4*11*32-1]),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data0(output_data0[15*32:16*32-1]),
        .output_data1(output_data1[15*32:16*32-1])
    );

endmodule
