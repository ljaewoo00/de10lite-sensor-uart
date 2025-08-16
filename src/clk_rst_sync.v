module clk_rst_sync(
    input  wire clk,
    input  wire rst_n_in,   // async or board reset (active-low)
    output wire rst_n_out   // synced active-low reset
);
    reg r1, r2;
    always @(posedge clk) begin
        r1 <= rst_n_in;
        r2 <= r1;
    end
    assign rst_n_out = r2;
endmodule
