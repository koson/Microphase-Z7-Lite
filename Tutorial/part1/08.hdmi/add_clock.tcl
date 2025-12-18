# Add clock.v to the project
open_project 08.hdmi.xpr

# Add the clock.v file to sources_1
add_files -fileset sources_1 {./08.hdmi.srcs/sources_1/new/clock.v}

# Save project
save_project_as 08.hdmi -force

puts "File added successfully!"
close_project
exit 0
