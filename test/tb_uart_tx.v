`timescale 1ns/1ps
module tb_uart_tx;
    reg clk = 0, rst_n = 0;
    always #10 clk = ~clk; // 50 MHz -> 20 ns period

    reg        tx_stb = 0;
    reg [7:0]  tx_data = 8'h00;
    wire       tx_busy;
    wire       tx;

    uart_tx #(.CLK_HZ(50_000_000), .BAUD_HZ(115_200)) DUT (
        .clk(clk), .rst_n(rst_n),
        .tx_stb(tx_stb), .tx_data(tx_data),
        .tx_busy(tx_busy), .tx(tx)
    );

    initial begin
        #100 rst_n = 1;
        #1000;
        // Week 3: drive tx_stb/tx_data and watch 'tx'
        #100000 $finish;
    end
endmodule
