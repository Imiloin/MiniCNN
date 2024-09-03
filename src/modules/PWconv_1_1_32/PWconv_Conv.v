module PWconv_Conv(  // 2 cycles!
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,
    input [3:0] pos_in,
    input [0:32*8-1] weight,
    input [0:32*8-1] data_in0,
    input [0:32*8-1] data_in1,
    input [0:32*8-1] data_in2,
    input [0:32*8-1] data_in3,
    output reg [4:0] cnt_out,
    output reg [3:0] pos_out,
    output signed [31:0] data_out0,
    output signed [31:0] data_out1,
    output signed [31:0] data_out2,
    output signed [31:0] data_out3
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

    // bias sram
    wire signed [31:0] bias;
    PWconv_Conv_BiasSelector u_pwconv_biasselector (
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .cnt(cnt_in),
       .bias(bias)
    );

    // 4 1point
    PWconv_Conv_1point u_pwconv_conv_1point_0 (
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .data_in(data_in0),
       .weight(weight),
       .bias(bias),
       .data_out(data_out0)
    );
    PWconv_Conv_1point u_pwconv_conv_1point_1 (
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .data_in(data_in1),
       .weight(weight),
       .bias(bias),
       .data_out(data_out1)
    );
    PWconv_Conv_1point u_pwconv_conv_1point_2 (
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .data_in(data_in2),
       .weight(weight),
       .bias(bias),
       .data_out(data_out2)
    );
    PWconv_Conv_1point u_pwconv_conv_1point_3 (
       .clk(clk),
       .rst_b(rst_b),
       .en(en),
       .data_in(data_in3),
       .weight(weight),
       .bias(bias),
       .data_out(data_out3)
    );

endmodule
