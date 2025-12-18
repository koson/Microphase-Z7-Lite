// Clock Generator Module
// Input:  clk_in1 = 50 MHz
// Output: clk_out1 = 25 MHz (pixel clock)
// Output: clk_out2 = 125 MHz (TMDS clock = 5x pixel)


// Input: 50 MHz
// Target outputs: 25 MHz (pixel), 125 MHz (TMDS 5x)

// สูตร: Fvco = Fin × CLKFBOUT_MULT / DIVCLK_DIVIDE
//       Fout = Fvco / CLKOUTx_DIVIDE

// 50 × 25 / 1 = 1250 MHz (VCO)
// 1250 / 50 = 25 MHz ✓
// 1250 / 10 = 125 MHz ✓




module clock (
  input  clk_in1,      // 50 MHz input clock
  input  resetn,       // Reset active low
  output clk_out1,     // 25 MHz pixel clock
  output clk_out2,     // 125 MHz TMDS clock
  output locked        // PLL locked signal
);

  wire pll_feedback;
  wire clk_out1_unbuf;
  wire clk_out2_unbuf;
  wire pll_locked;

  // PLLE2_BASE for clock multiplication
  // Input: 50 MHz
  // VCO Calculation: Fvco = 50 * 25 / 1 = 1250 MHz
  // clk_out1 = 1250 / 50 = 25 MHz (pixel clock)
  // clk_out2 = 1250 / 10 = 125 MHz (TMDS clock 5x)
  
  PLLE2_BASE #(
    .BANDWIDTH("OPTIMIZED"),
    .CLKFBOUT_MULT(25),        // VCO multiplier for feedback path
    .CLKFBOUT_PHASE(0.0),      // Feedback output phase
    .DIVCLK_DIVIDE(1),         // Input clock divider (keep at 1)
    .REF_JITTER1(0.01),        // Reference jitter
    .CLKOUT0_DIVIDE(50),       // clk_out1 divider: 1250/50 = 25 MHz
    .CLKOUT1_DIVIDE(10),       // clk_out2 divider: 1250/10 = 125 MHz
    .CLKOUT0_DUTY_CYCLE(0.5),
    .CLKOUT1_DUTY_CYCLE(0.5),
    .CLKOUT0_PHASE(0.0),       // clk_out1 phase shift
    .CLKOUT1_PHASE(0.0),       // clk_out2 phase shift
    .CLKOUT2_DIVIDE(50),       // Unused but required
    .CLKOUT2_DUTY_CYCLE(0.5),
    .CLKOUT2_PHASE(0.0),
    .CLKOUT3_DIVIDE(50),
    .CLKOUT3_DUTY_CYCLE(0.5),
    .CLKOUT3_PHASE(0.0),
    .CLKOUT4_DIVIDE(50),
    .CLKOUT4_DUTY_CYCLE(0.5),
    .CLKOUT4_PHASE(0.0),
    .CLKOUT5_DIVIDE(50),
    .CLKOUT5_DUTY_CYCLE(0.5),
    .CLKOUT5_PHASE(0.0)
  ) pll_inst (
    .CLKIN1(clk_in1),
    .CLKOUT0(clk_out1_unbuf),
    .CLKOUT1(clk_out2_unbuf),
    .CLKFBOUT(pll_feedback),
    .CLKFBIN(pll_feedback),
    .LOCKED(pll_locked),
    .PWRDWN(1'b0),
    .RST(!resetn)              // Reset is active low
  );

  // Output buffers
  BUFG bufg_clk1x (
    .I(clk_out1_unbuf),
    .O(clk_out1)
  );

  BUFG bufg_clk5x (
    .I(clk_out2_unbuf),
    .O(clk_out2)
  );

  assign locked = pll_locked;

endmodule
