`timescale 1 ns / 1 ns
`include "data_structs.svh"

module top(
    input        INCLK,
    input        DEV_RST_N,

    //on board peripherals for EVN
    input  [1:0] BTN,
    output [1:0] LED
);

adc_data_t adc_data;      //CS4272 outputs 2s compliment, so no conversion needs to happen for fixed point
dac_data_t dac_data;      //data will need dithering before being output to DAC
processed_data_t eq_data;

logic sys_clk;  //use to drive logic needed for system
logic bclk;     //provides bit clock for ADC, [bclk = (64 * lr_clk)] for best performance as per the datasheet for CS4272
logic clk_24M576;
logic lr_clk;

logic resetn;

logic send_next_sample;

logic mmcm_locked;

sys_mmcm clk_gen(
  .reset        (~DEV_RST_N),
  .clk_in1      (INCLK),
  .clk_out1     (clk_24M576), //24M576
  .clk_out2     (sys_clk), //192M00
  .clk_out3     (bclk), //6M144
  .locked       (mmcm_locked)
);

assign adc_data.bclk = bclk;
assign dac_data.bclk = bclk;

//reset_sync sys_rst (
//  .clk              (sys_clk),
//  .pll_locked       (pll_locked),
//  .reset_out        (resetn)
//);

//adc_input_top #(.I2S_MODE (1'b0))
//adc_in(
//  .resetn           (resetn),
//  .bclk             (bclk),
//  .sync             (sync),
//  .alg_clk          (alg_clk),
//  .send_next_sample (send_next_sample),
//  .i2s_data_in      (adc_data.raw_data),
//  .i2s_data_out     (adc_data.sample_data)
//);

//pld_hb sys_hb(
//  .clk              (sys_clk),
//  .resetn           (resetn),
//  .hb_led           (LED[0])
//);

//dipswitch_handler dipsw_hndlr(
//  .resetn           (resetn),
//  .sys_clk          (sys_clk),
//  .dipsw            (DIPSW),
//  .ds_out           (LED[7:4])
//);

//assign LED[3:1] = 3'b111;


endmodule