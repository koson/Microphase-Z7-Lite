# Rebuild 08.hdmi project
open_project 08.hdmi.xpr

# Reset and rebuild synthesis
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

set synth_status [get_property PROGRESS [get_runs synth_1]]
puts "Synthesis status: $synth_status"

if {$synth_status != "100%"} {
  puts "ERROR: Synthesis failed!"
  exit 1
}

puts "Synthesis completed successfully!"
exit 0
