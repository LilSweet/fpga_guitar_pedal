`timescale 1 ns / 1 ns
`include "pll_params.svh"

module pll_wrapper (
    input logic         clk_in,
    input logic         resetn,
    output logic        pll_locked,
    output logic      	c0,
    output logic      	c1,
    output logic      	c2,
	output logic		c3
);

localparam logic SET_LOW  = 1'b0; //just so I dont have to type 1'b0 every time. Arguably takes longer, but in vscode I can let autocomplete work its magic
localparam logic SET_HIGH = 1'b1;

logic [3:0] rst_ff;
logic       rst;

always_ff @(posedge clk_in) begin
  rst_ff <= {rst_ff[2:0], resetn};

  if(rst_ff[3] && !rst_ff[2]) begin
    rst <= 1'b1;
  end else begin
    rst <= 1'b0;
  end
end

`ifdef LATTICE

    localparam DDRST_ENA        = `DDRST_ENA;
    localparam DCRST_ENA        = `DCRST_ENA ;
    localparam MRST_ENA         = `MRST_ENA ;
    localparam PLLRST_ENA       = `PLLRST_ENA ;
    localparam INTFB_WAKE       = `INTFB_WAKE ;
    localparam STDBY_ENABLE     = `STDBY_ENABLE ;
    localparam DPHASE_SOURCE    = `DPHASE_SOURCE ;
    localparam PLL_USE_WB       = `PLL_USE_WB ;
    localparam CLKOS3_FPHASE    = `CLKOS3_FPHASE ;
    localparam CLKOS3_CPHASE    = `CLKOS3_CPHASE ;
    localparam CLKOS2_FPHASE    = `CLKOS2_FPHASE ;
    localparam CLKOS2_CPHASE    = `CLKOS2_CPHASE ;
    localparam CLKOS_FPHASE     = `CLKOS_FPHASE ;
    localparam CLKOS_CPHASE     = `CLKOS_CPHASE ;
    localparam CLKOP_FPHASE     = `CLKOP_FPHASE ;
    localparam CLKOP_CPHASE     = `CLKOP_CPHASE ;
    localparam PLL_LOCK_MODE    = `PLL_LOCK_MODE ;
    localparam CLKOS_TRIM_DELAY = `CLKOS_TRIM_DELAY ;
    localparam CLKOS_TRIM_POL   = `CLKOS_TRIM_POL ;
    localparam CLKOP_TRIM_DELAY = `CLKOP_TRIM_DELAY ;
    localparam CLKOP_TRIM_POL   = `CLKOP_TRIM_POL ;
    localparam FRACN_DIV        = `FRACN_DIV ;
    localparam FRACN_ENABLE     = `FRACN_ENABLE ;
    localparam OUTDIVIDER_MUXD2 = `OUTDIVIDER_MUXD2 ;
    localparam PREDIVIDER_MUXD1 = `PREDIVIDER_MUXD1 ;
    localparam VCO_BYPASS_D0    = `VCO_BYPASS_D0 ;
    localparam CLKOS3_ENABLE    = `CLKOS3_ENABLE ;
    localparam OUTDIVIDER_MUXC2 = `OUTDIVIDER_MUXC2 ;
    localparam PREDIVIDER_MUXC1 = `PREDIVIDER_MUXC1 ;
    localparam VCO_BYPASS_C0    = `VCO_BYPASS_C0 ;
    localparam CLKOS2_ENABLE    = `CLKOS2_ENABLE ;
    localparam OUTDIVIDER_MUXB2 = `OUTDIVIDER_MUXB2 ;
    localparam PREDIVIDER_MUXB1 = `PREDIVIDER_MUXB1 ;
    localparam VCO_BYPASS_B0    = `VCO_BYPASS_B0 ;
    localparam CLKOS_ENABLE     = `CLKOS_ENABLE ;
    localparam OUTDIVIDER_MUXA2 = `OUTDIVIDER_MUXA2 ;
    localparam PREDIVIDER_MUXA1 = `PREDIVIDER_MUXA1 ;
    localparam VCO_BYPASS_A0    = `VCO_BYPASS_A0 ;
    localparam CLKOP_ENABLE     = `CLKOP_ENABLE ;
    localparam CLKOS3_DIV       = `CLKOS3_DIV ;
    localparam CLKOS2_DIV       = `CLKOS2_DIV ;
    localparam CLKOS_DIV        = `CLKOS_DIV ;
    localparam CLKOP_DIV        = `CLKOP_DIV ;
    localparam CLKFB_DIV        = `CLKFB_DIV ;
    localparam CLKI_DIV         = `CLKI_DIV ;
    localparam FEEDBK_PATH      = `FEEDBK_PATH ;

    // Instantiate the EHXPLLJ PLL primitive
    EHXPLLJ #(
      .DDRST_ENA        (DDRST_ENA),
      .DCRST_ENA        (DCRST_ENA),
      .MRST_ENA         (MRST_ENA),
      .PLLRST_ENA       (PLLRST_ENA),
      .INTFB_WAKE       (INTFB_WAKE),
      .STDBY_ENABLE     (STDBY_ENABLE),
      .DPHASE_SOURCE    (DPHASE_SOURCE),
      .PLL_USE_WB       (PLL_USE_WB),
      .CLKOS3_FPHASE    (CLKOS3_FPHASE),
      .CLKOS3_CPHASE    (CLKOS3_CPHASE),
      .CLKOS2_FPHASE    (CLKOS2_FPHASE),
      .CLKOS2_CPHASE    (CLKOS2_CPHASE),
      .CLKOS_FPHASE     (CLKOS_FPHASE),
      .CLKOS_CPHASE     (CLKOS_CPHASE),
      .CLKOP_FPHASE     (CLKOP_FPHASE),
      .CLKOP_CPHASE     (CLKOP_CPHASE),
      .PLL_LOCK_MODE    (PLL_LOCK_MODE),
      .CLKOS_TRIM_DELAY (CLKOS_TRIM_DELAY),
      .CLKOS_TRIM_POL   (CLKOS_TRIM_POL),
      .CLKOP_TRIM_DELAY (CLKOP_TRIM_DELAY),
      .CLKOP_TRIM_POL   (CLKOP_TRIM_POL),
      .FRACN_DIV        (FRACN_DIV),
      .FRACN_ENABLE     (FRACN_ENABLE),
      .OUTDIVIDER_MUXD2 (OUTDIVIDER_MUXD2),
      .PREDIVIDER_MUXD1 (PREDIVIDER_MUXD1),
      .VCO_BYPASS_D0    (VCO_BYPASS_D0),
      .CLKOS3_ENABLE    (CLKOS3_ENABLE),
      .OUTDIVIDER_MUXC2 (OUTDIVIDER_MUXC2),
      .PREDIVIDER_MUXC1 (PREDIVIDER_MUXC1),
      .VCO_BYPASS_C0    (VCO_BYPASS_C0),
      .CLKOS2_ENABLE    (CLKOS2_ENABLE),
      .OUTDIVIDER_MUXB2 (OUTDIVIDER_MUXB2),
      .PREDIVIDER_MUXB1 (PREDIVIDER_MUXB1),
      .VCO_BYPASS_B0    (VCO_BYPASS_B0),
      .CLKOS_ENABLE     (CLKOS_ENABLE),
      .OUTDIVIDER_MUXA2 (OUTDIVIDER_MUXA2),
      .PREDIVIDER_MUXA1 (PREDIVIDER_MUXA1),
      .VCO_BYPASS_A0    (VCO_BYPASS_A0),
      .CLKOP_ENABLE     (CLKOP_ENABLE),
      .CLKOS3_DIV       (CLKOS3_DIV),
      .CLKOS2_DIV       (CLKOS2_DIV),
      .CLKOS_DIV        (CLKOS_DIV),
      .CLKOP_DIV        (CLKOP_DIV),
      .CLKFB_DIV        (CLKFB_DIV),
      .CLKI_DIV         (CLKI_DIV),
      .FEEDBK_PATH      (FEEDBK_PATH)
    ) pll_inst (
      .CLKI             (clk_in),
      .CLKFB            (c0),
      .PHASESEL1        (SET_LOW),
      .PHASESEL0        (SET_LOW),
      .PHASEDIR         (SET_LOW),
      .PHASESTEP        (SET_LOW),
      .LOADREG          (SET_LOW),
      .STDBY            (SET_LOW),
      .PLLWAKESYNC      (SET_LOW),
      .RST              (rst),
      .RESETM           (SET_LOW),
      .RESETC           (SET_LOW),
      .RESETD           (SET_LOW),
      .ENCLKOP          (SET_LOW),
      .ENCLKOS          (SET_LOW),
      .ENCLKOS2         (SET_LOW),
      .ENCLKOS3         (SET_LOW),
      .PLLCLK           (SET_LOW),
      .PLLRST           (SET_LOW),
      .PLLSTB           (SET_LOW),
      .PLLWE            (SET_LOW),
      .PLLADDR4         (SET_LOW),
      .PLLADDR3         (SET_LOW),
      .PLLADDR2         (SET_LOW),
      .PLLADDR1         (SET_LOW),
      .PLLADDR0         (SET_LOW),
      .PLLDATI7         (SET_LOW),
      .PLLDATI6         (SET_LOW),
      .PLLDATI5         (SET_LOW),
      .PLLDATI4         (SET_LOW),
      .PLLDATI3         (SET_LOW),
      .PLLDATI2         (SET_LOW),
      .PLLDATI1         (SET_LOW),
      .PLLDATI0         (SET_LOW),
      .CLKOP            (c0),
      .CLKOS            (c1),
      .CLKOS2           (c2),
	    .CLKOS3           (c3),
      .LOCK             (pll_locked)
    );
	 /* synthesis FREQUENCY_PIN_CLKOS3="0.0960000" */
     /* synthesis FREQUENCY_PIN_CLKOS2="6.144000" */
     /* synthesis FREQUENCY_PIN_CLKOS="256.000000" */
     /* synthesis FREQUENCY_PIN_CLKOP="48.000000" */
     /* synthesis FREQUENCY_PIN_CLKI="12.000000" */
     /* synthesis ICP_CURRENT="5" */
     /* synthesis LPF_RESISTOR="16" */;

	// exemplar begin
	// exemplar attribute PLLInst_0 FREQUENCY_PIN_CLKOS3 0.0960000
    // exemplar attribute PLLInst_0 FREQUENCY_PIN_CLKOS2 6.144000
    // exemplar attribute PLLInst_0 FREQUENCY_PIN_CLKOS 256.000000
    // exemplar attribute PLLInst_0 FREQUENCY_PIN_CLKOP 48.000000
    // exemplar attribute PLLInst_0 FREQUENCY_PIN_CLKI 12.000000
    // exemplar attribute PLLInst_0 ICP_CURRENT 5
    // exemplar attribute PLLInst_0 LPF_RESISTOR 16
    // exemplar end

`endif

endmodule