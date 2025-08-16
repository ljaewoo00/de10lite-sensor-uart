// 8-N-1 UART TX skeleton. For Week 2 it idles and accepts a strobe, no send yet.
module uart_tx #(
    parameter CLK_HZ  = 50_000_000,
    parameter BAUD_HZ = 115_200
)(
    input  wire clk,
    input  wire rst_n,         // active-low sync reset
    // transmit interface
    input  wire       tx_stb,  // strobe: request to send 'tx_data'
    input  wire [7:0] tx_data, // byte to send
    output reg        tx_busy, // high while sending (stub: always 0 for now)
    // serial line
    output reg        tx       // UART line (idle high)
);
    // Hook up baud tick for future use (unused in Week 2)
    wire baud_tick;
    baud_gen #(.CLK_HZ(CLK_HZ), .BAUD_HZ(BAUD_HZ)) u_baud (
        .clk   (clk),
        .rst_n (rst_n),
        .tick  (baud_tick)
    );

    always @(posedge clk) begin
        if (!rst_n) begin
            tx      <= 1'b1; // idle high
            tx_busy <= 1'b0;
        end else begin
            tx      <= 1'b1; // still idle in Week 2
            tx_busy <= 1'b0;
            // Week 3: implement FSM that uses baud_tick to shift start, data[7:0], stop
        end
    end
endmodule
