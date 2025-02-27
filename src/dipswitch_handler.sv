`timescale 1 ns / 1 ns
module dipswitch_handler(
    input              resetn,
    input              sys_clk,
    input  logic [3:0] dipsw,
    output logic [3:0] ds_out
);

logic [3:0][3:0] ds_ff;

always_ff @(posedge sys_clk) begin
    if(!resetn) begin
        ds_ff <= 0;
    end else begin
        ds_ff[0][3:0] <= {ds_ff[0][2:0], dipsw[0]};
        ds_ff[1][3:0] <= {ds_ff[1][2:0], dipsw[1]};
        ds_ff[2][3:0] <= {ds_ff[2][2:0], dipsw[2]};
        ds_ff[3][3:0] <= {ds_ff[3][2:0], dipsw[3]};
    end
end

assign ds_out[0] = ds_ff[0][3];
assign ds_out[1] = ds_ff[1][3];
assign ds_out[2] = ds_ff[2][3];
assign ds_out[3] = ds_ff[3][3];

endmodule