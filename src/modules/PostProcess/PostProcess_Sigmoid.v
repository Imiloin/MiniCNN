module PostProcess_Sigmoid (  // use lookup table to implement sigmoid
    input clk,
    input rst_b,
    input en,
    input [8:0] iter_in,  // cnt 和 pos 被转换为 iter
    input [7:0] data_in0,  // 此处不用 signed，但 python 脚本中要处理好顺序（实际这个数据应该是 signed，故正数在前，负数在后）
    input [7:0] data_in1,
    output reg [8:0] iter_out,  /////// can be removed
    output reg valid,
    output [31:0] float32_output0,
    output [31:0] float32_output1
);

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            iter_out <= 0;
        end else if (en) begin
            iter_out <= iter_in;
        end else begin
            iter_out <= iter_out;
        end
    end

    parameter MAX_ITER = 288;  // 最大迭代次数
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            valid <= 0;
        end else if (en) begin
            if (iter_in == (MAX_ITER - 1)) begin
                valid <= 1;
            end else begin
                valid <= 0;
            end
        end else begin
            valid <= valid;
        end
    end

    wire ME;
    assign ME = iter_in == (MAX_ITER - 1);  // 只在最后一次迭代输出结果，其他时候关闭 sram 输出
    // 实例化 asdrlspkb1p64x16cm2sw0
    asdrlspkb1p64x16cm2sw0_sigmoid sigmoid0 (
        .Q(float32_output0),
        .ADR(data_in0),
        .D(32'h00000000),
        .WE(1'b0),
        .ME(ME),
        .CLK(clk),
        .TEST1(1'b0),
        .RM(4'b0000),
        .RME(1'b0)
    );
    asdrlspkb1p64x16cm2sw0_sigmoid sigmoid1 (
        .Q(float32_output1),
        .ADR(data_in1),
        .D(32'h00000000),
        .WE(1'b0),
        .ME(ME),
        .CLK(clk),
        .TEST1(1'b0),
        .RM(4'b0000),
        .RME(1'b0)
    );

endmodule
