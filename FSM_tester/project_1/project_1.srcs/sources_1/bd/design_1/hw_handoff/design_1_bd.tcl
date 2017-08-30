
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2016.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a100tcsg324-1
}


# CHANGE DESIGN NAME HERE
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports

  # Create ports
  set AN [ create_bd_port -dir O -from 7 -to 0 AN ]
  set BTNC [ create_bd_port -dir I BTNC ]
  set clk [ create_bd_port -dir I clk ]
  set led [ create_bd_port -dir O -from 9 -to 0 led ]
  set seg [ create_bd_port -dir O -from 6 -to 0 seg ]

  # Create instance: BinToBCD16_0, and set properties
  set BinToBCD16_0 [ create_bd_cell -type ip -vlnv user.org:user:BinToBCD16:1.0 BinToBCD16_0 ]

  # Create instance: Count_Ones_0, and set properties
  set Count_Ones_0 [ create_bd_cell -type ip -vlnv user.org:user:Count_Ones:1.0 Count_Ones_0 ]
  set_property -dict [ list \
CONFIG.number_of_bits {256} \
 ] $Count_Ones_0

  # Create instance: EightDisplayControl_0, and set properties
  set EightDisplayControl_0 [ create_bd_cell -type ip -vlnv user.org:user:EightDisplayControl:1.0 EightDisplayControl_0 ]

  # Create instance: Unroll_ROM_last_0, and set properties
  set Unroll_ROM_last_0 [ create_bd_cell -type ip -vlnv user.org:user:Unroll_ROM_last:1.0 Unroll_ROM_last_0 ]
  set_property -dict [ list \
CONFIG.data_width {16} \
 ] $Unroll_ROM_last_0

  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.3 blk_mem_gen_0 ]
  set_property -dict [ list \
CONFIG.Byte_Size {9} \
CONFIG.Coe_File {8ones.coe} \
CONFIG.Enable_32bit_Address {false} \
CONFIG.Enable_A {Always_Enabled} \
CONFIG.Enable_B {Always_Enabled} \
CONFIG.Fill_Remaining_Memory_Locations {false} \
CONFIG.Load_Init_File {true} \
CONFIG.Memory_Type {Simple_Dual_Port_RAM} \
CONFIG.Operating_Mode_A {NO_CHANGE} \
CONFIG.Port_B_Clock {100} \
CONFIG.Port_B_Enable_Rate {100} \
CONFIG.Read_Width_A {16} \
CONFIG.Read_Width_B {16} \
CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
CONFIG.Use_Byte_Write_Enable {false} \
CONFIG.Use_RSTA_Pin {false} \
CONFIG.Write_Width_A {16} \
CONFIG.Write_Width_B {16} \
CONFIG.use_bram_block {Stand_Alone} \
 ] $blk_mem_gen_0

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property -dict [ list \
CONFIG.IN0_WIDTH {9} \
CONFIG.IN1_WIDTH {7} \
 ] $xlconcat_0

  # Create instance: xlconcat_1, and set properties
  set xlconcat_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_1 ]
  set_property -dict [ list \
CONFIG.IN0_WIDTH {1} \
CONFIG.IN1_WIDTH {9} \
 ] $xlconcat_1

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {7} \
 ] $xlconstant_0

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {4} \
 ] $xlconstant_1

  # Create instance: xlconstant_2, and set properties
  set xlconstant_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_2 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $xlconstant_2

  # Create instance: xlconstant_3, and set properties
  set xlconstant_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_3 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
