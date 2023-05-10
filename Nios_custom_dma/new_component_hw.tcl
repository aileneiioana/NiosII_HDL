# TCL File Generated by Component Editor 22.1
# Tue May 02 21:32:15 EEST 2023
# DO NOT MODIFY


# 
# new_component "new_component" v1.0
#  2023.05.02.21:32:15
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module new_component
# 
set_module_property DESCRIPTION ""
set_module_property NAME new_component
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME new_component
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL dma_controller
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file dma_controller.v VERILOG PATH dma_controller.v TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter IDLE STD_LOGIC_VECTOR 0
set_parameter_property IDLE DEFAULT_VALUE 0
set_parameter_property IDLE DISPLAY_NAME IDLE
set_parameter_property IDLE TYPE STD_LOGIC_VECTOR
set_parameter_property IDLE UNITS None
set_parameter_property IDLE ALLOWED_RANGES 0:7
set_parameter_property IDLE HDL_PARAMETER true
add_parameter READ STD_LOGIC_VECTOR 1
set_parameter_property READ DEFAULT_VALUE 1
set_parameter_property READ DISPLAY_NAME READ
set_parameter_property READ TYPE STD_LOGIC_VECTOR
set_parameter_property READ UNITS None
set_parameter_property READ ALLOWED_RANGES 0:7
set_parameter_property READ HDL_PARAMETER true
add_parameter WRITE STD_LOGIC_VECTOR 2
set_parameter_property WRITE DEFAULT_VALUE 2
set_parameter_property WRITE DISPLAY_NAME WRITE
set_parameter_property WRITE TYPE STD_LOGIC_VECTOR
set_parameter_property WRITE UNITS None
set_parameter_property WRITE ALLOWED_RANGES 0:7
set_parameter_property WRITE HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point dma_ctl
# 
add_interface dma_ctl avalon end
set_interface_property dma_ctl addressUnits WORDS
set_interface_property dma_ctl associatedClock clock
set_interface_property dma_ctl associatedReset reset
set_interface_property dma_ctl bitsPerSymbol 8
set_interface_property dma_ctl burstOnBurstBoundariesOnly false
set_interface_property dma_ctl burstcountUnits WORDS
set_interface_property dma_ctl explicitAddressSpan 0
set_interface_property dma_ctl holdTime 0
set_interface_property dma_ctl linewrapBursts false
set_interface_property dma_ctl maximumPendingReadTransactions 0
set_interface_property dma_ctl maximumPendingWriteTransactions 0
set_interface_property dma_ctl readLatency 0
set_interface_property dma_ctl readWaitTime 1
set_interface_property dma_ctl setupTime 0
set_interface_property dma_ctl timingUnits Cycles
set_interface_property dma_ctl writeWaitTime 0
set_interface_property dma_ctl ENABLED true
set_interface_property dma_ctl EXPORT_OF ""
set_interface_property dma_ctl PORT_NAME_MAP ""
set_interface_property dma_ctl CMSIS_SVD_VARIABLES ""
set_interface_property dma_ctl SVD_ADDRESS_GROUP ""

add_interface_port dma_ctl dma_ctl_address address Input 3
add_interface_port dma_ctl dma_ctl_chipselect chipselect Input 1
add_interface_port dma_ctl dma_ctl_writedata writedata Input 13
add_interface_port dma_ctl dma_ctl_write_n write_n Input 1
add_interface_port dma_ctl dma_ctl_read_data readdata Output 13
add_interface_port dma_ctl dma_ctl_irq endofpacket Output 1
set_interface_assignment dma_ctl embeddedsw.configuration.isFlash 0
set_interface_assignment dma_ctl embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment dma_ctl embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment dma_ctl embeddedsw.configuration.isPrintableDevice 0


# 
# connection point write
# 
add_interface write avalon start
set_interface_property write addressUnits SYMBOLS
set_interface_property write associatedClock clock
set_interface_property write associatedReset reset
set_interface_property write bitsPerSymbol 8
set_interface_property write burstOnBurstBoundariesOnly false
set_interface_property write burstcountUnits WORDS
set_interface_property write doStreamReads false
set_interface_property write doStreamWrites false
set_interface_property write holdTime 0
set_interface_property write linewrapBursts false
set_interface_property write maximumPendingReadTransactions 0
set_interface_property write maximumPendingWriteTransactions 0
set_interface_property write readLatency 0
set_interface_property write readWaitTime 1
set_interface_property write setupTime 0
set_interface_property write timingUnits Cycles
set_interface_property write writeWaitTime 0
set_interface_property write ENABLED true
set_interface_property write EXPORT_OF ""
set_interface_property write PORT_NAME_MAP ""
set_interface_property write CMSIS_SVD_VARIABLES ""
set_interface_property write SVD_ADDRESS_GROUP ""

add_interface_port write write_address address Output 5
add_interface_port write write_chipselect chipselect Output 1
add_interface_port write write_readdatavalid readdatavalid Output 1
add_interface_port write write_write_n write_n Output 1
add_interface_port write write_writedata writedata Output 8
add_interface_port write write_wairequest waitrequest Output 1


# 
# connection point read
# 
add_interface read avalon start
set_interface_property read addressUnits SYMBOLS
set_interface_property read associatedClock clock
set_interface_property read associatedReset reset
set_interface_property read bitsPerSymbol 8
set_interface_property read burstOnBurstBoundariesOnly false
set_interface_property read burstcountUnits WORDS
set_interface_property read doStreamReads false
set_interface_property read doStreamWrites false
set_interface_property read holdTime 0
set_interface_property read linewrapBursts false
set_interface_property read maximumPendingReadTransactions 0
set_interface_property read maximumPendingWriteTransactions 0
set_interface_property read readLatency 0
set_interface_property read readWaitTime 1
set_interface_property read setupTime 0
set_interface_property read timingUnits Cycles
set_interface_property read writeWaitTime 0
set_interface_property read ENABLED true
set_interface_property read EXPORT_OF ""
set_interface_property read PORT_NAME_MAP ""
set_interface_property read CMSIS_SVD_VARIABLES ""
set_interface_property read SVD_ADDRESS_GROUP ""

add_interface_port read read_address address Output 5
add_interface_port read read_chipselect chipselect Output 1
add_interface_port read read_read_n read_n Output 1
add_interface_port read read_readdata readdata Input 8
add_interface_port read read_wairequest waitrequest Output 1
add_interface_port read read_readdatavalid readdatavalid Output 1

