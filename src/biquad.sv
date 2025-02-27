// Include the fixed-point math header file
`include "fixed_point_math.svh"

module biquad (
    input  logic signed [31:0] x_in,       // Input sample in fixed-point format
    output logic signed [31:0] y_out,      // Filtered output sample in fixed-point format
    input  logic               clk,        // Clock
    input  logic               resetn,     // Reset

    // Coefficients in fixed-point format
    input  logic signed [31:0] A1,
    input  logic signed [31:0] A2,
    input  logic signed [31:0] B0,
    input  logic signed [31:0] B1,
    input  logic signed [31:0] B2
);

    // State registers for previous inputs and outputs
    logic signed [31:0] x_prev1, x_prev2;
    logic signed [31:0] y_prev1, y_prev2;

    // Temporary values for intermediate calculations
    logic signed [31:0] mult_x_B0, mult_x_B1, mult_x_B2;
    logic signed [31:0] mult_y_A1, mult_y_A2;

    always_comb begin
      // Fixed-point multiplications for filter equation terms
      mult_x_B0 = fixed_mult(x_in, B0);
      mult_x_B1 = fixed_mult(x_prev1, B1);
      mult_x_B2 = fixed_mult(x_prev2, B2);
      mult_y_A1 = fixed_mult(y_prev1, A1);
      mult_y_A2 = fixed_mult(y_prev2, A2);

      // Filter equation: y[n] = B0*x[n] + B1*x[n-1] + B2*x[n-2] - A1*y[n-1] - A2*y[n-2]
      next_y_out = fixed_sub(fixed_sub(fixed_add(fixed_add(mult_x_B0, mult_x_B1), mult_x_B2), mult_y_A1), mult_y_A2);
  end

  always_ff @(posedge clk or negedge resetn) begin
      if (!resetn) begin
          // Reset state variables
          x_prev1 <= 32'sd0;
          x_prev2 <= 32'sd0;
          y_prev1 <= 32'sd0;
          y_prev2 <= 32'sd0;
          y_out   <= 32'sd0;
      end else begin
          // Update y_out and state registers
          y_out <= next_y_out;
          x_prev2 <= x_prev1;
          x_prev1 <= x_in;
          y_prev2 <= y_prev1;
          y_prev1 <= y_out;
      end
  end

endmodule
