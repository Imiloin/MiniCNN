module PostProcess_Maxpool (
    input clk,
    input rst_b,
    input en,
    input [8:0] iter_in,  // cnt 和 pos 被转换为 iter
    input signed [7:0] data_in0,
    input signed [7:0] data_in1,
    input signed [7:0] data_in2,
    input signed [7:0] data_in3,
    output reg [8:0] iter_out,
    output reg signed [7:0] data_out
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

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            data_out <= 0;
        end else if (en) begin
            if (data_in0 > data_in1 && data_in0 > data_in2 && data_in0 > data_in3) begin
                data_out <= data_in0;
            end else if (data_in1 > data_in2 && data_in1 > data_in3) begin
                data_out <= data_in1;
            end else if (data_in2 > data_in3) begin
                data_out <= data_in2;
            end else begin
                data_out <= data_in3;
            end
        end else begin
            data_out <= data_out;
        end
    end

endmodule
