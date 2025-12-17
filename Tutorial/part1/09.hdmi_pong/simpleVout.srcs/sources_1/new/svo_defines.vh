/*
 *  SVO - Simple Video Out FPGA Core
 *  Definitions Header File
 *
 *  Copyright (C) 2014  Clifford Wolf <clifford@clifford.at>
 *  
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *  
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

// Default parameter macro for SVO modules
`define SVO_DEFAULT_PARAMS \
	parameter SVO_MODE = "640x480", \
	parameter SVO_BITS_PER_PIXEL = 24, \
	parameter SVO_BITS_PER_RED = 8, \
	parameter SVO_BITS_PER_GREEN = 8, \
	parameter SVO_BITS_PER_BLUE = 8, \
	parameter SVO_BITS_PER_ALPHA = 0

// XY bits width macro - used in array declarations
// Set to 11 for high-res modes, 10 for standard modes
`define SVO_XYBITS 11

// Declaration macro - defines timing parameters based on SVO_MODE
`define SVO_DECLS \
	localparam SVO_HOR_PIXELS = \
		(SVO_MODE == "640x480")   ? 640 : \
		(SVO_MODE == "800x480")   ? 800 : \
		(SVO_MODE == "800x600")   ? 800 : \
		(SVO_MODE == "1024x768")  ? 1024 : \
		(SVO_MODE == "1280x720")  ? 1280 : \
		(SVO_MODE == "1920x1080") ? 1920 : 640; \
	localparam SVO_VER_PIXELS = \
		(SVO_MODE == "640x480")   ? 480 : \
		(SVO_MODE == "800x480")   ? 480 : \
		(SVO_MODE == "800x600")   ? 600 : \
		(SVO_MODE == "1024x768")  ? 768 : \
		(SVO_MODE == "1280x720")  ? 720 : \
		(SVO_MODE == "1920x1080") ? 1080 : 480; \
	localparam SVO_HOR_FRONT_PORCH = \
		(SVO_MODE == "640x480")   ? 16 : \
		(SVO_MODE == "800x480")   ? 40 : \
		(SVO_MODE == "800x600")   ? 40 : \
		(SVO_MODE == "1024x768")  ? 24 : \
		(SVO_MODE == "1280x720")  ? 110 : \
		(SVO_MODE == "1920x1080") ? 88 : 16; \
	localparam SVO_HOR_SYNC = \
		(SVO_MODE == "640x480")   ? 96 : \
		(SVO_MODE == "800x480")   ? 128 : \
		(SVO_MODE == "800x600")   ? 128 : \
		(SVO_MODE == "1024x768")  ? 136 : \
		(SVO_MODE == "1280x720")  ? 40 : \
		(SVO_MODE == "1920x1080") ? 44 : 96; \
	localparam SVO_HOR_BACK_PORCH = \
		(SVO_MODE == "640x480")   ? 48 : \
		(SVO_MODE == "800x480")   ? 88 : \
		(SVO_MODE == "800x600")   ? 88 : \
		(SVO_MODE == "1024x768")  ? 160 : \
		(SVO_MODE == "1280x720")  ? 220 : \
		(SVO_MODE == "1920x1080") ? 148 : 48; \
	localparam SVO_VER_FRONT_PORCH = \
		(SVO_MODE == "640x480")   ? 10 : \
		(SVO_MODE == "800x480")   ? 3 : \
		(SVO_MODE == "800x600")   ? 1 : \
		(SVO_MODE == "1024x768")  ? 3 : \
		(SVO_MODE == "1280x720")  ? 5 : \
		(SVO_MODE == "1920x1080") ? 4 : 10; \
	localparam SVO_VER_SYNC = \
		(SVO_MODE == "640x480")   ? 2 : \
		(SVO_MODE == "800x480")   ? 4 : \
		(SVO_MODE == "800x600")   ? 4 : \
		(SVO_MODE == "1024x768")  ? 6 : \
		(SVO_MODE == "1280x720")  ? 5 : \
		(SVO_MODE == "1920x1080") ? 5 : 2; \
	localparam SVO_VER_BACK_PORCH = \
		(SVO_MODE == "640x480")   ? 33 : \
		(SVO_MODE == "800x480")   ? 32 : \
		(SVO_MODE == "800x600")   ? 23 : \
		(SVO_MODE == "1024x768")  ? 29 : \
		(SVO_MODE == "1280x720")  ? 20 : \
		(SVO_MODE == "1920x1080") ? 36 : 33; \
	localparam SVO_HOR_TOTAL = SVO_HOR_PIXELS + SVO_HOR_FRONT_PORCH + SVO_HOR_SYNC + SVO_HOR_BACK_PORCH; \
	localparam SVO_VER_TOTAL = SVO_VER_PIXELS + SVO_VER_FRONT_PORCH + SVO_VER_SYNC + SVO_VER_BACK_PORCH;

// Video mode definitions
`ifdef MODE_640_480_60
	`define SVO_MODE "640x480"
	`define SVO_PIXCLK 25_175_000
	`define SVO_PIXCLK_N 10000
	`define SVO_PIXCLK_D 397
`endif

`ifdef MODE_800_480_75
	`define SVO_MODE "800x480"
	`define SVO_PIXCLK 33_333_333
	`define SVO_PIXCLK_N 3
	`define SVO_PIXCLK_D 9
`endif

`ifdef MODE_800_600_60
	`define SVO_MODE "800x600"
	`define SVO_PIXCLK 40_000_000
	`define SVO_PIXCLK_N 1
	`define SVO_PIXCLK_D 3
`endif

`ifdef MODE_1024_768_60
	`define SVO_MODE "1024x768"
	`define SVO_PIXCLK 65_000_000
	`define SVO_PIXCLK_N 13
	`define SVO_PIXCLK_D 25
`endif

`ifdef MODE_1280_720_60
	`define SVO_MODE "1280x720"
	`define SVO_PIXCLK 74_250_000
	`define SVO_PIXCLK_N 297
	`define SVO_PIXCLK_D 500
`endif

`ifdef MODE_1920_1080_60
	`define SVO_MODE "1920x1080"
	`define SVO_PIXCLK 148_500_000
	`define SVO_PIXCLK_N 297
	`define SVO_PIXCLK_D 250
`endif
