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
module CC_ALU #(parameter DATAWIDTH_BUS=8, parameter DATAWIDTH_ALU_SELECTION=4)(
	//////////// OUTPUTS //////////
	CC_ALU_Overflow_OutLow,
	CC_ALU_Carry_OutLow,
	CC_ALU_Negative_OutLow,
	CC_ALU_Zero_OutLow,
	CC_ALU_DataBUS_Out,
	//////////// INPUTS //////////
	CC_ALU_DataBUSA_In,
	CC_ALU_DataBUSB_In,
	CC_ALU_Selection_In
);
//=======================================================
//  PARAMETER declarations
//=======================================================

//=======================================================
//  PORT declarations
//=======================================================
	output 			CC_ALU_Overflow_OutLow;
	output 			CC_ALU_Carry_OutLow;
	output 			CC_ALU_Negative_OutLow;
	output 			CC_ALU_Zero_OutLow;
	output reg		[DATAWIDTH_BUS-1:0] CC_ALU_DataBUS_Out;
	input			[DATAWIDTH_BUS-1:0] CC_ALU_DataBUSA_In;
	input			[DATAWIDTH_BUS-1:0] CC_ALU_DataBUSB_In;
	input			[DATAWIDTH_ALU_SELECTION-1:0] CC_ALU_Selection_In;
//=======================================================
//  REG/WIRE declarations
//=======================================================
	wire caover,cout;
	wire [DATAWIDTH_BUS-2:0] addition0; // Variable usada para la operación suma y para determinar las flags
	wire addition1;		// Variable usada para la operación suma y para determinar las flags
//=======================================================
//  Structural coding
//=======================================================
//INPUT LOGIC: COMBINATIONAL
	always@(*)
	begin
	case (CC_ALU_Selection_In)	
		4'b0000:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In; 					//BUSA
		4'b0001:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In | CC_ALU_DataBUSB_In;	//OR
		4'b0010:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In & CC_ALU_DataBUSB_In;	//AND
		4'b0011:  CC_ALU_DataBUS_Out = ~CC_ALU_DataBUSA_In;					//NOT
		4'b0100:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In ^ CC_ALU_DataBUSB_In;	//XOR
		4'b0101:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In;					//BUSA Can be other function
		4'b0110:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In;					//BUSA Can be other function
		4'b0111:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In;					//BUSA Can be other function

		4'b1000:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In + CC_ALU_DataBUSB_In;	//ADD
		4'b1001:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In - CC_ALU_DataBUSB_In;	//SUB
		4'b1010:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In + 1'b1;				//INCREMENT A
		4'b1011:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In - 1'b1;				//DECREMENT A
		4'b1100:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In;					//BUSA Can be other function
		4'b1101:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In;					//BUSA Can be other function
		4'b1110:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In;					//BUSA Can be other function
		4'b1111:  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In;					//BUSA DO NOTHING!!!!!!!!		
		default :  CC_ALU_DataBUS_Out = CC_ALU_DataBUSA_In; // channel 0 is selected
	endcase
	end
//=======================================================
//  Outputs
//=======================================================
/*Flags*/
assign {caover,addition0[DATAWIDTH_BUS-2:0]}=CC_ALU_DataBUSA_In[DATAWIDTH_BUS-2:0] + CC_ALU_DataBUSB_In[DATAWIDTH_BUS-2:0]; 	// Determinación de carry del bit número 7
assign {cout,addition1}= CC_ALU_DataBUSA_In[DATAWIDTH_BUS-1] + CC_ALU_DataBUSB_In[DATAWIDTH_BUS-1] + caover;	// Determinación de la flag Carry y la suma de busA y busB
assign CC_ALU_Zero_OutLow=(CC_ALU_DataBUS_Out==8'b00000000) ? 1'b0 : 1'b1;	// Determinación de la flag Zero
assign CC_ALU_Carry_OutLow = ~cout;
assign CC_ALU_Overflow_OutLow = ~ (caover ^ cout);		// Determinación de la flag Ov a partir de la flag Carry y el carry del bit 7
assign CC_ALU_Negative_OutLow = ~ (CC_ALU_DataBUS_Out[DATAWIDTH_BUS-1]);	

endmodule


