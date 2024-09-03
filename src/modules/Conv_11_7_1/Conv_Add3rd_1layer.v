// 2 of 32bit input add
module Conv_Add3rd_1layer (
    input signed [31:0] input_data0,
    input signed [31:0] input_data1,
    input clk,
    input rst_b,
    input en,
    output reg signed [31:0] output_data
);

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) output_data <= 0;
        else begin
            if (en) output_data <= input_data0 + input_data1;
            else output_data <= output_data;
        end
    end

endmodule
