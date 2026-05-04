# 100 MHz system clock (Y2)
set_property -dict {LOC E18  IOSTANDARD LVDS} [get_ports {clk_100mhz_p}]
set_property -dict {LOC D18  IOSTANDARD LVDS} [get_ports {clk_100mhz_n}]
create_clock -period 10 -name clk_100mhz [get_ports {clk_100mhz_p}]

set_property direction IN [get_ports {sfp_mgt_clk_p}]
set_property direction IN [get_ports {sfp_mgt_clk_n}]
# make_diff_pair_ports sfp_mgt_clk_p sfp_mgt_clk_n
set_property IOSTANDARD LVDS [get_ports sfp_mgt_clk_p]
set_property PACKAGE_PIN K6 [get_ports sfp_mgt_clk_n]

#set_property DQS_BIAS TRUE [get_ports sfp_mgt_clk_p]

create_clock -period 6.400 -name clk_156.25MHz [get_ports sfp_mgt_clk_p]
