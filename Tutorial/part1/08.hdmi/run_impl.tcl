open_project 08.hdmi.xpr

puts "Starting implementation..."
reset_run impl_1
launch_runs impl_1 -jobs 4
wait_on_run impl_1

set impl_run [get_runs impl_1]
set impl_status [get_property PROGRESS $impl_run]
if {$impl_status == "100%"} {
  puts "Implementation completed successfully!"
  
  puts "Generating bitstream..."
  launch_runs impl_1 -to_step write_bitstream -jobs 4
  wait_on_run impl_1
  puts "Bitstream generation completed!"
} else {
  puts "ERROR: Implementation failed!"
  exit 1
}

close_project
