// Simple baud tick from 50 MHz. Default ~115200 Hz.
module baud_gen #(
    parameter CLK_HZ   = 50_000_000,
    parameter BAUD_HZ  = 115_200
)(
    input  wire clk,
    input  wire rst_n,      // active-low sync reset
    output reg  tick        // 1 clk wide pulse at BAUD_HZ
);
    localparam integer DIV = (CLK_HZ/BAUD_HZ);
    localparam integer REM = (CLK_HZ%BAUD_HZ);
    // fractional accumulator to reduce baud error
    reg [$clog2(DIV+1):0] ctr = 0;
    reg [$clog2(BAUD_HZ):0] acc = 0;

    always @(posedge clk) begin
        if (!rst_n) begin
            ctr  <= 0;
            acc  <= 0;
            tick <= 1'b0;
        end else begin
            tick <= 1'b0;
            if (ctr == DIV-1) begin
                ctr <= 0;
                // fractional part: add remainder; if overflow, add one extra cycle skip
                acc <= acc + REM;
                if (acc >= BAUD_HZ) begin
                    acc <= acc - BAUD_HZ;
                    // skip one extra clk to approximate fractional division
                end else begin
                    tick <= 1'b1;
                end
            end else begin
                ctr <= ctr + 1;
            end
        end
    end
endmodule
