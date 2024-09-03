module PWconv_Conv_1point (  // 8 MultAdd4 and 1 Add9
    input clk,
    input rst_b,
    input en,
    input [0:32*8-1] data_in,
    input [0:32*8-1] weight,
    input signed [31:0] bias,
    output signed [31:0] data_out
);

    // MultAdd4
    wire [0:32-1] multadd_in0, multadd_in1, multadd_in2, multadd_in3, multadd_in4, multadd_in5, multadd_in6, multadd_in7;
    wire [0:32-1] multadd_weight0, multadd_weight1, multadd_weight2, multadd_weight3, multadd_weight4, multadd_weight5, multadd_weight6, multadd_weight7;
    wire [0:32-1] multadd_out0, multadd_out1, multadd_out2, multadd_out3, multadd_out4, multadd_out5, multadd_out6, multadd_out7;

    assign multadd_in0 = data_in[0*32:1*32-1];
    assign multadd_in1 = data_in[1*32:2*32-1];
    assign multadd_in2 = data_in[2*32:3*32-1];
    assign multadd_in3 = data_in[3*32:4*32-1];
    assign multadd_in4 = data_in[4*32:5*32-1];
    assign multadd_in5 = data_in[5*32:6*32-1];
    assign multadd_in6 = data_in[6*32:7*32-1];
    assign multadd_in7 = data_in[7*32:8*32-1];

    assign multadd_weight0 = weight[0*32:1*32-1];
    assign multadd_weight1 = weight[1*32:2*32-1];
    assign multadd_weight2 = weight[2*32:3*32-1];
    assign multadd_weight3 = weight[3*32:4*32-1];
    assign multadd_weight4 = weight[4*32:5*32-1];
    assign multadd_weight5 = weight[5*32:6*32-1];
    assign multadd_weight6 = weight[6*32:7*32-1];
    assign multadd_weight7 = weight[7*32:8*32-1];

    PWconv_Conv_1Point_MultAdd4 multadd4_0 (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .data_in(multadd_in0),
        .weight(multadd_weight0),
        .data_out(multadd_out0)
    );
    PWconv_Conv_1Point_MultAdd4 multadd4_1 (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .data_in(multadd_in1),
        .weight(multadd_weight1),
        .data_out(multadd_out1)
    );
    PWconv_Conv_1Point_MultAdd4 multadd4_2 (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .data_in(multadd_in2),
        .weight(multadd_weight2),
        .data_out(multadd_out2)
    );
    PWconv_Conv_1Point_MultAdd4 multadd4_3 (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .data_in(multadd_in3),
        .weight(multadd_weight3),
        .data_out(multadd_out3)
    );
    PWconv_Conv_1Point_MultAdd4 multadd4_4 (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .data_in(multadd_in4),
        .weight(multadd_weight4),
        .data_out(multadd_out4)
    );
    PWconv_Conv_1Point_MultAdd4 multadd4_5 (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .data_in(multadd_in5),
        .weight(multadd_weight5),
        .data_out(multadd_out5)
    );
    PWconv_Conv_1Point_MultAdd4 multadd4_6 (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .data_in(multadd_in6),
        .weight(multadd_weight6),
        .data_out(multadd_out6)
    );
    PWconv_Conv_1Point_MultAdd4 multadd4_7 (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .data_in(multadd_in7),
        .weight(multadd_weight7),
        .data_out(multadd_out7)
    );


    // Add9
    PWconv_Conv_1point_Add9 add9 (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .data_in0(multadd_out0),
        .data_in1(multadd_out1),
        .data_in2(multadd_out2),
        .data_in3(multadd_out3),
        .data_in4(multadd_out4),
        .data_in5(multadd_out5),
        .data_in6(multadd_out6),
        .data_in7(multadd_out7),
        .bias(bias),
        .data_out(data_out)
    );

endmodule
