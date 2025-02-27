`timescale 1 ns / 1 ns
`include "data_structs.svh"
module hpx12 (
  input  logic               resetn,       // Reset
  input  logic               clk,         // Clock
  input  filter_t            filter_str,  //struct for the filter type
  input  logic signed [31:0] x_in,        // Input sample
  output logic signed [31:0] y_out       // Filtered output sample
);

//Module to calculate coefficients for filters

logic signed [5:0][31:0] filtered_sample;

biquad biquad_inst1(
  .x_in           (x_in),               // Input sample in fixed-point format
  .y_out          (filtered_sample[0]), // Filtered output sample in fixed-point format
  .clk            (clk),                   // Clock
  .resetn         (resetn),                   // Reset
  .A1             (),
  .A2             (),
  .B0             (),
  .B1             (),
  .B2             ()
);

biquad biquad_inst2(
  .x_in           (filtered_sample[0]),               // Input sample in fixed-point format
  .y_out          (filtered_sample[1]), // Filtered output sample in fixed-point format
  .clk            (clk),                   // Clock
  .resetn         (resetn),                   // Reset
  .A1             (),
  .A2             (),
  .B0             (),
  .B1             (),
  .B2             ()
);

biquad biquad_inst3(
  .x_in           (filtered_sample[1]),               // Input sample in fixed-point format
  .y_out          (filtered_sample[2]), // Filtered output sample in fixed-point format
  .clk            (clk),                   // Clock
  .resetn         (resetn),                   // Reset
  .A1             (),
  .A2             (),
  .B0             (),
  .B1             (),
  .B2             ()
);

biquad biquad_inst4(
  .x_in           (filtered_sample[2]),               // Input sample in fixed-point format
  .y_out          (filtered_sample[3]), // Filtered output sample in fixed-point format
  .clk            (clk),                   // Clock
  .resetn         (resetn),                   // Reset
  .A1             (),
  .A2             (),
  .B0             (),
  .B1             (),
  .B2             ()
);

biquad biquad_inst5(
  .x_in           (filtered_sample[3]),               // Input sample in fixed-point format
  .y_out          (filtered_sample[4]), // Filtered output sample in fixed-point format
  .clk            (clk),                   // Clock
  .resetn         (resetn),                   // Reset
  .A1             (),
  .A2             (),
  .B0             (),
  .B1             (),
  .B2             ()
);

biquad biquad_inst6(
  .x_in           (filtered_sample[4]),               // Input sample in fixed-point format
  .y_out          (filtered_sample[5]), // Filtered output sample in fixed-point format
  .clk            (clk),                   // Clock
  .resetn         (resetn),                   // Reset
  .A1             (),
  .A2             (),
  .B0             (),
  .B1             (),
  .B2             ()
);

assign y_out = filtered_sample[5];
endmodule