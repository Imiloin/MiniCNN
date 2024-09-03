//include 4 * DWconv_Add_cell
//input_data0 + input_bias = output_data0
//cnt pos flow
module DWconv_Add (
    input [0:2*32-1] input_data0,
    input [0:2*32-1] input_data1,
    input [0:2*32-1] input_data2,
    input [0:2*32-1] input_data3,
    input [31:0] input_bias,
    input clk,
    input rst_b,
    input en,
    input [4:0] cnt_in,  // 32
    input [3:0] pos_in,  // 9
    output reg [4:0] cnt_out,
    output reg [3:0] pos_out,
    output [31:0] output_data0,
    output [31:0] output_data1,
    output [31:0] output_data2,
    output [31:0] output_data3
);

    // cnt flow
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            cnt_out <= 0;
        end else begin
            if (en) cnt_out <= cnt_in;
            else cnt_out <= cnt_out;
        end
    end

    // pos flow
    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            pos_out <= 0;
        end else begin
            if (en) pos_out <= pos_in;
            else pos_out <= pos_out;
        end
    end

    ////////////////////// 4 * DWconv_Add_cell  ///////////////////////
    DWconv_Add_cell u_dwconv_add_cell_0 (
        .input_data(input_data0),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data0)
    );

    DWconv_Add_cell u_dwconv_add_cell_1 (
        .input_data(input_data1),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data1)
    );

    DWconv_Add_cell u_dwconv_add_cell_2 (
        .input_data(input_data2),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data2)
    );

    DWconv_Add_cell u_dwconv_add_cell_3 (
        .input_data(input_data3),
        .input_bias(input_bias),
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .output_data(output_data3)
    );


endmodule


