onerror {resume}
quietly WaveActivateNextPane {} 0
delete wave *
add wave -noupdate /TB_SYSTEM/eachvec

add wave  -divider uDATAPATH
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_CLOCK_50
add wave -noupdate /TB_SYSTEM/TB_SYSTEM_Reset_InHigh
add wave  -radix Unsigned /TB_SYSTEM/TB_SYSTEM_DataBUSDisplay_Out

add wave  -divider REGISTERS
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/SC_RegFIXED_u0/SC_RegFIXED_DataBUS_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/SC_RegFIXED_u1/SC_RegFIXED_DataBUS_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/SC_RegGENERAL_u0/SC_RegGENERAL_DataBUS_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/SC_RegGENERAL_u1/SC_RegGENERAL_DataBUS_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/SC_RegGENERAL_u2/SC_RegGENERAL_DataBUS_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/SC_RegGENERAL_u3/SC_RegGENERAL_DataBUS_Out
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/SC_RegSHIFTER_u0/SC_RegSHIFTER_DataBUS_Out

add wave  -divider STATEMACHINE
add wave -noupdate -radix decimal /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/SC_STATEMACHINE_u0/State_Register

add wave  -divider ALU
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/CC_ALU_u0/CC_ALU_DataBUSA_In
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/CC_ALU_u0/CC_ALU_DataBUSB_In
add wave  -noupdate -radix Unsigned /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/CC_ALU_u0/CC_ALU_DataBUS_Out
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/CC_ALU_u0/CC_ALU_Overflow_OutLow
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/CC_ALU_u0/CC_ALU_Carry_OutLow
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/CC_ALU_u0/CC_ALU_Negative_OutLow
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/CC_ALU_u0/CC_ALU_Zero_OutLow
add wave -noupdate /TB_SYSTEM/BB_SYSTEM_u0/WB_SYSTEM_u0/uDataPath_u0/CC_ALU_u0/CC_ALU_Selection_In


restart
run 1ms

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {319999492 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 445
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {59829352 ps} {60892417 ps}
