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
module BB_SYSTEM (
//////////// OUTPUTS //////////
	BB_SYSTEM_DataBUSDisplay_Out,
//////////// INPUTS //////////
	BB_SYSTEM_CLOCK_50,
	BB_SYSTEM_Reset_InHigh
);
//=======================================================
//  PARAMETER declarations
//=======================================================
	parameter DATAWIDTH_BUS = 8;
// SHIFT_REGISTER CONTROL
	parameter DATAWIDTH_REGSHIFTER_SELECTION = 2;
// DECODER CONTROL:  TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA FROM DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
	parameter DATAWIDTH_DECODER_SELECTION = 3;
// ALU CONTROL
	parameter DATAWIDTH_ALU_SELECTION = 4;
// FIXED_REGISTERS INIT
	parameter DATA_REGFIXED_INIT_0 = 8'b00001001;
	parameter DATA_REGFIXED_INIT_1 = 8'b00001111;
// DECODER CONTROL:  TO GENERATE WRITE SIGNAL TO GENERAL_REGISTERS TO WRITE DATA FROM DATA_BUS_C. ¡ONE BY ONE, NOT AT SAME TIME!
	parameter DATAWIDTH_DECODER_OUT = 4;
// MUX CONTROL: TO SELECT OUTPUT REGISTER TO BUS_A, BUS_B OR BOTH OF THEM
	parameter DATAWIDTH_MUX_SELECTION = 3;

//=======================================================
//  PORT declarations
//=======================================================
	output	[DATAWIDTH_BUS-1:0] BB_SYSTEM_DataBUSDisplay_Out;
	input 	BB_SYSTEM_CLOCK_50;
	input 	BB_SYSTEM_Reset_InHigh;
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
WB_SYSTEM #(.DATAWIDTH_BUS(DATAWIDTH_BUS), .DATAWIDTH_REGSHIFTER_SELECTION(DATAWIDTH_REGSHIFTER_SELECTION), .DATAWIDTH_DECODER_SELECTION(DATAWIDTH_DECODER_SELECTION), .DATAWIDTH_ALU_SELECTION(DATAWIDTH_ALU_SELECTION), .DATA_REGFIXED_INIT_0(DATA_REGFIXED_INIT_0), .DATA_REGFIXED_INIT_1(DATA_REGFIXED_INIT_1), .DATAWIDTH_DECODER_OUT(DATAWIDTH_DECODER_OUT), .DATAWIDTH_MUX_SELECTION(DATAWIDTH_MUX_SELECTION)) WB_SYSTEM_u0 (
// port map - connection between master ports and signals/registers   
	.WB_SYSTEM_DataBUSDisplay_Out(BB_SYSTEM_DataBUSDisplay_Out),
	.WB_SYSTEM_CLOCK_50(BB_SYSTEM_CLOCK_50),
	.WB_SYSTEM_Reset_InHigh(BB_SYSTEM_Reset_InHigh)
);
endmodule
