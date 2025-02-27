`timescale 1 ns / 1 ns
`include "data_structs.svh"
//need to include arithmetic functions, or modules to handle fixed point arithmetic
module parametric_eq_top(
  input             resetn,
  input             alg_clk,
  input logic [7:0] filter_enable,
  input             sample_data,
  output            send_next_sample,
  output            processed_data
);

filter_t high_pass_x12, low_pass_x12, high_pass_x48, low_pass_x48, bell_filter, notch_filter;
shelf_t low_shelf, high_shelf;

//add logic/module to control eq filter enable and order
//default filter selection should be in order: low shelf, bell, bell, high shelf




endmodule