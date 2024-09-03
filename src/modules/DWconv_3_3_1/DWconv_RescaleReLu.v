//include 4 * RescaleReLu
//cnt pos flow
module DWconv_RescaleReLu (
    input [31:0] input_data0,
    input [31:0] input_data1,
    input [31:0] input_data2,
    input [31:0] input_data3,
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,  // 32
    input [3:0] pos_in,  // 9
    output reg [4:0] cnt_out,
    output reg [3:0] pos_out,
    output signed [7:0] output_data0,
    output signed [7:0] output_data1,
    output signed [7:0] output_data2,
    output signed [7:0] output_data3
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

    ////////////////////// 4 * RescaleReLu  ///////////////////////
    RescaleReLu #(
        .M0(8'sd59),
        .N (8'd11)
    ) u_dwconv_rescalerelu0 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(input_data0),
        .data_out(output_data0)
    );

    RescaleReLu #(
        .M0(8'sd59),
        .N (8'd11)
    ) u_dwconv_rescalerelu1 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(input_data1),
        .data_out(output_data1)
    );

    RescaleReLu #(
        .M0(8'sd59),
        .N (8'd11)
    ) u_dwconv_rescalerelu2 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(input_data2),
        .data_out(output_data2)
    );

    RescaleReLu #(
        .M0(8'sd59),
        .N (8'd11)
    ) u_dwconv_rescalerelu3 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(input_data3),
        .data_out(output_data3)
    );

endmodule
