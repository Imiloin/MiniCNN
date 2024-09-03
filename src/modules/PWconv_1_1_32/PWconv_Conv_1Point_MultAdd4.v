module PWconv_Conv_1Point_MultAdd4 (  // 4 个数乘加
    input clk,
    input rst_b,
    input en,
    input [0:32-1] data_in,  // 4 INT8 data packed
    input [0:32-1] weight,  // 4 INT8 weight packed
    output reg signed [31:0] data_out
);

    wire signed [7:0] data_in0, data_in1, data_in2, data_in3;
    wire signed [7:0] weight0, weight1, weight2, weight3;
    assign data_in0 = data_in[0:7];
    assign data_in1 = data_in[8:15];
    assign data_in2 = data_in[16:23];
    assign data_in3 = data_in[24:31];
    assign weight0  = weight[0:7];
    assign weight1  = weight[8:15];
    assign weight2  = weight[16:23];
    assign weight3  = weight[24:31];

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            data_out <= 0;
        end else if (en) begin
            data_out <= data_in0 * weight0 + data_in1 * weight1 + data_in2 * weight2 + data_in3 * weight3;
        end else begin
            data_out <= data_out;
        end
    end

endmodule
