# Fix missing IP references in 08.hdmi project
open_project 08.hdmi.xpr

# List all IP files
set ip_files [get_files -filter {FILE_TYPE == "IP"}]
puts "Found [llength $ip_files] IP files:"
foreach ip $ip_files {
  puts "  - $ip"
}

# Try to remove missing IP references
if {[llength $ip_files] > 0} {
  puts "Removing IP files..."
  remove_files $ip_files
  save_project_as 08.hdmi -force
  puts "Project saved"
} else {
  puts "No IP files found - checking for broken references..."
  # Check project file for broken references
}

close_project
exit 0
