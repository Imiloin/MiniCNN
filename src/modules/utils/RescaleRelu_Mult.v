module RescaleReLu_Mult #(
    parameter [7:0] M0 = 8'sd59
) (
    input rst_b,
    input clk,
    input en,
    input signed [31:0] data_in,
    output reg signed [31:0] data_out
);

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            data_out <= 0;
        end else if (en) begin
            data_out <= data_in * M0;
        end else begin
            data_out <= data_out;
        end
    end

endmodule
