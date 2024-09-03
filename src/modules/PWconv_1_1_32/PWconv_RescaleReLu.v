module PWconv_RescaleReLu(  // 2 cycles!
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,
    input [3:0] pos_in,
    input signed [31:0] data_in0,
    input signed [31:0] data_in1,
    input signed [31:0] data_in2,
    input signed [31:0] data_in3,
    output reg [4:0] cnt_out,
    output reg [3:0] pos_out,
    output signed [7:0] data_out0,
    output signed [7:0] data_out1,
    output signed [7:0] data_out2,
    output signed [7:0] data_out3
);

    // 2 层寄存器
    reg [4:0] cnt_mid;
    reg [3:0] pos_mid;
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            cnt_mid <= 0;
            pos_mid <= 0;
            cnt_out <= 0;
            pos_out <= 0;
        end else if (en) begin
            cnt_mid <= cnt_in;
            pos_mid <= pos_in;
            cnt_out <= cnt_mid;
            pos_out <= pos_mid;
        end else begin
            cnt_mid <= cnt_mid;
            pos_mid <= pos_mid;
            cnt_out <= cnt_out;
            pos_out <= pos_out;
        end
    end

    // 4 RescaleReLu 单元
    RescaleReLu #(
        .M0(8'sd69),
        .N (8'd13)
    ) rescalerelu0 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(data_in0),
        .data_out(data_out0)
    );
    RescaleReLu #(
        .M0(8'sd69),
        .N (8'd13)
    ) rescalerelu1 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(data_in1),
        .data_out(data_out1)
    );
    RescaleReLu #(
        .M0(8'sd69),
        .N (8'd13)
    ) rescalerelu2 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(data_in2),
        .data_out(data_out2)
    );
    RescaleReLu #(
        .M0(8'sd69),
        .N (8'd13)
    ) rescalerelu3 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(data_in3),
        .data_out(data_out3)
    );

endmodule
