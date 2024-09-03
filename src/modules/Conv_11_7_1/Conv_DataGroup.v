// 将选择的14*10大小的信号，分成4*4个11*7

module Conv_DataGroup (
    input [0:14*10*8-1] input_data,
    input rst_b,
    input clk,
    output wire [0:4*77*8-1] select_data0,
    output wire [0:4*77*8-1] select_data1,
    output wire [0:4*77*8-1] select_data2,
    output wire [0:4*77*8-1] select_data3
);

    // 防止位宽太大，分成4个片选信号
    // select_data0:0  1  2  3   
    // select_data1:10 11 12 13 
    // select_data2:20 21 22 23
    // select_data3:30 31 32 33

    // [0:4*77*8-1] select_data0
    // 00 01 02 03
    // 00
    generate
        genvar i00;
        for (
            i00 = 0; i00 < 11; i00 = i00 + 1
        ) begin : u_conv_datagroup_unpack_input00
            assign select_data0[(i00+0)*7*8:(i00+0+1)*7*8-1] = input_data[(i00*10*8)+0*8:(i00*10*8)+0*8+7*8-1];
        end
    endgenerate
    // 01
    generate
        genvar i01;
        for (
            i01 = 0; i01 < 11; i01 = i01 + 1
        ) begin : u_conv_datagroup_unpack_input01
            assign select_data0[(i01+11)*7*8:(i01+11+1)*7*8-1] = input_data[(i01*10*8)+1*8:(i01*10*8)+1*8+7*8-1];
        end
    endgenerate
    // 02
    generate
        genvar i02;
        for (
            i02 = 0; i02 < 11; i02 = i02 + 1
        ) begin : u_conv_datagroup_unpack_input02
            assign select_data0[(i02+22)*7*8:(i02+22+1)*7*8-1] = input_data[(i02*10*8)+2*8:(i02*10*8)+2*8+7*8-1];
        end
    endgenerate
    // 03
    generate
        genvar i03;
        for (
            i03 = 0; i03 < 11; i03 = i03 + 1
        ) begin : u_conv_datagroup_unpack_input03
            assign select_data0[(i03+33)*7*8:(i03+33+1)*7*8-1] = input_data[(i03*10*8)+3*8:(i03*10*8)+3*8+7*8-1];
        end
    endgenerate

    // [0:4*77*8-1] select_data1
    // 10 11 12 13
    // 10
    generate
        genvar i10;
        for (
            i10 = 0; i10 < 11; i10 = i10 + 1
        ) begin : u_conv_datagroup_unpack_input10
            assign select_data1[(i10+0)*7*8:(i10+0+1)*7*8-1] = input_data[(i10*10*8)+10*8:(i10*10*8)+10*8+7*8-1];
        end
    endgenerate
    // 11
    generate
        genvar i11;
        for (
            i11 = 0; i11 < 11; i11 = i11 + 1
        ) begin : u_conv_datagroup_unpack_input11
            assign select_data1[(i11+11)*7*8:(i11+11+1)*7*8-1] = input_data[(i11*10*8)+11*8:(i11*10*8)+11*8+7*8-1];
        end
    endgenerate
    // 12
    generate
        genvar i12;
        for (
            i12 = 0; i12 < 11; i12 = i12 + 1
        ) begin : u_conv_datagroup_unpack_input12
            assign select_data1[(i12+22)*7*8:(i12+22+1)*7*8-1] = input_data[(i12*10*8)+12*8:(i12*10*8)+12*8+7*8-1];
        end
    endgenerate
    // 13
    generate
        genvar i13;
        for (
            i13 = 0; i13 < 11; i13 = i13 + 1
        ) begin : u_conv_datagroup_unpack_input13
            assign select_data1[(i13+33)*7*8:(i13+33+1)*7*8-1] = input_data[(i13*10*8)+13*8:(i13*10*8)+13*8+7*8-1];
        end
    endgenerate

    // [0:4*77*8-1] select_data2
    // 20 21 22 23
    // 20
    generate
        genvar i20;
        for (
            i20 = 0; i20 < 11; i20 = i20 + 1
        ) begin : u_conv_datagroup_unpack_input20
            assign select_data2[(i20+0)*7*8:(i20+0+1)*7*8-1] = input_data[(i20*10*8)+20*8:(i20*10*8)+20*8+7*8-1];
        end
    endgenerate
    // 21
    generate
        genvar i21;
        for (
            i21 = 0; i21 < 11; i21 = i21 + 1
        ) begin : u_conv_datagroup_unpack_input21
            assign select_data2[(i21+11)*7*8:(i21+11+1)*7*8-1] = input_data[(i21*10*8)+21*8:(i21*10*8)+21*8+7*8-1];
        end
    endgenerate
    // 22
    generate
        genvar i22;
        for (
            i22 = 0; i22 < 11; i22 = i22 + 1
        ) begin : u_conv_datagroup_unpack_input22
            assign select_data2[(i22+22)*7*8:(i22+22+1)*7*8-1] = input_data[(i22*10*8)+22*8:(i22*10*8)+22*8+7*8-1];
        end
    endgenerate
    // 23
    generate
        genvar i23;
        for (
            i23 = 0; i23 < 11; i23 = i23 + 1
        ) begin : u_conv_datagroup_unpack_input23
            assign select_data2[(i23+33)*7*8:(i23+33+1)*7*8-1] = input_data[(i23*10*8)+23*8:(i23*10*8)+23*8+7*8-1];
        end
    endgenerate

    // [0:4*77*8-1] select_data3
    // 30 31 32 33
    // 30
    generate
        genvar i30;
        for (
            i30 = 0; i30 < 11; i30 = i30 + 1
        ) begin : u_conv_datagroup_unpack_input30
            assign select_data3[(i30+0)*7*8:(i30+0+1)*7*8-1] = input_data[(i30*10*8)+30*8:(i30*10*8)+30*8+7*8-1];
        end
    endgenerate
    // 31
    generate
        genvar i31;
        for (
            i31 = 0; i31 < 11; i31 = i31 + 1
        ) begin : u_conv_datagroup_unpack_input31
            assign select_data3[(i31+11)*7*8:(i31+11+1)*7*8-1] = input_data[(i31*10*8)+31*8:(i31*10*8)+31*8+7*8-1];
        end
    endgenerate
    // 32
    generate
        genvar i32;
        for (
            i32 = 0; i32 < 11; i32 = i32 + 1
        ) begin : u_conv_datagroup_unpack_input32
            assign select_data3[(i32+22)*7*8:(i32+22+1)*7*8-1] = input_data[(i32*10*8)+32*8:(i32*10*8)+32*8+7*8-1];
        end
    endgenerate
    // 33
    generate
        genvar i33;
        for (
            i33 = 0; i33 < 11; i33 = i33 + 1
        ) begin : u_conv_datagroup_unpack_input33
            assign select_data3[(i33+33)*7*8:(i33+33+1)*7*8-1] = input_data[(i33*10*8)+33*8:(i33*10*8)+33*8+7*8-1];
        end
    endgenerate

endmodule
