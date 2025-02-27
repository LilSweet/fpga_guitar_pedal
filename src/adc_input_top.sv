`timescale 1 ns/ 1 ns
module adc_input_top #(
  parameter I2S_MODE = 1'b0
)
(
  input               resetn,
  input               bclk,
  input               sync,
  input               alg_clk,
  input               send_next_sample,
  input  logic        i2s_data_in,
  output logic [31:0] i2s_data_out
);

logic [31:0] rd_data, wr_data, fifo_data;
logic        wr_en, rd_en, empty, full, almost_empty, almost_full, latch;

//Module to store incoming data in 32 bit register
input_sr adc_input_sr(
  .resetn       (resetn),
  .bclk         (bclk),
  .latch        (latch),
  .data_in      (i2s_data_in),
  .data_out     (wr_data)
);
//Module to drive FIFO write side

fifo_wr_ctrl #(
  .I2S_MODE      (I2S_MODE)
)
adc_fifo_wr_ctrl(
  .resetn        (resetn),
  .bclk          (bclk),
  .sync          (sync),
  .latch         (latch),
  .wr_en         (wr_en)
);

dc_fifo adc_fifo (
  .Data          (wr_data), 
  .WrClock       (bclk), 
  .RdClock       (alg_clk), 
  .WrEn          (wr_en), 
  .RdEn          (send_next_sample), 
  .Reset         (~resetn), 
  .RPReset       (~resetn), 
  .Q             (rd_data), 
  .Empty         (empty), 
  .Full          (full), 
  .AlmostEmpty   (almost_empty), 
  .AlmostFull    (almost_full)
);

//Module to drive FIFO read side

always_ff @(posedge alg_clk) begin
  if (!resetn) begin
    fifo_data <= 0;
  end else begin
    fifo_data <= rd_data;
  end
end

assign i2s_data_out = fifo_data;

endmodule