// include 16 * RescaleReLu and DW weight_selecetor
// cnt pos flow
module Conv_Activation (
    input [0:16*32-1] input_data,
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,  // 32
    input [3:0] pos_in,  // 9
    output reg [4:0] cnt_out,
    output reg [3:0] pos_out,
    output [0:9*8-1] dwconv_weight,
    output [0:16*8-1] output_data
);
    // 内部有2层寄存器，需要中间变量
    reg [4:0] cnt_mid;
    reg [3:0] pos_mid;
    // cnt flow
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            cnt_out <= 0;
            cnt_mid <= 0;
        end else begin
            if (en) begin
                cnt_out <= cnt_mid;
                cnt_mid <= cnt_in;
            end else begin
                cnt_out <= cnt_out;
                cnt_mid <= cnt_mid;
            end
        end
    end

    // pos flow
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            pos_out <= 0;
            pos_mid <= 0;
        end else begin
            if (en) begin
                pos_out <= pos_mid;
                pos_mid <= pos_in;
            end else begin
                pos_out <= pos_out;
                pos_mid <= pos_mid;
            end
        end
    end

    // DWconv weight选择
    DWconv_WeightSelector u_dwconv_weightselector (
        .rst_b(rst_b),
        .clk(clk),
        .cnt_in(cnt_mid),
        .en(en),
        .select_weight(dwconv_weight)
    );

    // 输入拆分 
    localparam KERNELS = 16;
    wire signed [31:0] rescalerelu_in [0:KERNELS-1];
    wire signed [ 7:0] rescalerelu_out[0:KERNELS-1];

    generate
        genvar i;
        for (
            i = 0; i < KERNELS; i = i + 1
        ) begin : u_conv_activation_unpack_input
            assign rescalerelu_in[i][31:0] = input_data[(32*i):(32*i+31)];
        end
    endgenerate

    generate
        genvar j;
        for (
            j = 0; j < KERNELS; j = j + 1
        ) begin : u_conv_activation_pack_output
            assign output_data[(8*j):(8*j+7)] = rescalerelu_out[j][7:0];
        end
    endgenerate

    ////////////////////// 16 * RescaleReLu  ///////////////////////
    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu0 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[0]),
        .data_out(rescalerelu_out[0])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu1 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[1]),
        .data_out(rescalerelu_out[1])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu2 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[2]),
        .data_out(rescalerelu_out[2])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu3 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[3]),
        .data_out(rescalerelu_out[3])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu4 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[4]),
        .data_out(rescalerelu_out[4])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu5 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[5]),
        .data_out(rescalerelu_out[5])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu6 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[6]),
        .data_out(rescalerelu_out[6])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu7 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[7]),
        .data_out(rescalerelu_out[7])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu8 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[8]),
        .data_out(rescalerelu_out[8])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu9 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[9]),
        .data_out(rescalerelu_out[9])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu10 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[10]),
        .data_out(rescalerelu_out[10])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu11 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[11]),
        .data_out(rescalerelu_out[11])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu12 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[12]),
        .data_out(rescalerelu_out[12])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu13 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[13]),
        .data_out(rescalerelu_out[13])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu14 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[14]),
        .data_out(rescalerelu_out[14])
    );

    RescaleReLu #(
        .M0(8'sd111),
        .N (8'd14)
    ) u_conv_rescalerelu15 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(rescalerelu_in[15]),
        .data_out(rescalerelu_out[15])
    );

endmodule
