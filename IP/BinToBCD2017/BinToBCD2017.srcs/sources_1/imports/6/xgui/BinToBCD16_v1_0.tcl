# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "size_of_data_to_convert" -parent ${Page_0}


}

proc update_PARAM_VALUE.size_of_data_to_convert { PARAM_VALUE.size_of_data_to_convert } {
	# Procedure called to update size_of_data_to_convert when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.size_of_data_to_convert { PARAM_VALUE.size_of_data_to_convert } {
	# Procedure called to validate size_of_data_to_convert
	return true
}


proc update_MODELPARAM_VALUE.size_of_data_to_convert { MODELPARAM_VALUE.size_of_data_to_convert PARAM_VALUE.size_of_data_to_convert } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.size_of_data_to_convert}] ${MODELPARAM_VALUE.size_of_data_to_convert}
}

