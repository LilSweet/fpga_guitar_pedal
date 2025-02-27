`timescale 1 ns / 1 ns
`include "data_structs.svh"

module top(
    input        INCLK,
    input        DEV_RST_N,
    
    //on board peripherals for EVN
    input  [3:0] DIPSW,
    output [7:0] LED
);

`define LATTICE
`define LCMXO3D
//`define LCMXO3LF
//`define MAX10

adc_data_t adc_data;      //CS4272 outputs 2s compliment, so no conversion needs to happen for fixed point
dac_data_t dac_data;      //data will need dithering before being output to DAC
processed_data_t eq_data;

logic sys_clk;  //use to drive logic needed for system
logic bclk;     //provides bit clock for ADC
logic alg_clk;  //Used for calculations
logic sync;     //provides sync clock (LR Clock)

logic codec_mclk;
logic lr_clk;

logic resetn;

logic send_next_sample;

wire pll_locked;

pll_wrapper sys_pll (
  .clk_in           (INCLK),
  .resetn           (DEV_RST_N),
  .pll_locked       (pll_locked),
  .c0               (sys_clk),
  .c1               (alg_clk),
  .c2               (bclk),
  .c3               (sync)
);

reset_sync sys_rst (
  .clk              (sys_clk),
  .pll_locked       (pll_locked),
  .reset_out        (resetn)
);

adc_input_top #(.I2S_MODE (1'b0))
adc_in(
  .resetn           (resetn),
  .bclk             (bclk),
  .sync             (sync),
  .alg_clk          (alg_clk),
  .send_next_sample (send_next_sample),
  .i2s_data_in      (adc_data.raw_data),
  .i2s_data_out     (adc_data.sample_data)
);

pld_hb sys_hb(
  .clk              (sys_clk),
  .resetn           (resetn),
  .hb_led           (LED[0])
);

dipswitch_handler dipsw_hndlr(
  .resetn           (resetn),
  .sys_clk          (sys_clk),
  .dipsw            (DIPSW),
  .ds_out           (LED[7:4])
);

assign LED[3:1] = 3'b111;


endmodule