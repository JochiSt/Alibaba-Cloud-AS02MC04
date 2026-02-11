.PHONY: prog

prog: bitstream
	openFPGALoader --cable digilent_hs2 --ftdi-serial 210249BF31A2 --detect
	openFPGALoader --cable digilent_hs2 --ftdi-serial 210249BF31A2 $(PROJECT).runs/impl_1/$(TOP_MODULE).bit
	@date
