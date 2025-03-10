// File: data_structs.svh
`ifndef DATA_STRUCTS_SVH
`define DATA_STRUCTS_SVH

typedef struct packed {
    logic        bclk;
    logic        raw_data;
    logic [31:0] sample_data;   // Raw 24-bit data from the ADC
} adc_data_t;

typedef struct packed {
    logic [31:0] data;       // Processed 32-bit data
    logic [31:0] dithered_data;
    logic filter_status;     // Status or flags for filter processes
} processed_data_t;

typedef struct packed {
    logic        bclk;
    logic [23:0] dac_data;   // 24-bit output data for the DAC
    logic        overflow_flag;     // Overflow status
} dac_data_t;

typedef struct packed {
    logic [23:0] f0;   // corner frequency
    logic gain; 
    logic slope;      //slope of shelf
} shelf_t;

typedef struct packed {
    logic [23:0] f0;   // corner frequency
    logic gain;     // gain
    logic q;        //bandwidth/q
} filter_t;

`endif
