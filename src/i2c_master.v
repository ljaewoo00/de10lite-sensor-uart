// Week 2 placeholder for a simple I2C master state machine.
// For now, it exposes the bidir pins and does nothing (lines left 'Z' internally).
module i2c_master(
    input  wire clk,
    input  wire rst_n,
    inout  wire sda,
    inout  wire scl
);
    // Leave lines released. Real open-drain drive comes in Week 4.
    assign sda = 1'bz;
    assign scl = 1'bz;
endmodule
