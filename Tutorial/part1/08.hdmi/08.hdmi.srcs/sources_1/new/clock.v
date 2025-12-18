// Clock Generator Module
// Input:  clk_in1 = 50 MHz
// Output: clk_out1 = 25 MHz (pixel clock)
// Output: clk_out2 = 125 MHz (TMDS clock = 5x pixel)

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
  // VCO = 50 * 25 = 1250 MHz
  // clk_out1 = 1250 / 50 = 25 MHz (pixel clock)
  // clk_out2 = 1250 / 10 = 125 MHz (TMDS clock 5x)
  
  PLLE2_BASE #(
    .CLKFBOUT_MULT(25),      // VCO multiplier
    .CLKOUT0_DIVIDE(50),     // clk_out1 divider
    .CLKOUT1_DIVIDE(10),     // clk_out2 divider
    .CLKOUT0_DUTY_CYCLE(0.5),
    .CLKOUT1_DUTY_CYCLE(0.5),
    .CLKOUT0_PHASE(0.0),
    .CLKOUT1_PHASE(0.0)
  ) pll_inst (
    .CLKIN1(clk_in1),
    .CLKOUT0(clk_out1_unbuf),
    .CLKOUT1(clk_out2_unbuf),
    .CLKFBOUT(pll_feedback),
    .CLKFBIN(pll_feedback),
    .LOCKED(pll_locked),
    .PWRDWN(1'b0),
    .RST(!resetn)  // Reset is active low
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
