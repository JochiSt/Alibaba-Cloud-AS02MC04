# 100 MHz system clock (Y2)
set_property -dict {LOC E18  IOSTANDARD LVDS} [get_ports {clk_100mhz_p}]
set_property -dict {LOC D18  IOSTANDARD LVDS} [get_ports {clk_100mhz_n}]
create_clock -period 10 -name clk_100mhz [get_ports {clk_100mhz_p}]

# 156.25 MHz MGT reference clock
#set_property direction IN [get_ports {sfp_mgt_clk_p}]
#set_property direction IN [get_ports {sfp_mgt_clk_n}]
set_property -dict {LOC K7 IOSTANDARD LVDS DQS_BIAS TRUE } [get_ports sfp_mgt_clk_p]; # MGTREFCLK0P_227 from Y1
set_property -dict {LOC K6 IOSTANDARD LVDS DQS_BIAS TRUE } [get_ports sfp_mgt_clk_n]; # MGTREFCLK0N_227 from Y1
create_clock -period 6.400 -name clk_156.25MHz [get_ports sfp_mgt_clk_p]
