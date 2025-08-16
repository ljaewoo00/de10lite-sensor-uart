module top(
    input  wire clk_50,
    output wire uart_tx,
    inout  wire i2c_scl,
    inout  wire i2c_sda,
    output wire [9:0] led
);
    // --- Reset sync (use KEY0 later possibly; for now, tied deasserted) ---
    wire rst_n;
    clk_rst_sync u_sync (
        .clk      (clk_50),
        .rst_n_in (1'b1),     // no external reset yet
        .rst_n_out(rst_n)
    );

    // --- I2C master (placeholder) ---
    i2c_master u_i2c (
        .clk (clk_50),
        .rst_n(rst_n),
        .sda (i2c_sda),
        .scl (i2c_scl)
    );

    // --- Dummy "sensor registers" ---
    wire [7:0] r0, r1, r2, r3;
    i2c_regs u_regs (
        .clk (clk_50),
        .rst_n(rst_n),
        .reg0(r0), .reg1(r1), .reg2(r2), .reg3(r3)
    );

    // --- Processing block (stub) ---
    wire [7:0] proc_byte;
    wire       proc_stb;
    proc_block u_proc (
        .clk (clk_50),
        .rst_n(rst_n),
        .reg0(r0), .reg1(r1), .reg2(r2), .reg3(r3),
        .out_byte(proc_byte),
        .out_stb (proc_stb)
    );

    // --- UART TX (stub: line idle high) ---
    wire tx_busy;
    uart_tx #(.CLK_HZ(50_000_000), .BAUD_HZ(115_200)) u_uart (
        .clk    (clk_50),
        .rst_n  (rst_n),
        .tx_stb (proc_stb),
        .tx_data(proc_byte),
        .tx_busy(tx_busy),
        .tx     (uart_tx)
    );

    // --- LED sanity (keep your blink) ---
    reg [25:0] cnt = 0;
    always @(posedge clk_50) if (rst_n) cnt <= cnt + 1;
    assign led[0]   = cnt[25];
    assign led[9:1] = 9'b0;
endmodule
