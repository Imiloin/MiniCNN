// include 16 * Conv_MultAdd_1layer
// cnt pos flow
module Conv_MultAdd (
    input [0:4*77*8-1] input_data0,
    input [0:4*77*8-1] input_data1,
    input [0:4*77*8-1] input_data2,
    input [0:4*77*8-1] input_data3,
    input [0:77*8-1] input_weight,
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,  // 32
    input [3:0] pos_in,  // 9
    output reg [4:0] cnt_out,
    output reg [3:0] pos_out,
    output [0:4*11*32-1] output_data0,
    output [0:4*11*32-1] output_data1,
    output [0:4*11*32-1] output_data2,
    output [0:4*11*32-1] output_data3
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

    ////////////////////// 16 * Conv_MultAdd_1layer  ///////////////////////
    Conv_MultAdd_1layer u_conv_multadd_1layer_0 (
        .input_data(input_data0[0:1*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data0[0:1*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_1 (
        .input_data(input_data0[77*8:2*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data0[11*32:2*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_2 (
        .input_data(input_data0[2*77*8:3*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data0[2*11*32:3*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_3 (
        .input_data(input_data0[3*77*8:4*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data0[3*11*32:4*11*32-1])
    );
    //////////////////////////////// 2 ////////////////////////////////
    Conv_MultAdd_1layer u_conv_multadd_1layer_4 (
        .input_data(input_data1[0:1*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data1[0:1*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_5 (
        .input_data(input_data1[77*8:2*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data1[11*32:2*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_6 (
        .input_data(input_data1[2*77*8:3*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data1[2*11*32:3*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_7 (
        .input_data(input_data1[3*77*8:4*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data1[3*11*32:4*11*32-1])
    );
    //////////////////////////////// 2 ////////////////////////////////
    Conv_MultAdd_1layer u_conv_multadd_1layer_8 (
        .input_data(input_data2[0:1*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data2[0:1*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_9 (
        .input_data(input_data2[77*8:2*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data2[11*32:2*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_10 (
        .input_data(input_data2[2*77*8:3*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data2[2*11*32:3*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_11 (
        .input_data(input_data2[3*77*8:4*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data2[3*11*32:4*11*32-1])
    );
    //////////////////////////////// 3 ////////////////////////////////
    Conv_MultAdd_1layer u_conv_multadd_1layer_12 (
        .input_data(input_data3[0:1*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data3[0:1*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_13 (
        .input_data(input_data3[77*8:2*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data3[11*32:2*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_14 (
        .input_data(input_data3[2*77*8:3*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data3[2*11*32:3*11*32-1])
    );

    Conv_MultAdd_1layer u_conv_multadd_1layer_15 (
        .input_data(input_data3[3*77*8:4*77*8-1]),
        .input_weight(input_weight),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data3[3*11*32:4*11*32-1])
    );

endmodule
