set_msg_config -id "Vivado Tcl-4" -suppress

set project_name "fpga_guitar_pedal"
set project_dir "../"
set source_dir "src/"
set xdc_dir "xdc/"
set project_file "${project_name}.xpr"
set project_path [file normalize "[file join $project_dir $project_file]"]
set source_path [file normalize "[file join $project_dir $source_dir]"]
set xdc_path [file normalize "[file join $project_dir $source_dir $xdc_dir]"]

open_project $project_path

#                                                                                               GENERATE MMCM                                                                       #
create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name sys_mmcm
set_property -dict [list \
  CONFIG.CLKIN1_JITTER_PS {833.33} \
  CONFIG.CLKOUT1_JITTER {479.872} \
  CONFIG.CLKOUT1_PHASE_ERROR {668.310} \
  CONFIG.CLKOUT2_JITTER {380.336} \
  CONFIG.CLKOUT2_PHASE_ERROR {668.310} \
  CONFIG.CLKOUT2_USED {true} \
  CONFIG.CLKOUT3_JITTER {380.336} \
  CONFIG.CLKOUT3_PHASE_ERROR {668.310} \
  CONFIG.CLKOUT3_USED {true} \
  CONFIG.CLKOUT4_JITTER {380.336} \
  CONFIG.CLKOUT4_PHASE_ERROR {668.310} \
  CONFIG.CLKOUT4_USED {false} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {64} \
  CONFIG.MMCM_CLKIN1_PERIOD {83.333} \
  CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {31.250} \
  CONFIG.MMCM_CLKOUT1_DIVIDE {4} \
  CONFIG.MMCM_CLKOUT2_DIVIDE {125} \
  CONFIG.MMCM_COMPENSATION {ZHOLD} \
  CONFIG.MMCM_DIVCLK_DIVIDE {1} \
  CONFIG.NUM_OUT_CLKS {3} \
  CONFIG.OVERRIDE_MMCM {true} \
  CONFIG.PRIM_IN_FREQ {12.000} \
] [get_ips sys_mmcm]
generate_target {instantiation_template} [get_files d:/vivado_projects/fpga_guitar_pedal/src/ip/sys_mmcm/sys_mmcm.xci]
update_compile_order -fileset sources_1
generate_target all [get_files  d:/vivado_projects/fpga_guitar_pedal/fpga_guitar_pedal.srcs/sources_1/ip/sys_mmcm/sys_mmcm.xci]

catch { config_ip_cache -export [get_ips -all sys_mmcm] }
export_ip_user_files -of_objects [get_files d:/vivado_projects/fpga_guitar_pedal/fpga_guitar_pedal.srcs/sources_1/ip/sys_mmcm/sys_mmcm.xci] -no_script -sync -force -quiet
export_simulation -of_objects [get_files d:/vivado_projects/fpga_guitar_pedal/fpga_guitar_pedal.srcs/sources_1/ip/sys_mmcm/sys_mmcm.xci] -directory D:/vivado_projects/fpga_guitar_pedal/fpga_guitar_pedal.ip_user_files/sim_scripts -ip_user_files_dir D:/vivado_projects/fpga_guitar_pedal/fpga_guitar_pedal.ip_user_files -ipstatic_source_dir D:/vivado_projects/fpga_guitar_pedal/fpga_guitar_pedal.ip_user_files/ipstatic -lib_map_path [list {modelsim=D:/vivado_projects/fpga_guitar_pedal/fpga_guitar_pedal.cache/compile_simlib/modelsim} {questa=D:/vivado_projects/fpga_guitar_pedal/fpga_guitar_pedal.cache/compile_simlib/questa} {riviera=D:/vivado_projects/fpga_guitar_pedal/fpga_guitar_pedal.cache/compile_simlib/riviera} {activehdl=D:/vivado_projects/fpga_guitar_pedal/fpga_guitar_pedal.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
