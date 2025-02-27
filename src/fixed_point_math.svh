// fixed_point_math.svh
// Header file for 32-bit fixed-point arithmetic with 8 integer bits and 24 fractional bits.

`ifndef FIXED_POINT_MATH_SVH
`define FIXED_POINT_MATH_SVH

// Function to add two Q8.24 fixed-point numbers
function logic signed [31:0] fixed_add(
    logic signed [31:0] a,
    logic signed [31:0] b
);
    return a + b;
endfunction

// Function to subtract two Q8.24 fixed-point numbers
function logic signed [31:0] fixed_sub(
    logic signed [31:0] a,
    logic signed [31:0] b
);
    return a - b;
endfunction

// Function to multiply two Q8.24 fixed-point numbers
function logic signed [31:0] fixed_mult(
    logic signed [31:0] a,
    logic signed [31:0] b
);
    // Multiply two 32-bit values, result is 64-bit
    logic signed [63:0] result;
    result = a * b;

    // Shift right by 24 to maintain Q8.24 format
    return result[55:24];  // Take the middle 32 bits after shifting
endfunction

// Function to divide two Q8.24 fixed-point numbers
function logic signed [31:0] fixed_div(
    logic signed [31:0] a,
    logic signed [31:0] b
);
    // Shift left by 24 to align for division in Q8.24 format
    logic signed [63:0] result;
    result = (a <<< 24) / b;

    // Return the lower 32 bits
    return result[31:0];
endfunction

`endif // FIXED_POINT_MATH_SVH
