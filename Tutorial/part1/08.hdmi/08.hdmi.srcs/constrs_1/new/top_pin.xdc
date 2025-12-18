############## clock define##################
# System clock: 50 MHz input
create_clock -add -name sys_clk_pin -period 20.000 -waveform {0 10} [get_ports clk]
set_property PACKAGE_PIN N18 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# Timing constraints
set_false_path -from [get_ports rst_n]

############## key define##################
set_property PACKAGE_PIN P16 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]

#########################################################
# TMDS (DVI, HDMI)                                      #
# HDMI uses 1.0V differential TMDS signaling            #
#########################################################

# TMDS Clock differential pair (125 MHz)
set_property PACKAGE_PIN U19 [get_ports tmds_clk_n]
set_property IOSTANDARD TMDS_33 [get_ports tmds_clk_n]
set_property DIFF_TERM TRUE [get_ports tmds_clk_n]

set_property PACKAGE_PIN U18 [get_ports tmds_clk_p]
set_property IOSTANDARD TMDS_33 [get_ports tmds_clk_p]
set_property DIFF_TERM TRUE [get_ports tmds_clk_p]

# TMDS Data Channel 0 (Red) - differential pair
set_property PACKAGE_PIN W20 [get_ports {tmds_d_n[0]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmds_d_n[0]}]
set_property DIFF_TERM TRUE [get_ports {tmds_d_n[0]}]

set_property PACKAGE_PIN V20 [get_ports {tmds_d_p[0]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmds_d_p[0]}]
set_property DIFF_TERM TRUE [get_ports {tmds_d_p[0]}]

# TMDS Data Channel 1 (Green) - differential pair
set_property PACKAGE_PIN U20 [get_ports {tmds_d_n[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmds_d_n[1]}]
set_property DIFF_TERM TRUE [get_ports {tmds_d_n[1]}]

set_property PACKAGE_PIN T20 [get_ports {tmds_d_p[1]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmds_d_p[1]}]
set_property DIFF_TERM TRUE [get_ports {tmds_d_p[1]}]

# TMDS Data Channel 2 (Blue) - differential pair
set_property PACKAGE_PIN P20 [get_ports {tmds_d_n[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmds_d_n[2]}]
set_property DIFF_TERM TRUE [get_ports {tmds_d_n[2]}]

set_property PACKAGE_PIN N20 [get_ports {tmds_d_p[2]}]
set_property IOSTANDARD TMDS_33 [get_ports {tmds_d_p[2]}]
set_property DIFF_TERM TRUE [get_ports {tmds_d_p[2]}]

