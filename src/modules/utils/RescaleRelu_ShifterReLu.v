module RescaleReLu_ShifterReLu #(
    parameter [7:0] N = 8'd11
) (
    input rst_b,
    input clk,
    input en,
    input signed [31:0] data_in,
    output reg signed [7:0] data_out
);

    wire signed [31:0] res;
    assign res = data_in >>> N;
    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            data_out <= 0;
        end else if (en) begin
            data_out <= (res < 0) ? 8'sd0 : ((res > 127) ? 8'sd127 : res[7:0]);
        end else begin
            data_out <= data_out;
        end
    end

endmodule
