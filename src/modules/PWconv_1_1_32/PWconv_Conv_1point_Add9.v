module PWconv_Conv_1point_Add9 (
    input clk,
    input rst_b,
    input en,
    input signed [31:0] data_in0,
    input signed [31:0] data_in1,
    input signed [31:0] data_in2,
    input signed [31:0] data_in3,
    input signed [31:0] data_in4,
    input signed [31:0] data_in5,
    input signed [31:0] data_in6,
    input signed [31:0] data_in7,
    input signed [31:0] bias,
    output reg signed [31:0] data_out
);

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            data_out <= 0;
        end else if (en) begin
            data_out <= data_in0 + data_in1 + data_in2 + data_in3 + data_in4 + data_in5 + data_in6 + data_in7 + bias;
        end else begin
            data_out <= data_out;
        end
    end

endmodule
