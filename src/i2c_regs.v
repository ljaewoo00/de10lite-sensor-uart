// Simple register file to hold "sensor" bytes. Week 2: dummy pattern.
module i2c_regs(
    input  wire       clk,
    input  wire       rst_n,
    // read port for proc_block
    output reg [7:0]  reg0,
    output reg [7:0]  reg1,
    output reg [7:0]  reg2,
    output reg [7:0]  reg3
);
    reg [23:0] cnt;
    always @(posedge clk) begin
        if (!rst_n) begin
            cnt  <= 0;
            reg0 <= 8'h00;
            reg1 <= 8'h00;
            reg2 <= 8'h00;
            reg3 <= 8'h00;
        end else begin
            cnt  <= cnt + 1;
            // Week 2: make them change so you see something later via UART
            reg0 <= cnt[7:0];
            reg1 <= cnt[15:8];
            reg2 <= 8'h55;
            reg3 <= 8'haa;
        end
    end
endmodule
