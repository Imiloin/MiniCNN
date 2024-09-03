// input_data1 + input_data2 + input_bias = output_data1

module DWconv_Add_cell (
    input [0:2*32-1] input_data,
    input [31:0] input_bias,
    input rst_b,
    input clk,
    inout en,
    output reg signed [31:0] output_data
);

    // 输入拆分 
    localparam KERNELS = 2;
    wire signed [31:0] data_in[0:KERNELS-1];

    generate
        genvar i;
        for (i = 0; i < KERNELS; i = i + 1) begin : u_dwconv_add_unpack_input
            assign data_in[i][31:0] = input_data[(32*i):(32*i+31)];
        end
    endgenerate


    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            output_data <= 0;
        end else begin
            if (en) output_data <= data_in[0] + data_in[1] + input_bias;
            else output_data <= output_data;
        end
    end

endmodule
