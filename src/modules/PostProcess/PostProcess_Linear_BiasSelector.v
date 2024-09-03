module PostProcess_Linear_BiasSelector (
    input clk,
    input rst_b,
    input en,
    output signed [31:0] bias0,
    output signed [31:0] bias1
);

    assign bias0 = 32'sd1339;
    assign bias1 = -32'sd2337;

endmodule
