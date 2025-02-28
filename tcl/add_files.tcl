set project_name "fpga_guitar_pedal"
set project_dir "../"
set source_dir "src/"
set xdc_dir "xdc/"
set project_file "${project_name}.xpr"
set project_path [file normalize "[file join $project_dir $project_file]"]
set source_path [file normalize "[file join $project_dir $source_dir]"]
set xdc_path [file normalize "[file join $project_dir $source_dir $xdc_dir]"]

set file_types {".sv" ".v" ".vhd"}

open_project $project_path

# Read the .xpr file and extract existing source files
set existing_files [get_files]

# Check if the project is empty
if {[llength $existing_files] == 0} {
    puts "No files found in the project. Adding all files from the src directory..."
    # If the project is empty, add all files from the src directory without comparison
    foreach file [glob -nocomplain -directory ${source_path} *.sv *.v *.vhd *.svh] {
        add_files $file
        puts "Added file: $file"
    }
    foreach file [glob -nocomplain -directory ${xdc_path} *.xdc] {
        add_files $file
        puts "Added file: $file"
    }
} else {
    puts "Existing files detected, checking for new files..."

    # Iterate over files in the src directory
    foreach file [glob -nocomplain -directory ${source_path} *.sv *.v *.vhd *.svh] {
        if {[lsearch -exact $existing_files $file] == -1} {
            add_files $file
            puts "Added new file: $file"
        } else {
            puts "File already in project: $file"
        }
    }
    foreach file [glob -nocomplain -directory ${xdc_path} *.xdc] {
        if {[lsearch -exact $existing_files $file] == -1} {
            add_files $file
            puts "Added new file: $file"
        } else {
            puts "File already in project: $file"
        }
    }
}

puts "Project updated and saved."

puts "Setting top level file..."

set_property top top [current_fileset]
update_compile_order -fileset sources_1
