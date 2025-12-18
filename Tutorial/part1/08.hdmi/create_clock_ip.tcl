# Create missing clock IP
open_project 08.hdmi.xpr

# Create IP directory if needed
set ip_dir "$::env(PCACHEDIR)/ip"

# Create clock IP using Vivado IP Catalog
create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name clock -dir {./08.hdmi.srcs/sources_1/ip}

set_property -dict {CONFIG.PRIMITIVE {MMCME2_ADV} CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {25} CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {125} CONFIG.USE_RESET {true} CONFIG.RESET_TYPE {ACTIVE_LOW} CONFIG.RESET_PORT {resetn}} [get_ips clock]

# Generate the IP
generate_target {instantiation_template} [get_files {./08.hdmi.srcs/sources_1/ip/clock/clock.xci}]
generate_target all [get_files  {./08.hdmi.srcs/sources_1/ip/clock/clock.xci}]

# Save project
save_project_as 08.hdmi -force

puts "Clock IP created successfully!"
close_project
exit 0
