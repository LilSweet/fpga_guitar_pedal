`timescale 1 ns / 1 ns
import constants_pack::*;

// Expanded biquad coefficient calculation module for different filter types
module biquad_coefficients #(
  parameter int DATA_WIDTH = 32,   // Width of fixed-point numbers (Q8.24)
  parameter int Q_WIDTH = 24       // Width of fractional part (for Q8.24)
)(
  input logic [DATA_WIDTH-1:0] cutoff_freq,   // Cutoff frequency in Hz (fixed-point Q8.24)
  input logic [DATA_WIDTH-1:0] sample_rate,   // Sample rate in Hz (fixed-point Q8.24)
  input logic [DATA_WIDTH-1:0] Q_factor,      // Quality factor Q (fixed-point Q8.24)
  input logic [DATA_WIDTH-1:0] gain,          // Gain in dB (fixed-point Q8.24) - used for shelf and bell filters
  input logic [2:0] filter_type,              // Expanded filter type: 3-bit for six filter options
  output logic signed [DATA_WIDTH-1:0] a0,    // Biquad coefficient a0 (Q8.24)
  output logic signed [DATA_WIDTH-1:0] a1,    // Biquad coefficient a1 (Q8.24)
  output logic signed [DATA_WIDTH-1:0] a2,    // Biquad coefficient a2 (Q8.24)
  output logic signed [DATA_WIDTH-1:0] b0,    // Biquad coefficient b0 (Q8.24)
  output logic signed [DATA_WIDTH-1:0] b1,    // Biquad coefficient b1 (Q8.24)
  output logic signed [DATA_WIDTH-1:0] b2     // Biquad coefficient b2 (Q8.24)
);

  // Filter type encoding
  localparam LOW_PASS    = 3'b000;
  localparam HIGH_PASS   = 3'b001;
  localparam LOW_SHELF   = 3'b010;
  localparam HIGH_SHELF  = 3'b011;
  localparam NOTCH       = 3'b100;
  localparam BELL        = 3'b101;

  // Intermediate values for calculations
  logic signed [DATA_WIDTH-1:0] omega;        // Angular frequency
  logic signed [DATA_WIDTH-1:0] alpha;        // Alpha (used in coefficient calculations)
  logic signed [DATA_WIDTH-1:0] cos_omega;    // Cosine of omega
  logic signed [DATA_WIDTH-1:0] sin_omega;    // Sine of omega
  logic signed [DATA_WIDTH-1:0] A;            // Amplitude coefficient for shelving and bell filters
  logic signed [DATA_WIDTH-1:0] two;          // Fixed-point value for "2"

  initial begin
    two = 32'h02000000; // 2.0 in Q8.24 format
  end

  // Convert gain from dB to linear scale for shelf/bell filters
 // Move this funcion to excel. Compute all values of gain between +/-15 at 0.1 steps, and store in either LUTs or block RAM
  // Encoder logic will just increment address pointer to next or previous value rather than computing in real time
  // assign A = fixed_pow(10, fixed_div(gain, constants_pack::GAIN_FACTOR_Q824)); // A = 10^(gain/40)

  // Calculate omega = 2 * PI * (cutoff_freq / sample_rate)
  assign omega = fixed_mult(fixed_mult(two, constants_pack::PI_Q824), fixed_div(cutoff_freq, sample_rate));

  // Calculate sin(omega) and cos(omega) (could use approximation functions or lookup)
  assign sin_omega = fixed_sin(omega);
  assign cos_omega = fixed_cos(omega);

  // Calculate alpha = sin(omega) / (2 * Q_factor)
  assign alpha = fixed_div(sin_omega, fixed_mult(two, Q_factor));

  // Coefficient Calculation
  always_comb begin
    // Default coefficient values (set to zero to avoid latches)
    a0 = 0;
    a1 = 0;
    a2 = 0;
    b0 = 0;
    b1 = 0;
    b2 = 0;

    case (filter_type)
      LOW_PASS: begin
        // Example calculations for low-pass filter coefficients
        a0 = fixed_mult((32'h02000000 - cos_omega), 32'h00800000); // (1 - cos(omega)) / 2
        a1 = 32'h01000000 - cos_omega; // 1 - cos(omega)
        a2 = a0; // (1 - cos(omega)) / 2
        b0 = 32'h01000000 + alpha; // 1 + alpha
        b1 = -fixed_mult(cos_omega, 32'h02000000); // -2 * cos(omega)
        b2 = 32'h01000000 - alpha; // 1 - alpha
      end

      HIGH_PASS: begin
        // High-pass filter coefficients
        a0 = fixed_mult((32'h02000000 + cos_omega), 32'h00800000); // (1 + cos(omega)) / 2
        a1 = -(32'h01000000 + cos_omega); // -(1 + cos(omega))
        a2 = a0; // (1 + cos(omega)) / 2
        b0 = 32'h01000000 + alpha; // 1 + alpha
        b1 = -fixed_mult(cos_omega, 32'h02000000); // -2 * cos(omega)
        b2 = 32'h01000000 - alpha; // 1 - alpha
      end

      LOW_SHELF: begin
        // Low-shelf filter coefficients
        // Refer to the shelf formula, using `A`, `alpha`, `omega`, etc.
      end

      HIGH_SHELF: begin
        // High-shelf filter coefficients
        // Refer to the shelf formula, using `A`, `alpha`, `omega`, etc.
      end

      NOTCH: begin
        // Notch filter coefficients
        a0 = 32'h01000000;             // 1.0 in Q8.24
        a1 = -fixed_mult(cos_omega, 32'h02000000); // -2 * cos(omega)
        a2 = 32'h01000000;             // 1.0
        b0 = 32'h01000000 + alpha;     // 1 + alpha
        b1 = a1;                       // -2 * cos(omega)
        b2 = 32'h01000000 - alpha;     // 1 - alpha
      end

      BELL: begin
        // Bell filter coefficients
        // Refer to bell filter formula using `A`, `alpha`, `omega`, etc.
      end

      default: begin
        // If the filter type is not recognized, set coefficients to zero or default
        a0 = 0;
        a1 = 0;
        a2 = 0;
        b0 = 0;
        b1 = 0;
        b2 = 0;
      end
    endcase
  end
endmodule
