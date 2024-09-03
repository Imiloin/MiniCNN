module CNN_DataController (
    input clk,
    input rst_b,
    input en,
    output reg [4:0] cnt,
    output reg [3:0] pos
);

    // 生成 cnt, pos 信号
    parameter CNT_MAX = 32;
    parameter POS_MAX = 9;

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            cnt <= 0;
        end else begin
            if (en) begin
                if (cnt == CNT_MAX - 1) begin
                    cnt <= 0;
                end else begin
                    cnt <= cnt + 1;
                end
            end else begin
                cnt <= cnt;
            end
        end
    end

    always @(posedge clk or negedge rst_b) begin
        if (~rst_b) begin
            pos <= 0;
        end else begin
            if (en) begin
                if (cnt == CNT_MAX - 1) begin
                    pos <= (pos == POS_MAX - 1) ? 0 : pos + 1;
                end else begin
                    pos <= pos;
                end
            end else begin
                pos <= pos;
            end
        end
    end

endmodule