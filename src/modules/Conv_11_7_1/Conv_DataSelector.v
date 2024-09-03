//select 14*11 from 30*10
module Conv_DataSelector (
    input [0:30*10*8-1] mem,
    input rst_b,
    input clk,
    input en,
    input [4:0] cnt_in,  // 32
    input [3:0] pos_in,  // 9
    output reg [4:0] cnt_out,
    output reg [3:0] pos_out,
    output wire [0:14*10*8-1] select_data
);
    reg [0:30*10*8-1] data_out;
    assign select_data = data_out[(pos_out)*20*8+:14*10*8];

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b) begin
            cnt_out <= 0;
            pos_out <= 0;
        end else if (en) begin
            cnt_out <= cnt_in;
            pos_out <= pos_in;
        end else begin
            cnt_out <= cnt_out;
            pos_out <= pos_out;
        end
    end

    // 生成 data_out 信号
    localparam CNT_MAX = 32;
    localparam POS_MAX = 9;

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            data_out <= 0;
        end else begin
            if (en) begin
                if ((cnt_in == CNT_MAX - 1) && (pos_in == POS_MAX - 1)) begin
                    data_out <= mem;
                end else begin
                    data_out <= data_out;
                end
            end else begin
                data_out <= data_out;
            end
        end
    end

endmodule
