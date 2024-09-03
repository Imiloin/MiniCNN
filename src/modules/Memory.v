module Memory (  // memory 接口，在 testbench 中被实例化
    input clk,
    input rst_b,
    input write_en,
    input [7:0] count,  // 0 to 199
    input pin0,
    input pin1,
    input pin2,
    input pin3,
    input pin4,
    input pin5,
    input pin6,
    input pin7,
    input pin8,
    input pin9,
    input pin10,
    input pin11,  // 12-bit input, 200 cycles 1 input fig
    output reg [0:300*8-1] mem
);

    wire [0:11] in;
    assign in = {
        pin0, pin1, pin2, pin3, pin4, pin5, pin6, pin7, pin8, pin9, pin10, pin11
    };

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            mem <= 0;
        end else begin
            if (write_en) begin
                mem[count*12+:12] <= in;
            end else begin
                mem <= mem;
            end
        end
    end

endmodule
