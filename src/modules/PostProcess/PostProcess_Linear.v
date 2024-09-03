module PostProcess_Linear (
    input clk,
    input rst_b,
    input en,
    input [8:0] iter_in,  // cnt 和 pos 被转换为 iter
    input signed [7:0] weight0,
    input signed [7:0] weight1,
    input signed [31:0] bias0,
    input signed [31:0] bias1,
    input signed [7:0] data_in,
    output reg [8:0] iter_out,
    output signed [31:0] data_out0,
    output signed [31:0] data_out1
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

    // multadd
    PostProcess_Linear_1group u_linear_group0 (
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .iter(iter_in),
       .data_in(data_in),
       .weight(weight0),
       .bias(bias0),
       .data_out(data_out0)
    );
    PostProcess_Linear_1group u_linear_group1 (
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .iter(iter_in),
       .data_in(data_in),
       .weight(weight1),
       .bias(bias1),
       .data_out(data_out1)
    );

endmodule
