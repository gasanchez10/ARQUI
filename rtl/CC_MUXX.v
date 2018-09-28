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
module CC_MUXX #(parameter DATAWIDTH_MUX_SELECTION=3, parameter DATAWIDTH_BUS=8)(
	//////////// OUTPUTS //////////
	CC_MUX_DataBUS_Out,
	//////////// INPUTS //////////
	CC_MUX_DataBUS_In_0,
	CC_MUX_DataBUS_In_1,
	CC_MUX_DataBUS_In_2,	
	CC_MUX_DataBUS_In_3,	
	CC_MUX_DataBUS_In_4,	
	CC_MUX_DataBUS_In_5,	
	CC_MUX_DataBUS_In_6,	
	CC_MUX_DataBUS_In_7,	
	CC_MUX_Selection_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output reg	[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_Out;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_0;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_1;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_2;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_3;	
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_4;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_5;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_6;
	input			[DATAWIDTH_BUS-1:0] CC_MUX_DataBUS_In_7;
	input			[DATAWIDTH_MUX_SELECTION-1:0] CC_MUX_Selection_In;	
//=======================================================
//  REG/WIRE declarations
//=======================================================

//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always@(*)
	begin
	case (CC_MUX_Selection_In)	
	// Example to more outputs: WaitStart: begin sResetCounter = 0; sCuenteUP = 0; end
		3'b000: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_0;
		3'b001: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_1;
		3'b010: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_2;
		3'b011: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_3;
		3'b100: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_4;
		3'b101: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_5;
		3'b110: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_6;
		3'b111: CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_7;
		default :   CC_MUX_DataBUS_Out = CC_MUX_DataBUS_In_0; // channel 0 is selected 
		endcase
	end
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL

endmodule

