//##########################################################################
//######					G0B1T HDL EXAMPLES											####
//######	Fredy Enrique Segura-Quijano fsegura@uniandes.edu.co				####   
//######																						####   
//######				MODIFICADO: Marzo de 2018 - FES								####   
//##########################################################################
//# G0B1T
//# Copyright (C) 2018 Bogotá, Colombia
//# 
//# This program is free software: you can redistribute it and/or modify
//# it under the terms of the GNU General Public License as published by
//# the Free Software Foundation, version 3 of the License.
//#
//# This program is distributed in the hope that it will be useful,
//# but WITHOUT ANY WARRANTY; without even the implied warranty of
//# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//# GNU General Public License for more details.
//#
//# You should have received a copy of the GNU General Public License
//# along with this program.  If not, see <http://www.gnu.org/licenses/>.
//#/
//###########################################################################

//=======================================================
//  MODULE Definition
//=======================================================
module SC_STATEMACHINE #(parameter DATAWIDTH_DECODER_SELECTION=3, parameter DATAWIDTH_MUX_SELECTION=3, parameter DATAWIDTH_ALU_SELECTION=4,  parameter DATAWIDTH_REGSHIFTER_SELECTION=2 ) (
	//////////// OUTPUTS //////////
	SC_STATEMACHINE_DecoderSelectionWrite_Out,
	SC_STATEMACHINE_MUXSelectionBUSA_Out,
	SC_STATEMACHINE_MUXSelectionBUSB_Out,
	SC_STATEMACHINE_ALUSelection_Out,
	SC_STATEMACHINE_RegSHIFTERLoad_OutLow,
	SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow,
	//////////// INPUTS //////////
	SC_STATEMACHINE_CLOCK_50,
	SC_STATEMACHINE_Reset_InHigh,
	SC_STATEMACHINE_Overflow_InLow,
	SC_STATEMACHINE_Carry_InLow,
	SC_STATEMACHINE_Negative_InLow,
	SC_STATEMACHINE_Zero_InLow
);	
//=======================================================
//  PARAMETER declarations
//=======================================================
// states declaration
	localparam State_RESET_0									= 0;
	localparam State_START_0									= 1;
	localparam State_MOV_RegGEN2_RegFIX1_0					= 2;
	localparam State_MOV_RegGEN2_RegFIX1_1					= 3;
	localparam State_MOV_RegGEN2_RegFIX1_2					= 4;
	localparam State_MOV_RegGEN3_RegFIX0_0					= 5;
	localparam State_MOV_RegGEN3_RegFIX0_1					= 6;
	localparam State_MOV_RegGEN3_RegFIX0_2					= 7;
	localparam State_DEC_RegGEN2_0							= 8;
	localparam State_DEC_RegGEN2_1							= 9;	
	localparam State_DEC_RegGEN2_2							= 10;		
	localparam State_ADD_RegGEN3_RegGEN3_RegFIX0_0		= 11;		
	localparam State_ADD_RegGEN3_RegGEN3_RegFIX0_1		= 12;		
	localparam State_ADD_RegGEN3_RegGEN3_RegFIX0_2		= 13;		
	localparam State_END_0										= 14;


//=======================================================
//  PORT declarations
//=======================================================
	output reg	[DATAWIDTH_DECODER_SELECTION-1:0] SC_STATEMACHINE_DecoderSelectionWrite_Out;
	output reg	[DATAWIDTH_MUX_SELECTION-1:0] SC_STATEMACHINE_MUXSelectionBUSA_Out;
	output reg	[DATAWIDTH_MUX_SELECTION-1:0] SC_STATEMACHINE_MUXSelectionBUSB_Out;
	output reg	[DATAWIDTH_ALU_SELECTION-1:0] SC_STATEMACHINE_ALUSelection_Out;
	output reg	SC_STATEMACHINE_RegSHIFTERLoad_OutLow;
	output reg	[DATAWIDTH_REGSHIFTER_SELECTION-1:0] SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow;
	input			SC_STATEMACHINE_CLOCK_50;
	input			SC_STATEMACHINE_Reset_InHigh;
	input			SC_STATEMACHINE_Overflow_InLow;	
	input			SC_STATEMACHINE_Carry_InLow;	
	input			SC_STATEMACHINE_Negative_InLow;	
	input			SC_STATEMACHINE_Zero_InLow;		
