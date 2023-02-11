//ps2键盘解码模块
module ps2_deal_Model(clk,rst,ps2_done,ps2,P_up,P_down,P_left,P_right);
	input clk;
	input rst;
	input ps2_done;
	input [7:0]ps2;
	output reg P_up,P_down,P_left,P_right;
//---------------------------------------------------------------		
	always @(posedge clk or negedge rst)
		if(!rst)
			begin
				P_up = 0; 
				P_down = 0;
				P_left = 0;
				P_right = 0;
			end
		else if(ps2_done)
			case(ps2) //ps2通码解码 
				8'h6b : P_left = 1; 
				8'h72 : P_down = 1;
				8'h74 : P_right = 1;
				8'h75 : P_up = 1;
				default: ;
			endcase
		else 
			begin
				P_up = 0; 
				P_down = 0;
				P_left = 0;
				P_right = 0;
			end
	//---------------------------------------------------------
endmodule