`ifndef PLL_PARAMS_SVH
`define PLL_PARAMS_SVH

// Lattice MachXO3D PLL Parameters
`ifdef LCMXO3D
    /********************************ADJUST VALUES ACCORDINGLY**********************************/
    /*                              formula for output clock is:                               */
    /*                                                                                         */
    /*             out_freq = (in_freq * (CLKFB_DIV)) /  Output divider                        */
    /*******************************************************************************************/
    
    //dev kit, assumes 12M000 input clock

    `define DDRST_ENA        "DISABLED" ;
    `define DCRST_ENA        "DISABLED" ;
    `define MRST_ENA         "DISABLED" ;
    `define PLLRST_ENA       "ENABLED" ;
    `define INTFB_WAKE       "DISABLED" ;
    `define STDBY_ENABLE     "DISABLED" ;
    `define DPHASE_SOURCE    "DISABLED" ;
    `define PLL_USE_WB       "DISABLED" ;
    `define CLKOS3_FPHASE    0 ;
    `define CLKOS3_CPHASE    63 ;
    `define CLKOS2_FPHASE    0 ;
    `define CLKOS2_CPHASE    124 ;
    `define CLKOS_FPHASE     0 ;
    `define CLKOS_CPHASE     2 ;
    `define CLKOP_FPHASE     0 ;
    `define CLKOP_CPHASE     15 ;
    `define PLL_LOCK_MODE    0 ;
    `define CLKOS_TRIM_DELAY 0 ;
    `define CLKOS_TRIM_POL   "RISING" ;
    `define CLKOP_TRIM_DELAY 0 ;
    `define CLKOP_TRIM_POL   "RISING" ;
    `define FRACN_DIV        0 ;
    `define FRACN_ENABLE     "DISABLED" ;
    `define OUTDIVIDER_MUXD2 "DIVD" ;
    `define PREDIVIDER_MUXD1 3 ;
    `define VCO_BYPASS_D0    "DISABLED" ;
    `define CLKOS3_ENABLE    "ENABLED" ;
    `define OUTDIVIDER_MUXC2 "DIVC" ;
    `define PREDIVIDER_MUXC1 0 ;
    `define VCO_BYPASS_C0    "DISABLED" ;
    `define CLKOS2_ENABLE    "ENABLED" ;
    `define OUTDIVIDER_MUXB2 "DIVB" ;
    `define PREDIVIDER_MUXB1 0 ;
    `define VCO_BYPASS_B0    "DISABLED" ;
    `define CLKOS_ENABLE     "ENABLED" ;
    `define OUTDIVIDER_MUXA2 "DIVA" ;
    `define PREDIVIDER_MUXA1 0 ;
    `define VCO_BYPASS_A0    "DISABLED" ;
    `define CLKOP_ENABLE     "ENABLED" ;
    `define CLKOS3_DIV       64 ;
    `define CLKOS2_DIV       125 ;
    `define CLKOS_DIV        3 ;
    `define CLKOP_DIV        16 ;
    `define CLKFB_DIV        4 ;
    `define CLKI_DIV         1 ;
    `define FEEDBK_PATH      "CLKOP" ;
`endif

// Lattice MachXO3LF PLL Parameters
`ifdef LCMXO3LF
    /********************************ADJUST VALUES ACCORDINGLY**********************************/
    /*                              formula for output clock is:                               */
    /*                                                                                         */
    /*             out_freq = (in_freq * (CLKFB_DIV)) /  Output divider                        */
    /*******************************************************************************************/
    
    //project design, assumes 24M576 input clock

    `define DDRST_ENA        "DISABLED" ;
    `define DCRST_ENA        "DISABLED" ;
    `define MRST_ENA         "DISABLED" ;
    `define PLLRST_ENA       "ENABLED" ;
    `define INTFB_WAKE       "DISABLED" ;
    `define STDBY_ENABLE     "DISABLED" ;
    `define DPHASE_SOURCE    "DISABLED" ;
    `define PLL_USE_WB       "DISABLED" ;
    `define CLKOS3_FPHASE    0 ;
    `define CLKOS3_CPHASE    0 ;
    `define CLKOS2_FPHASE    0 ;
    `define CLKOS2_CPHASE    2 ;
    `define CLKOS_FPHASE     0 ;
    `define CLKOS_CPHASE     4 ;
    `define CLKOP_FPHASE     0 ;
    `define CLKOP_CPHASE     29 ;
    `define PLL_LOCK_MODE    0 ;
    `define CLKOS_TRIM_DELAY 0 ;
    `define CLKOS_TRIM_POL   "RISING" ;
    `define CLKOP_TRIM_DELAY 0 ;
    `define CLKOP_TRIM_POL   "RISING" ;
    `define FRACN_DIV        0 ;
    `define FRACN_ENABLE     "DISABLED" ;
    `define OUTDIVIDER_MUXD2 "DIVD" ;
    `define PREDIVIDER_MUXD1 0 ;
    `define VCO_BYPASS_D0    "DISABLED" ;
    `define CLKOS3_ENABLE    "DISABLED" ;
    `define OUTDIVIDER_MUXC2 "DIVC" ;
    `define PREDIVIDER_MUXC1 0 ;
    `define VCO_BYPASS_C0    "DISABLED" ;
    `define CLKOS2_ENABLE    "ENABLED" ;
    `define OUTDIVIDER_MUXB2 "DIVB" ;
    `define PREDIVIDER_MUXB1 0 ;
    `define VCO_BYPASS_B0    "DISABLED" ;
    `define CLKOS_ENABLE     "ENABLED" ;
    `define OUTDIVIDER_MUXA2 "DIVA" ;
    `define PREDIVIDER_MUXA1 0 ;
    `define VCO_BYPASS_A0    "DISABLED" ;
    `define CLKOP_ENABLE     "ENABLED" ;
    `define CLKOS3_DIV       1 ;
    `define CLKOS2_DIV       3 ;  245M76
    `define CLKOS_DIV        5 ;  4M608
    `define CLKOP_DIV        30 ; 24M576
    `define CLKFB_DIV        1 ;
    `define CLKI_DIV         1 ;
    `define FEEDBK_PATH      "CLKOP" ;
`endif

`endif