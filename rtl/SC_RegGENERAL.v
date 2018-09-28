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
module SC_RegGENERAL #(parameter DATAWIDTH_BUS=8)(
	//////////// OUTPUTS //////////
	SC_RegGENERAL_DataBUS_Out,
	//////////// INPUTS //////////
	SC_RegGENERAL_CLOCK_50,
	SC_RegGENERAL_Reset_InHigh,
	SC_RegGENERAL_Write_InLow,
	SC_RegGENERAL_DataBUS_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output reg	[DATAWIDTH_BUS-1:0] SC_RegGENERAL_DataBUS_Out;
	input			SC_RegGENERAL_CLOCK_50;
	input			SC_RegGENERAL_Reset_InHigh;
	input			SC_RegGENERAL_Write_InLow;
	input 		[DATAWIDTH_BUS-1:0] SC_RegGENERAL_DataBUS_In;
//=======================================================
//  REG/WIRE declarations
//=======================================================
	reg [DATAWIDTH_BUS-1:0] RegGENERAL_Register;
	reg [DATAWIDTH_BUS-1:0] RegGENERAL_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always @ (*)
	if (SC_RegGENERAL_Write_InLow == 0)	
		RegGENERAL_Signal = SC_RegGENERAL_DataBUS_In;
	else 	
		RegGENERAL_Signal = RegGENERAL_Register;

// REGISTER : SEQUENTIAL
	always @ ( posedge SC_RegGENERAL_CLOCK_50 , posedge SC_RegGENERAL_Reset_InHigh)
	if (SC_RegGENERAL_Reset_InHigh==1)
		RegGENERAL_Register <= 0;
	else
		RegGENERAL_Register <= RegGENERAL_Signal;
//=======================================================
//  Outputs
//=======================================================
// OUTPUT LOGIC : COMBINATIONAL
	always @ (*)
		SC_RegGENERAL_DataBUS_Out = RegGENERAL_Register;  

endmodule

