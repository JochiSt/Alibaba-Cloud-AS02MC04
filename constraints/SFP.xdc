set_property -dict {LOC A4  } [get_ports {sfp_rx_0_p}] ;# MGTYRXP3_227 GTYE4_CHANNEL_X0Y15 / GTYE4_COMMON_X0Y3
set_property -dict {LOC A3  } [get_ports {sfp_rx_0_n}] ;# MGTYRXN3_227 GTYE4_CHANNEL_X0Y15 / GTYE4_COMMON_X0Y3
set_property -dict {LOC B2  } [get_ports {sfp_rx_1_p}] ;# MGTYRXP2_227 GTYE4_CHANNEL_X0Y14 / GTYE4_COMMON_X0Y3
set_property -dict {LOC B1  } [get_ports {sfp_rx_1_n}] ;# MGTYRXN2_227 GTYE4_CHANNEL_X0Y14 / GTYE4_COMMON_X0Y3
set_property -dict {LOC B7  } [get_ports {sfp_tx_0_p}] ;# MGTYTXP3_227 GTYE4_CHANNEL_X0Y15 / GTYE4_COMMON_X0Y3
set_property -dict {LOC B6  } [get_ports {sfp_tx_0_n}] ;# MGTYTXN3_227 GTYE4_CHANNEL_X0Y15 / GTYE4_COMMON_X0Y3
set_property -dict {LOC D7  } [get_ports {sfp_tx_1_p}] ;# MGTYTXP2_227 GTYE4_CHANNEL_X0Y14 / GTYE4_COMMON_X0Y3
set_property -dict {LOC D6  } [get_ports {sfp_tx_1_n}] ;# MGTYTXN2_227 GTYE4_CHANNEL_X0Y14 / GTYE4_COMMON_X0Y3

set_property -dict {LOC D14  IOSTANDARD LVCMOS33 PULLUP true} [get_ports {sfp_npres[0]}]
set_property -dict {LOC E11  IOSTANDARD LVCMOS33 PULLUP true} [get_ports {sfp_npres[1]}]
set_property -dict {LOC B14  IOSTANDARD LVCMOS33 PULLUP true} [get_ports {sfp_tx_fault[0]}]
set_property -dict {LOC F9   IOSTANDARD LVCMOS33 PULLUP true} [get_ports {sfp_tx_fault[1]}]
set_property -dict {LOC D13  IOSTANDARD LVCMOS33 PULLUP true} [get_ports {sfp_los[0]}]
set_property -dict {LOC E10  IOSTANDARD LVCMOS33 PULLUP true} [get_ports {sfp_los[1]}]

#set_property -dict {LOC C13  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12 PULLUP true} [get_ports {sfp_i2c_scl[0]}]
#set_property -dict {LOC D10  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12 PULLUP true} [get_ports {sfp_i2c_scl[1]}]
#set_property -dict {LOC C14  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12 PULLUP true} [get_ports {sfp_i2c_sda[0]}]
#set_property -dict {LOC D11  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12 PULLUP true} [get_ports {sfp_i2c_sda[1]}]

set_false_path -from [get_ports {sfp_npres[*] sfp_tx_fault[*] sfp_los[*]}]
set_input_delay 0 [get_ports {sfp_npres[*] sfp_tx_fault[*] sfp_los[*]}]
