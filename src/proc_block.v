// For Week 2: just wire regs into a simple byte mux for UART later.
module proc_block(
    input  wire       clk,
    input  wire       rst_n,
    input  wire [7:0] reg0,
    input  wire [7:0] reg1,
    input  wire [7:0] reg2,
    input  wire [7:0] reg3,
    // simple stream out (byte + strobe)
    output reg  [7:0] out_byte,
    output reg        out_stb
);
    reg [1:0] sel;
    always @(posedge clk) begin
        if (!rst_n) begin
            sel     <= 2'd0;
            out_stb <= 1'b0;
            out_byte<= 8'h00;
        end else begin
            sel <= sel + 1'b1;
            case (sel)
                2'd0: out_byte <= reg0;
                2'd1: out_byte <= reg1;
                2'd2: out_byte <= reg2;
                2'd3: out_byte <= reg3;
            endcase
            out_stb <= 1'b0; // Week 3 will generate paced strobes for UART
        end
    end
endmodule
