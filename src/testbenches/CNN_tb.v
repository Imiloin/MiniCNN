`timescale 1ns / 1ps

module CNN_tb;

    parameter COUNT_MAX = 200;
    parameter ITER_MAX = 288;

    reg clk;
    reg rst_b;
    reg write_en;
    reg [7:0] count;  // 0 to 199
    reg en;
    reg pin0;
    reg pin1;
    reg pin2;
    reg pin3;
    reg pin4;
    reg pin5;
    reg pin6;
    reg pin7;
    reg pin8;
    reg pin9;
    reg pin10;
    reg pin11;
    wire valid;
    wire [31:0] float_out0;
    wire [31:0] float_out1;

    // Instantiate modules
    wire [0:300*8-1] mem;
    Memory memory (
        .clk(clk),
        .rst_b(rst_b),
        .write_en(write_en),
        .count(count),
        .pin0(pin0),
        .pin1(pin1),
        .pin2(pin2),
        .pin3(pin3),
        .pin4(pin4),
        .pin5(pin5),
        .pin6(pin6),
        .pin7(pin7),
        .pin8(pin8),
        .pin9(pin9),
        .pin10(pin10),
        .pin11(pin11),
        .mem(mem)
    );

    CNN cnn (
        .clk(clk),
        .rst_b(rst_b),
        .en(en),
        .mem(mem),
        .valid(valid),
        .float_out0(float_out0),
        .float_out1(float_out1)
    );



    reg [0:11] read_buf[0:COUNT_MAX-1];

    integer i;

    initial begin
        // Initialize the clock and reset signal
        clk = 0;
        rst_b = 1;
        en = 0;
        #10 rst_b = 0;

        // -------------Initialize SRAM------------- //
        // conv
        #10;
        $readmemb(
            "./samples/Conv_Weight_arranged_0.txt",
            cnn.u_cnn_conv.u_conv_weightselector.conv_weight0.uut.mem_core_array);
        $readmemb(
            "./samples/Conv_Weight_arranged_1.txt",
            cnn.u_cnn_conv.u_conv_weightselector.conv_weight1.uut.mem_core_array);
        $readmemb(
            "./samples/Conv_Weight_arranged_2.txt",
            cnn.u_cnn_conv.u_conv_weightselector.conv_weight2.uut.mem_core_array);
        $readmemb(
            "./samples/Conv_Weight_arranged_3.txt",
            cnn.u_cnn_conv.u_conv_weightselector.conv_weight3.uut.mem_core_array);
        $readmemb(
            "./samples/Conv_Weight_arranged_4.txt",
            cnn.u_cnn_conv.u_conv_weightselector.conv_weight4.uut.mem_core_array);
        $readmemb(
            "./samples/Conv_Weight_arranged_5.txt",
            cnn.u_cnn_conv.u_conv_weightselector.conv_weight5.uut.mem_core_array);
        $readmemb(
            "./samples/Conv_Weight_arranged_6.txt",
            cnn.u_cnn_conv.u_conv_weightselector.conv_weight6.uut.mem_core_array);
        $readmemb(
            "./samples/Conv_Weight_arranged_7.txt",
            cnn.u_cnn_conv.u_conv_weightselector.conv_weight7.uut.mem_core_array);
        $readmemh(
            "./samples/Conv_Bias_arranged.txt",
            cnn.u_cnn_conv.u_conv_biasselector.conv_bias.uut.mem_core_array);

        // dwconv
        #10;
        $readmemh(
            "./samples/DWConv_Weight_arranged.txt",
            cnn.u_cnn_conv.u_conv_activation.u_dwconv_weightselector.dwconv_weight.uut.mem_core_array);
        $readmemh(
            "./samples/DWConv_Bias_arranged.txt",
            cnn.u_cnn_dwconv.u_dwconv_biasselector.dwconv_bias.uut.mem_core_array);

        // pwconv
        #10;
        $readmemh(
            "./samples/PWConv_Weight_arranged_0.txt",
            cnn.u_cnn_dwconv.u_dwconv_outputcontrol.u_pwconv_weightselector.pwconv_weight_0.uut.mem_core_array);
        $readmemh(
            "./samples/PWConv_Weight_arranged_1.txt",
            cnn.u_cnn_dwconv.u_dwconv_outputcontrol.u_pwconv_weightselector.pwconv_weight_1.uut.mem_core_array);
        $readmemh(
            "./samples/PWConv_Bias_arranged.txt",
            cnn.u_cnn_pwconv.u_pwconv_conv.u_pwconv_biasselector.pwconv_bias.uut.mem_core_array);

        // linear
        #10;
        $readmemh(
            "./samples/Linear_Weight_arranged.txt",
            cnn.u_cnn_postprocess.u_linear_weightselector.linear_weight.uut.mem_core_array);

        // sigmoid
        #10;
        $readmemh(
            "./samples/sigmoid_lookup_table.txt",
            cnn.u_cnn_postprocess.u_postprocess_sigmoid.sigmoid0.uut.mem_core_array);
        $readmemh(
            "./samples/sigmoid_lookup_table.txt",
            cnn.u_cnn_postprocess.u_postprocess_sigmoid.sigmoid1.uut.mem_core_array);




        // -------------Input data------------- //
        #10 rst_b = 1;
        #10 en = 1;

        // input figures
        for (i = 0; i < 496; i = i + 1) begin
            $readmemh($sformatf("./samples/In/%0d_hex.txt", i), read_buf);
            // $readmemh($sformatf("./samples/In/%0d_hex.txt", 1), read_buf);
            write_en = 1;
            for (count = 0; count < COUNT_MAX; count = count + 1) begin
                // 当前在时钟下降沿
                pin0  = read_buf[count][0];
                pin1  = read_buf[count][1];
                pin2  = read_buf[count][2];
                pin3  = read_buf[count][3];
                pin4  = read_buf[count][4];
                pin5  = read_buf[count][5];
                pin6  = read_buf[count][6];
                pin7  = read_buf[count][7];
                pin8  = read_buf[count][8];
                pin9  = read_buf[count][9];
                pin10 = read_buf[count][10];
                pin11 = read_buf[count][11];
                #2;  // wait 1 clock cycle
            end
            write_en = 0;
            #((ITER_MAX - COUNT_MAX) * 2);
        end

        // more figures to do...


        #4000;
        $stop;
    end

    // Generate a clock with 50% duty cycle and period of 2 time units
    always #1 clk = ~clk;

    // Display the output of the CNN
    real out0;
    real out1;
    integer j;
    initial begin
        j = -1;
    end
    always @(posedge clk) begin
        if (valid) begin
            out0 = $bitstoshortreal(float_out0);
            out1 = $bitstoshortreal(float_out1);
            $display("%0d: Output0: %g(%h), Output1: %g(%h)", j, out0,
                     float_out0, out1, float_out1);
            j = j + 1;
        end
    end

endmodule
