// HDMI Top Module - Simplified Version
// Generates test pattern and outputs HDMI/DVI signal
`timescale 1ns / 1ps

module hdmi_trans_top(
	input	wire 			clk 		,  // 50 MHz input clock
	input 	wire			rst_n 		,  // Reset active low
	output 					tmds_clk_n,
	output 					tmds_clk_p,
	output [2:0] 			tmds_d_n,
	output [2:0] 			tmds_d_p
);

// Clock and reset signals
wire 				locked 		;
wire 				rst 		;
wire 				clk1x 		;  // 25 MHz pixel clock
wire 				clk5x 		;  // 125 MHz TMDS clock

// Video signals
wire 	[7:0]		rgb_r 		;
wire 	[7:0]		rgb_g 		;
wire 	[7:0]		rgb_b 		;
wire 				vpg_de 		;
wire 				vpg_hs 		;
wire 				vpg_vs 		;

// Reset is derived from PLL lock signal
assign rst = ~locked;

// PLL Clock Generator (50MHz -> 25MHz + 125MHz)
clock inst_clock(
	.clk_in1(clk),      // 50 MHz input
	.resetn(rst_n),     // Reset active low
	.clk_out1(clk1x),   // 25 MHz pixel clock
	.clk_out2(clk5x),   // 125 MHz TMDS clock (5x)
	.locked(locked)     // PLL lock indicator
);

// Video Pattern Generator (test pattern)
vga_shift inst_vga_shift (
	.rst(rst),
	.vpg_pclk(clk1x),
	.vpg_de(vpg_de),
	.vpg_hs(vpg_hs),
	.vpg_vs(vpg_vs),
	.rgb_r(rgb_r),
	.rgb_g(rgb_g),
	.rgb_b(rgb_b)
);

// RGB to DVI/HDMI Encoder (8B10B encoding + serialization)
rgb2dvi inst_rgb2dvi(
	.pixel_clk(clk1x),  // 25 MHz pixel clock
	.tmds_clk(clk5x),   // 125 MHz TMDS clock
	.resetn(~rst),      // Reset active low
	
	// RGB data input
	.data_r(rgb_r),
	.data_g(rgb_g),
	.data_b(rgb_b),
	.data_hs(vpg_hs),
	.data_vs(vpg_vs),
	.data_de(vpg_de),
	
	// TMDS differential output
	.tmds_clk_n(tmds_clk_n),
	.tmds_clk_p(tmds_clk_p),
	.tmds_d_n(tmds_d_n),
	.tmds_d_p(tmds_d_p)
);

endmodule



