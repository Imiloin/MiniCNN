// 7*8bit data * 8bit kernel and add
//应该没有问题，不要轻易改动
module Conv_MultAdd_cell (
    input signed [7:0] input_data0,  //7* 8bit data
    input signed [7:0] input_data1,
    input signed [7:0] input_data2,
    input signed [7:0] input_data3,
    input signed [7:0] input_data4,
    input signed [7:0] input_data5,
    input signed [7:0] input_data6,
    input signed [7:0] input_weight0,
    input signed [7:0] input_weight1,
    input signed [7:0] input_weight2,
    input signed [7:0] input_weight3,
    input signed [7:0] input_weight4,
    input signed [7:0] input_weight5,
    input signed [7:0] input_weight6,
    input rst_b,
    input clk,
    inout en,
    output reg signed [31:0] output_data
);

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            output_data <= 0;
        end else begin
            if(en)  output_data <= input_data0*input_weight0 + input_data1*input_weight1 + input_data2*input_weight2 + input_data3*input_weight3 + input_data4*input_weight4 + input_data5*input_weight5 + input_data6*input_weight6;
            else output_data <= output_data ;
        end
    end

endmodule
