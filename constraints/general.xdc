# General configuration
set_property CFGBVS GND                                      [current_design]
set_property CONFIG_VOLTAGE 1.8                              [current_design]

# bitstream
set_property BITSTREAM.GENERAL.COMPRESS true                 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup               [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 72.9                [current_design]
set_property CONFIG_MODE SPIx4                               [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4                 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE Yes              [current_design]
set_property BITSTREAM.CONFIG.OVERTEMPSHUTDOWN Enable        [current_design]