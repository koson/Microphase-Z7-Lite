# Rebuild hdmi_pong project with corrected clock settings
open_project simpleVout.xpr

# Reset runs to force fresh synthesis and implementation
reset_run synth_1
reset_run impl_1

# Run synthesis
puts "Starting synthesis..."
launch_runs synth_1 -jobs 4
wait_on_run synth_1

if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {
    puts "ERROR: Synthesis failed!"
    exit 1
}
puts "Synthesis completed successfully!"

# Run implementation
puts "Starting implementation..."
launch_runs impl_1 -jobs 4
wait_on_run impl_1

if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {
    puts "ERROR: Implementation failed!"
    exit 1
}
puts "Implementation completed successfully!"

# Generate bitstream
puts "Generating bitstream..."
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1

puts "Build completed successfully!"
puts "Bitstream available at: [get_property DIRECTORY [get_runs impl_1]]/simpleVout.bit"

exit 0
