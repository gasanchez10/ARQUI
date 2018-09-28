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
module SC_RegFIXED #(parameter DATAWIDTH_BUS=8, parameter DATA_REGFIXED_INIT=8'b00000000)(
	//////////// OUTPUTS //////////
	SC_RegFIXED_DataBUS_Out,
	//////////// INPUTS //////////
	SC_RegFIXED_CLOCK_50,
	SC_RegFIXED_Reset_InHigh
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output reg		[DATAWIDTH_BUS-1:0] SC_RegFIXED_DataBUS_Out;
	input			SC_RegFIXED_CLOCK_50;
	input			SC_RegFIXED_Reset_InHigh;
//=======================================================
//  REG/WIRE declarations
//=======================================================
	reg [DATAWIDTH_BUS-1:0] RegFIXED_Register;
	reg [DATAWIDTH_BUS-1:0] RegFIXED_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always @ (*)
		RegFIXED_Signal = RegFIXED_Register;
// REGISTER : SEQUENTIAL
	always @ ( posedge SC_RegFIXED_CLOCK_50 , posedge SC_RegFIXED_Reset_InHigh)
	if (SC_RegFIXED_Reset_InHigh==1)
		RegFIXED_Register <= DATA_REGFIXED_INIT;
	else
		RegFIXED_Register <= RegFIXED_Signal;
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
	always @ (*)
		SC_RegFIXED_DataBUS_Out = RegFIXED_Register;  

endmodule

