//6 of 32bit input add
//应该没有问题，不要轻易改动
module Conv_Add2nd_cell (
    input signed [31:0] input_data0,
    input signed [31:0] input_data1,
    input signed [31:0] input_data2,
    input signed [31:0] input_data3,
    input signed [31:0] input_data4,
    input signed [31:0] input_data5,
    input en,
    input clk, 
    input rst_b,
    output reg signed [31:0] output_data
);

always @(posedge clk or negedge rst_b)begin
    if(!rst_b)  output_data <=0;
    else begin
        if(en) output_data <=input_data0 + input_data1 + input_data2 + input_data3 + input_data4 + input_data5;
        else output_data <= output_data;
    end
end

endmodule
