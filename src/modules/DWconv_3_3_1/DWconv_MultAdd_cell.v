// 9*(8bit data * 8bit kernel) 

module DWconv_MultAdd_cell (
    input [0:9*8-1] input_data,  // 9* 8bit data
    input [0:9*8-1] input_weight,  // 9* 8bit kernel
    input rst_b,
    input clk,
    inout en,
    output reg signed [31:0] output_data0,
    output reg signed [31:0] output_data1
);

    // 输入拆分 
    localparam KERNELS = 9;
    wire signed [7:0] data_in  [0:KERNELS-1];
    wire signed [7:0] weight_in[0:KERNELS-1];

    generate
        genvar i;
        for (
            i = 0; i < KERNELS; i = i + 1
        ) begin : u_dwconv_multadd_unpack_input0
            assign data_in[i][7:0] = input_data[(8*i):(8*i+7)];
        end
    endgenerate

    generate
        genvar j;
        for (
            j = 0; j < KERNELS; j = j + 1
        ) begin : u_dwconv_multadd_unpack_input1
            assign weight_in[j][7:0] = input_weight[(8*j):(8*j+7)];
        end
    endgenerate


    // 前五个数相加
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            output_data0 <= 0;
        end else begin
            if (en)
                output_data0 <= data_in[0]*weight_in[0] + data_in[1]*weight_in[1] + data_in[2]*weight_in[2] + data_in[3]*weight_in[3] + data_in[4]*weight_in[4];
            else output_data0 <= output_data0;
        end
    end

    // 后四个数相加
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            output_data1 <= 0;
        end else begin
            if (en)
                output_data1 <= data_in[5] * weight_in[5] + data_in[6] * weight_in[6] + data_in[7] * weight_in[7] + data_in[8] * weight_in[8];
            else output_data1 <= output_data1;
        end
    end

endmodule