//=======================================================
//  REG/WIRE declarations
//=======================================================
	reg [7:0] State_Register;
	reg [7:0] State_Signal;
	//wire [15:0] State_uInstruction;

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
// NEXT STATE LOGIC : COMBINATIONAL
	always @(*)
	case (State_Register)
	//TO INIT REGISTERS
		// 
		State_RESET_0: State_Signal = State_START_0;
		State_START_0: State_Signal = State_MOV_RegGEN2_RegFIX1_0;
		
		State_MOV_RegGEN2_RegFIX1_0: State_Signal = State_MOV_RegGEN2_RegFIX1_1;
		State_MOV_RegGEN2_RegFIX1_1: State_Signal = State_MOV_RegGEN2_RegFIX1_2;		
		State_MOV_RegGEN2_RegFIX1_2: State_Signal = State_MOV_RegGEN3_RegFIX0_0;
		
		State_MOV_RegGEN3_RegFIX0_0: State_Signal = State_MOV_RegGEN3_RegFIX0_1;
		State_MOV_RegGEN3_RegFIX0_1: State_Signal = State_MOV_RegGEN3_RegFIX0_2;
		State_MOV_RegGEN3_RegFIX0_2: State_Signal = State_DEC_RegGEN2_0;
		
		State_DEC_RegGEN2_0: if (SC_STATEMACHINE_Zero_InLow == 1) State_Signal = State_DEC_RegGEN2_1;
									else State_Signal = State_END_0;
		State_DEC_RegGEN2_1: State_Signal = State_DEC_RegGEN2_2;
		State_DEC_RegGEN2_2: State_Signal = State_ADD_RegGEN3_RegGEN3_RegFIX0_0;		
		State_ADD_RegGEN3_RegGEN3_RegFIX0_0: State_Signal = State_ADD_RegGEN3_RegGEN3_RegFIX0_1;		
		State_ADD_RegGEN3_RegGEN3_RegFIX0_1: State_Signal = State_ADD_RegGEN3_RegGEN3_RegFIX0_2;				
		State_ADD_RegGEN3_RegGEN3_RegFIX0_2: State_Signal = State_DEC_RegGEN2_0;
		State_END_0: State_Signal = State_END_0;
		
		default : State_Signal = State_RESET_0;
	endcase
	
// STATE REGISTER : SEQUENTIAL
	always @ ( posedge SC_STATEMACHINE_CLOCK_50 , posedge SC_STATEMACHINE_Reset_InHigh)
	if (SC_STATEMACHINE_Reset_InHigh==1)
		State_Register <= State_RESET_0;
	else
		State_Register <= State_Signal;
		
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

//	assign State_uInstruction = {State_uInstruction,StateMachine_MUXSelectionBUSA_Out,StateMachine_MUXSelectionBUSB_Out,StateMachine_ALUSelection_Out,StateMachine_RegSHIFTERLoad_OutLow,StateMachine_RegSHIFTERShiftSelection_OutLow}
	always @ (*)
	case (State_Register)
//=========================================================
// RESET STATE
//=========================================================
	State_RESET_0 :	
		begin	
		//=========================================================
		// WRITE DATA: FROM BUSC TO GENERAL REGISTERS
		//=========================================================
			// 111 NO GenREG Selected; 000 GenREG_0, ... 011 GenREG_3;
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
		//=========================================================
		// READ DATA: FROM REGISTER(FIXED OR GENERAL) TO BUSA or BUS_B or BOTH OF THEM
		//=========================================================
			// TO BUS A: 000 RegGen_0; 001 RegGen_1; 010 RegGen_2; 011 RegGen_3; 100 RegFIX_0; 101 RegFIX_1; 110 NA; 111 NA;
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			// TO BUS B: 000 RegGen_0; 001 RegGen_1; 010 RegGen_2; 011 RegGen_3; 100 RegFIX_0; 101 RegFIX_1; 110 NA; 111 NA;
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
		//=========================================================
		// ALU OPERATION: 
		//=========================================================
			// 0000 BUSA; 0001 OR; 0010 AND; 0011 NOT A; 0100 XOR; 0101-0111 A; 1000 ADD; 1001 SUB; 1010 INC; 1011 DEC; 1100-1111 A;
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;
		//=========================================================
		// SHIFT REGISTER CONTROL: LOAD DATA IN REGSHIFER and REGSHIFER SELECTION
		//=========================================================
			// LOAD: 1 NO LOAD;  0 LOAD;
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			// SHIFT: 01 ShiftLeft; 10 ShiftRight; 00-11 NOTHING
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end

