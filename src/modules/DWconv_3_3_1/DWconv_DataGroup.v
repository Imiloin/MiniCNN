// 4*4 -> 4个3*3
// 枚举赋值
module DWconv_DataGroup (
    input [0:16*8-1] input_data,
    input rst_b,
    input clk,
    output wire [0:9*8-1] select_data0,
    output wire [0:9*8-1] select_data1,
    output wire [0:9*8-1] select_data2,
    output wire [0:9*8-1] select_data3
);
    // 0  1  2  3
    // 4  5  6  7
    // 8  9  10 11
    // 12 13 14 15

    // [0:9*8-1] select_data0 
    assign select_data0[0*8:(0+3)*8-1] = input_data[0*8:(0+3)*8-1];
    assign select_data0[3*8:(3+3)*8-1] = input_data[4*8:(4+3)*8-1];
    assign select_data0[6*8:(6+3)*8-1] = input_data[8*8:(8+3)*8-1];
    // [0:9*8-1] select_data1
    assign select_data1[0*8:(0+3)*8-1] = input_data[1*8:(1+3)*8-1];
    assign select_data1[3*8:(3+3)*8-1] = input_data[5*8:(5+3)*8-1];
    assign select_data1[6*8:(6+3)*8-1] = input_data[9*8:(9+3)*8-1];
    // [0:9*8-1] select_data2
    assign select_data2[0*8:(0+3)*8-1] = input_data[4*8:(4+3)*8-1];
    assign select_data2[3*8:(3+3)*8-1] = input_data[8*8:(8+3)*8-1];
    assign select_data2[6*8:(6+3)*8-1] = input_data[12*8:(12+3)*8-1];
    // [0:9*8-1] select_data3
    assign select_data3[0*8:(0+3)*8-1] = input_data[5*8:(5+3)*8-1];
    assign select_data3[3*8:(3+3)*8-1] = input_data[9*8:(9+3)*8-1];
    assign select_data3[6*8:(6+3)*8-1] = input_data[13*8:(13+3)*8-1];

endmodule
