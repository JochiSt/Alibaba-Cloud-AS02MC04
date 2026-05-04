# LEDs
set_property -dict {LOC B12  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {sfp_led[0]}] ;# DS3
set_property -dict {LOC C12  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {sfp_led[1]}] ;# DS2

set_property -dict {LOC B11  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {led[0]}] ;# DS6
set_property -dict {LOC C11  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {led[1]}] ;# DS7
set_property -dict {LOC A10  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {led[2]}] ;# DS8
set_property -dict {LOC B10  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {led[3]}] ;# DS9

set_property -dict {LOC A13  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {led_r}] ;# C1
set_property -dict {LOC A12  IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {led_g}] ;# C1
set_property -dict {LOC B9   IOSTANDARD LVCMOS33 SLEW SLOW DRIVE 12} [get_ports {led_hb}] ;# DS5

# Reset button
set_property -dict {LOC F12  IOSTANDARD LVCMOS33} [get_ports sw_reset] ;# SW1

################################################################################
# timing of LEDs and Button
set_false_path -to [get_ports {sfp_led[*] led[*] led_r led_g led_hb}]
set_output_delay 0 [get_ports {sfp_led[*] led[*] led_r led_g led_hb}]

set_false_path -from [get_ports {reset}]
set_input_delay 0 [get_ports {reset}]


