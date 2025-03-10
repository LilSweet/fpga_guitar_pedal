set_msg_config -id "Vivado Tcl-4" -suppress

set project_name "fpga_guitar_pedal"
set project_dir "../"
set project_file "${project_name}.xpr"
set project_path [file normalize "[file join $project_dir $project_file]"]
set device_name "xc7a35tcpg236-1"

if {[file exists $project_path]} {
    puts "Project file already exists, exiting script..."
} else {
    #Create new project
    puts "Creating new project: ${project_name}"
    create_project ${project_name} ${project_dir} -part ${device_name}
    puts "Project created, closing project, and exiting script..."
    close_project
}

exit