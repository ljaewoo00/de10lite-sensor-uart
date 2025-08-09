module top(
    input  wire clk_50,
    output wire uart_tx,
    inout  wire i2c_scl,
    inout  wire i2c_sda,
    output wire [9:0] led
);
    assign uart_tx = 1'b1; // idle
    assign i2c_scl = 1'bz; // external pull-ups
    assign i2c_sda = 1'bz;

    reg [25:0] cnt = 0;
    always @(posedge clk_50) cnt <= cnt + 1;
    assign led[0] = cnt[25];
    assign led[9:1] = 9'b0;
endmodule