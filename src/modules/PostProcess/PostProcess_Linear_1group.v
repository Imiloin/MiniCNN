module PostProcess_Linear_1group (
    input clk,
    input rst_b,
    input en,
    input [8:0] iter,
    input signed [7:0] data_in,
    input signed [7:0] weight,
    input signed [31:0] bias,
    output reg signed [31:0] data_out
);

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            data_out <= 0;
        end else if (en) begin
            if (iter == 0) begin
                data_out <= bias + (data_in * weight);
            end else begin
                data_out <= data_out + (data_in * weight);
            end
        end else begin
            data_out <= data_out;
        end
    end

endmodule
