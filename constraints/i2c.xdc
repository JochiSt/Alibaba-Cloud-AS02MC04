# I2C interface
#set_property -dict {LOC G9   IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12 PULLUP true} [get_ports {i2c_scl[0]}]
#set_property -dict {LOC G10  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12 PULLUP true} [get_ports {i2c_sda[0]}]
#set_property -dict {LOC J14  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12 PULLUP true} [get_ports {i2c_scl[1]}]
#set_property -dict {LOC J15  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12 PULLUP true} [get_ports {i2c_sda[1]}]

#set_false_path -to [get_ports {i2c_sda[*] i2c_scl[*]}]
#set_output_delay 0 [get_ports {i2c_sda[*] i2c_scl[*]}]
#set_false_path -from [get_ports {i2c_sda[*] i2c_scl[*]}]
#set_input_delay 0 [get_ports {i2c_sda[*] i2c_scl[*]}]
