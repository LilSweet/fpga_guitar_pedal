set_msg_config -id "Vivado Tcl-4" -suppress

# Compile project and generate programming file

# Set project directory and name
set project_name "fpga_guitar_pedal"
set project_dir "../"
set project_file "${project_name}.xpr"
set project_path [file normalize "[file join $project_dir $project_file]"]
set output_dir [file normalize "[file join $project_dir "prog_images"]"]
set device_name "xc7a35tcpg236-1"
set rpt_dir "comp_reports"
set rpt_path [file normalize "[file join $project_dir $rpt_dir]"]

# Set version numbers
set major_version 0
set minor_version 0
set debug_version 1

proc create_folder {folder_path} {
    if {![file exists $folder_path]} {
        file mkdir $folder_path
    } else {
        puts "Folder already exists: $folder_path"
    }
}

puts "Creating output directory $output_dir"
create_folder $output_dir
puts "Creating report directory $rpt_path"
create_folder $rpt_path

# Open the project
open_project "$project_path"

# Compile the project
puts "Synthesizing project..."
synth_design -top top -part $device_name
write_checkpoint -force $output_dir/post_synth.dcp
report_timing_summary -file $rpt_path/post_synth_timing_summary.rpt
report_utilization -file $rpt_path/post_synth_util.rpt

#puts "Synthesis done, checking critical paths..."

# Run custom script to report critical timing paths
#reportCriticalPaths $output_dir/post_synth_critpath_report.csv

# run logic optimization, placement and physical logic optimization, 
# write design checkpoint, report utilization and timing estimates

#puts "Post synthesis critical path report located in folder: $rpt_path"
puts "Optimizing the design..."
opt_design
#puts "Optimization done, checking post optimization critical paths..."
#reportCriticalPaths $rpt_path/post_opt_critpath_report.csv
#puts "Post optimization critical path report located in folder: $rpt_path"
puts "Starting design placement..."
place_design
puts "Placement done, creating clock utilization report..."
report_clock_utilization -file $rpt_path/clock_util.rpt
puts "Clock utilization report located in folder: $rpt_path"

# Optionally run optimization if there are timing violations after placement
if {[get_property SLACK [get_timing_paths -max_paths 1 -nworst 1 -setup]] < 0} {
    puts "Found setup timing violations => running physical optimization"
    phys_opt_design
}

write_checkpoint -force $output_dir/post_place.dcp
report_utilization -file $rpt_path/post_place_util.rpt
report_timing_summary -file $rpt_path/post_place_timing_summary.rpt

# run the router, write the post-route design checkpoint, report the routing
# status, report timing, power, and DRC, and finally save the Verilog netlist.
#
puts "Routing the design..."
route_design
write_checkpoint -force $output_dir/post_route.dcp
report_route_status -file $rpt_path/post_route_status.rpt
report_timing_summary -file $rpt_path/post_route_timing_summary.rpt
report_power -file $rpt_path/post_route_power.rpt
report_drc -file $rpt_path/post_imp_drc.rpt
write_verilog -force $output_dir/cpu_impl_netlist.v -mode timesim -sdf_anno true

puts "Routing complete, reports can be found in folder: $rpt_path"

puts "Generating bitstream..."

#generate bitstream
write_bitstream -force $output_dir/"${major_version}.${minor_version}.${debug_version}".bit

# Close the project
close_project
puts "Project compiled successfully."