//=========================================================
// START STATE
//=========================================================
	State_START_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end

//=========================================================
// MUL: RegGEN3 = RegFIX0 * RegFIX1
//=========================================================
// SE ASUME MULIPLICACION DE NUMEROS POSITIVOS
// RegFIX0: Multiplicando (El que se suma RegFIX1 veces)
// RegFIX1: Multiplicador
// RegGEN2: ACUMULADOR PARCIAL DE LA ITERACION
// RegGEN3: ACUMULADOR PARCIAL DE LA MULTIPLICACION

// 	 			RegGEN2 = RegFIX1; 		(Los 3 pasos de la operacion)
// 				RegGEN3 = RegFIX0;		(Los 3 pasos de la operacion)
//  	NEXT2:	RegGEN2 = RegGEN2 - 1; 	(Paso 1 para ver banderas)
//		 			if (StateMachine_Zero_InLow = 1) 
//						goto NEXT1;
//					else
//						goto END;						
//		NEXT1:	RegGEN2 = RegGEN2 - 1;	(Los 2 pasos siguientes de la operacion)
//  				RegGEN3 = RegGEN3 + RegFIX0; (Los 3 pasos de la operacion)
//		 				goto NEXT2;
//		END:			goto END;
	

//=========================================================
// A: 			RegGEN2 = RegFIX1;
//=========================================================
	State_MOV_RegGEN2_RegFIX1_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b101;				//*
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					//*
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_MOV_RegGEN2_RegFIX1_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b101;				//*
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					//*
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//*
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_MOV_RegGEN2_RegFIX1_2 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b010;		//*
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
//=========================================================
// B: 			RegGEN3 = RegFIX0;
//=========================================================
	State_MOV_RegGEN3_RegFIX0_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b100;				//*
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					//*
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_MOV_RegGEN3_RegFIX0_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b100;				//*
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b0000;					//*
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//*
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_MOV_RegGEN3_RegFIX0_2 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b011;		//*
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
//=========================================================
// C. REPEAT:	RegGEN2 = RegGEN2 - 1; 
//=========================================================
	State_DEC_RegGEN2_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b010;				//*
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1011;					//*
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_DEC_RegGEN2_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b010;				//*
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1011;					//*
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//*
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_DEC_RegGEN2_2 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b010;		//*
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
//=========================================================
// D. 				RegGEN3 = RegGEN3 + RegFIX0;
//=========================================================
	State_ADD_RegGEN3_RegGEN3_RegFIX0_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b011;				//*
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b100;				//*
			SC_STATEMACHINE_ALUSelection_Out = 4'b1000;					//*
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_ADD_RegGEN3_RegGEN3_RegFIX0_1 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b011;				//*
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b100;				//*
			SC_STATEMACHINE_ALUSelection_Out = 4'b1000;					//*
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 0;					//*
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
	State_ADD_RegGEN3_RegGEN3_RegFIX0_2 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b011;		//*
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;					
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;					
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end		
		
//=========================================================
// END STATE
//=========================================================
	State_END_0 :	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;	
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;				
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;				
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;						
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;		
		end	
//=========================================================
// DEFAULT
//=========================================================
	default:	
		begin	
			SC_STATEMACHINE_DecoderSelectionWrite_Out = 3'b111;
			SC_STATEMACHINE_MUXSelectionBUSA_Out = 3'b111;
			SC_STATEMACHINE_MUXSelectionBUSB_Out = 3'b111;
			SC_STATEMACHINE_ALUSelection_Out = 4'b1111;
			SC_STATEMACHINE_RegSHIFTERLoad_OutLow = 1;
			SC_STATEMACHINE_RegSHIFTERShiftSelection_OutLow = 2'b11;
		end
endcase

endmodule
