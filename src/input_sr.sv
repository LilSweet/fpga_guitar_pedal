`timescale 1 ns/ 1 ns
module input_sr(
  input               resetn,
  input               bclk,
  input               latch,
  input  logic        data_in,
  output logic [31:0] data_out
);

logic [3:0] din_sync_reg;     //double flop for stability, double flop to keep in sync with LR Clock
logic [31:0] din_reg;         //data output shift register

always_ff @(posedge bclk) begin
  if(!resetn) begin
    din_reg   <= 0;
  end else begin

    din_sync_reg <= {din_sync_reg[2:0], data_in};

    if (latch) begin
      data_out <= din_reg;
    end else begin
      din_reg <= {din_reg[30:8], din_sync_reg[3], 8'd0};
    end
  end
end

endmodule