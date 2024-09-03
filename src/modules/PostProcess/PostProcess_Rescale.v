module PostProcess_Rescale (  // 2 cycles!
    input clk,
    input rst_b,
    input en,
    input [8:0] iter_in,  // cnt 和 pos 被转换为 iter
    input signed [31:0] data_in0,
    input signed [31:0] data_in1,
    output reg [8:0] iter_out,
    output signed [7:0] data_out0,
    output signed [7:0] data_out1
);

    // 2 层寄存器
    reg [8:0] iter_mid;
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            iter_mid <= 0;
            iter_out <= 0;
        end else if (en) begin
            iter_mid <= iter_in;
            iter_out <= iter_mid;
        end else begin
            iter_mid <= iter_mid;
            iter_out <= iter_out;
        end
    end

    // 2 Rescale 单元
    Rescale #(
        .M0(8'sd11),
        .N (8'd15)
    ) rescale0 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(data_in0),
        .data_out(data_out0)
    );
    Rescale #(
        .M0(8'sd11),
        .N (8'd15)
    ) rescale1 (
        .rst_b(rst_b),
        .clk(clk),
        .en(en),
        .data_in(data_in1),
        .data_out(data_out1)
    );

endmodule