CONFIG.CONST_WIDTH {16} \
 ] $xlconstant_3

  # Create instance: xlconstant_4, and set properties
  set xlconstant_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_4 ]

  # Create port connections
  connect_bd_net -net BTNC_1 [get_bd_ports BTNC] [get_bd_pins BinToBCD16_0/reset] [get_bd_pins Count_Ones_0/BTNC] [get_bd_pins Unroll_ROM_last_0/rst]
  connect_bd_net -net BinToBCD16_0_BCD0 [get_bd_pins BinToBCD16_0/BCD0] [get_bd_pins EightDisplayControl_0/rightR]
  connect_bd_net -net BinToBCD16_0_BCD1 [get_bd_pins BinToBCD16_0/BCD1] [get_bd_pins EightDisplayControl_0/near_rightR]
  connect_bd_net -net BinToBCD16_0_BCD2 [get_bd_pins BinToBCD16_0/BCD2] [get_bd_pins EightDisplayControl_0/near_leftR]
  connect_bd_net -net BinToBCD16_0_BCD3 [get_bd_pins BinToBCD16_0/BCD3] [get_bd_pins EightDisplayControl_0/leftR]
  connect_bd_net -net BinToBCD16_0_BCD4 [get_bd_pins BinToBCD16_0/BCD4] [get_bd_pins EightDisplayControl_0/rightL]
  connect_bd_net -net Count_Ones_0_data_out [get_bd_pins Count_Ones_0/data_out] [get_bd_pins xlconcat_0/In0] [get_bd_pins xlconcat_1/In1]
  connect_bd_net -net Count_Ones_0_finish [get_bd_pins Count_Ones_0/finish] [get_bd_pins xlconcat_1/In0]
  connect_bd_net -net EightDisplayControl_0_segments [get_bd_ports seg] [get_bd_pins EightDisplayControl_0/segments]
  connect_bd_net -net EightDisplayControl_0_select_display [get_bd_ports AN] [get_bd_pins EightDisplayControl_0/select_display]
  connect_bd_net -net Unroll_ROM_last_0_addr [get_bd_pins Unroll_ROM_last_0/addr] [get_bd_pins blk_mem_gen_0/addrb]
  connect_bd_net -net Unroll_ROM_last_0_data_out [get_bd_pins Count_Ones_0/data_in] [get_bd_pins Unroll_ROM_last_0/data_out]
  connect_bd_net -net blk_mem_gen_0_doutb [get_bd_pins Unroll_ROM_last_0/data_in] [get_bd_pins blk_mem_gen_0/doutb]
  connect_bd_net -net clk_1 [get_bd_ports clk] [get_bd_pins BinToBCD16_0/clk] [get_bd_pins Count_Ones_0/clk] [get_bd_pins EightDisplayControl_0/clk] [get_bd_pins Unroll_ROM_last_0/clk] [get_bd_pins blk_mem_gen_0/clka] [get_bd_pins blk_mem_gen_0/clkb]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins BinToBCD16_0/binary] [get_bd_pins xlconcat_0/dout]
  connect_bd_net -net xlconcat_1_dout [get_bd_ports led] [get_bd_pins xlconcat_1/dout]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins xlconcat_0/In1] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlconstant_1_dout [get_bd_pins EightDisplayControl_0/leftL] [get_bd_pins EightDisplayControl_0/near_leftL] [get_bd_pins EightDisplayControl_0/near_rightL] [get_bd_pins blk_mem_gen_0/addra] [get_bd_pins xlconstant_1/dout]
  connect_bd_net -net xlconstant_2_dout [get_bd_pins blk_mem_gen_0/wea] [get_bd_pins xlconstant_2/dout]
  connect_bd_net -net xlconstant_3_dout [get_bd_pins blk_mem_gen_0/dina] [get_bd_pins xlconstant_3/dout]
  connect_bd_net -net xlconstant_4_dout [get_bd_pins BinToBCD16_0/request] [get_bd_pins xlconstant_4/dout]

  # Create address segments

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.6.5b  2016-09-06 bk=1.3687 VDI=39 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port BTNC -pg 1 -y 370 -defaultsOSRD
preplace port clk -pg 1 -y 50 -defaultsOSRD
preplace portBus AN -pg 1 -y 120 -defaultsOSRD
preplace portBus led -pg 1 -y 350 -defaultsOSRD
preplace portBus seg -pg 1 -y 140 -defaultsOSRD
preplace inst EightDisplayControl_0 -pg 1 -lvl 4 -y 130 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 1 -y 290 -defaultsOSRD
preplace inst xlconstant_1 -pg 1 -lvl 3 -y 490 -defaultsOSRD
preplace inst xlconstant_2 -pg 1 -lvl 3 -y 650 -defaultsOSRD
preplace inst xlconstant_3 -pg 1 -lvl 3 -y 570 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 2 -y 330 -defaultsOSRD
preplace inst xlconcat_1 -pg 1 -lvl 5 -y 340 -defaultsOSRD
preplace inst xlconstant_4 -pg 1 -lvl 2 -y 190 -defaultsOSRD
preplace inst blk_mem_gen_0 -pg 1 -lvl 4 -y 520 -defaultsOSRD
preplace inst Count_Ones_0 -pg 1 -lvl 4 -y 340 -defaultsOSRD
preplace inst BinToBCD16_0 -pg 1 -lvl 3 -y 160 -defaultsOSRD
preplace inst Unroll_ROM_last_0 -pg 1 -lvl 3 -y 350 -defaultsOSRD
preplace netloc Unroll_ROM_last_0_data_out 1 3 1 660
preplace netloc xlconstant_1_dout 1 3 1 650
preplace netloc xlconstant_2_dout 1 3 1 700J
preplace netloc BinToBCD16_0_BCD0 1 3 1 N
preplace netloc BinToBCD16_0_BCD1 1 3 1 N
preplace netloc BinToBCD16_0_BCD2 1 3 1 N
preplace netloc xlconcat_1_dout 1 5 1 1170
preplace netloc BinToBCD16_0_BCD3 1 3 1 N
preplace netloc Count_Ones_0_data_out 1 1 4 170 270 NJ 270 NJ 270 990
preplace netloc BinToBCD16_0_BCD4 1 3 1 N
preplace netloc xlconcat_0_dout 1 2 1 360
preplace netloc xlconstant_0_dout 1 1 1 160J
preplace netloc clk_1 1 0 4 NJ 50 NJ 50 370 50 690
preplace netloc Count_Ones_0_finish 1 4 1 N
preplace netloc xlconstant_4_dout 1 2 1 NJ
preplace netloc EightDisplayControl_0_select_display 1 4 2 NJ 120 NJ
preplace netloc blk_mem_gen_0_doutb 1 2 2 390 700 710J
preplace netloc Unroll_ROM_last_0_addr 1 3 1 670
preplace netloc BTNC_1 1 0 4 0J 390 NJ 390 380 280 700J
preplace netloc EightDisplayControl_0_segments 1 4 2 NJ 140 NJ
preplace netloc xlconstant_3_dout 1 3 1 680J
levelinfo -pg 1 -20 90 270 520 850 1080 1190 -top 0 -bot 720
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


