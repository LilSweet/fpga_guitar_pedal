`timescale 1 ns/ 1 ns
module reset_sync (
    input         clk,
    input         pll_locked,
    output        reset_out
);

logic [8:0] rst_count; //just chose an arbitrary amount of time, just wanna set all resets to this

always_ff @(posedge clk) begin
    if (!pll_locked) begin
        rst_count <= 0;
    end else begin
        rst_count <= rst_count + 1'b1;
    end
end

assign reset_out = rst_count[8];

endmodule