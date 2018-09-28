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
module SC_RegSHIFTER #(parameter DATAWIDTH_BUS=8, parameter DATAWIDTH_REGSHIFTER_SELECTION=2)(
	//////////// OUTPUTS //////////
	SC_RegSHIFTER_DataBUS_Out,
	//////////// INPUTS //////////
	SC_RegSHIFTER_CLOCK_50,
	SC_RegSHIFTER_Reset_InHigh,
	SC_RegSHIFTER_Load_InLow,
	SC_RegSHIFTER_ShiftSelection_InLow,
	SC_RegSHIFTER_DataBUS_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	input		SC_RegSHIFTER_CLOCK_50;
	input		SC_RegSHIFTER_Reset_InHigh;
	input		SC_RegSHIFTER_Load_InLow;	
	input		[DATAWIDTH_REGSHIFTER_SELECTION-1:0] SC_RegSHIFTER_ShiftSelection_InLow;
	input		[DATAWIDTH_BUS-1:0]	SC_RegSHIFTER_DataBUS_In;
	output		[DATAWIDTH_BUS-1:0]	SC_RegSHIFTER_DataBUS_Out;
//=======================================================
//  REG/WIRE declarations
//=======================================================
reg [DATAWIDTH_BUS-1:0] RegSHIFTER_Register;
reg [DATAWIDTH_BUS-1:0] RegSHIFTER_Signal;
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always @(*)
	if (SC_RegSHIFTER_Load_InLow == 1'b0)
	begin
		RegSHIFTER_Signal = SC_RegSHIFTER_DataBUS_In;
	end
	else if (SC_RegSHIFTER_ShiftSelection_InLow == 2'b01)
	begin
		RegSHIFTER_Signal = RegSHIFTER_Register << 1'b1;   //RegSHIFTER_Signal = {RegSHIFTER_Register[DATAWIDTH_BUS-2:0],0}
	end
	else if (SC_RegSHIFTER_ShiftSelection_InLow == 2'b10)
	begin 
		RegSHIFTER_Signal = RegSHIFTER_Register >> 1'b1;   //RegSHIFTER_Signal = {0,RegSHIFTER_Register[DATAWIDTH_BUS-1:1]}
	end
	else
	begin
		RegSHIFTER_Signal = RegSHIFTER_Register;
	end	
//STATE REGISTER: SEQUENTIAL
	always @(posedge SC_RegSHIFTER_CLOCK_50, posedge SC_RegSHIFTER_Reset_InHigh)
	if (SC_RegSHIFTER_Reset_InHigh == 1'b1) begin
		RegSHIFTER_Register <= 0;
	end
	else begin
		RegSHIFTER_Register <= RegSHIFTER_Signal;
	end
//=======================================================
//  Outputs
//=======================================================
//OUTPUT LOGIC: COMBINATIONAL
	assign SC_RegSHIFTER_DataBUS_Out = RegSHIFTER_Register;

endmodule
