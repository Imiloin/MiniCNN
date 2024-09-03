module PWconv_DataController (
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,
    input [3:0] pos_in,
    input [0:32*8-1] data_in0,
    input [0:32*8-1] data_in1,
    input [0:32*8-1] data_in2,
    input [0:32*8-1] data_in3,
    output [4:0] cnt_out,
    output reg [3:0] pos_out,
    output reg [0:32*8-1] data_out0,
    output reg [0:32*8-1] data_out1,
    output reg [0:32*8-1] data_out2,
    output reg [0:32*8-1] data_out3
);

    assign cnt_out = cnt_in;  // 仅落后一个 pos 位，因此 cnt_in 与 cnt_out 相同

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            pos_out <= 0;
        end else if (en) begin
            if (cnt_in == 32 - 1) begin  // if the position changes, update the position
                pos_out <= pos_in;
            end else begin
                pos_out <= pos_out;
            end
        end else begin
            pos_out <= pos_out;
        end
    end

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            data_out0 <= 0;
            data_out1 <= 0;
            data_out2 <= 0;
            data_out3 <= 0;
        end else if (en) begin
            if (cnt_in == 32 - 1) begin  // if the position changes, update the data
                data_out0 <= data_in0;
                data_out1 <= data_in1;
                data_out2 <= data_in2;
                data_out3 <= data_in3;
            end else begin
                data_out0 <= data_out0;
                data_out1 <= data_out1;
                data_out2 <= data_out2;
                data_out3 <= data_out3;
            end
        end else begin
            data_out0 <= data_out0;
            data_out1 <= data_out1;
            data_out2 <= data_out2;
            data_out3 <= data_out3;
        end
    end

endmodule
