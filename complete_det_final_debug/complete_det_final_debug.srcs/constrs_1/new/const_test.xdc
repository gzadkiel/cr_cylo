# ==============================================================================
# ZedBoard constraints for top.v
# Target: XC7Z020-CLG484-1
# ==============================================================================

# ------------------------------------------------------------------------------
# Clock - Bank 13 (3.3V fixed)
# On-board 100 MHz oscillator
# ------------------------------------------------------------------------------
#set_property PACKAGE_PIN Y9 [get_ports clock]
#set_property IOSTANDARD LVCMOS33 [get_ports clock]
#create_clock -period 25.000 -name sys_clk [get_ports clock]

# ------------------------------------------------------------------------------
# Reset - Bank 34 (1.8V)
# Mapped to BTNC (center push button), active high
# Press the center button to reset your module
# ------------------------------------------------------------------------------
#set_property PACKAGE_PIN P16       [get_ports {reset}]
#set_property IOSTANDARD  LVCMOS18  [get_ports {reset}]

# ------------------------------------------------------------------------------
# DDR Memory - managed by the Zynq PS7 primitive internally.
# Vivado requires these ports to exist at the top level but does NOT need
# explicit PACKAGE_PIN or IOSTANDARD constraints for them â€" the PS7
# primitive handles the physical mapping automatically.
# Do NOT add pin/iostandard constraints for DDR_* or FIXED_IO_* here.
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# IO Bank voltage standards
# These apply bank-wide and must come AFTER all PACKAGE_PIN assignments.
# ------------------------------------------------------------------------------
# Bank 13: fixed 3.3V (clock, JA, JB, JC, JD pmods, audio, OLED)
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 13]]

# Bank 33: fixed 3.3V (LEDs, VGA, HDMI)
#set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 33]]

# Bank 34: 1.8V default (buttons, switches SW4-SW7, XADC)
#set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 34]]

# Bank 35: 1.8V default (switches SW0-SW3, FMC)
#set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 35]]

