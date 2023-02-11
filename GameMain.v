//ÓÎÏ·Ö÷Ä£¿é
module Game_Main_Model(clk,rst,P_up,P_down,P_left,P_right,vga_xpos,vga_ypos,vga_red,vga_blue,vga_green);
	input clk;
	input rst;
	input P_up,P_down,P_left,P_right;
	input [10:0]vga_xpos;
	input [9:0]vga_ypos;
	output vga_red;
	output vga_blue;
	output vga_green;

	wire [10:0]vga_xpos;
	wire [9:0]vga_ypos;
	wire vga_b_red,vga_b_blue,vga_b_green,vga_c_red,vga_c_blue,vga_c_green,vga_t_green,vga_f_blue,vga_red,vga_blue,vga_green;
	wire [200:0]s,m,n;
	wire s_all;
	wire [31:0]a;
	wire the_end;
	Game_control U1
					(.clk(clk),
					.rst(rst),
					.P_up(P_up),					
					.P_down(P_down),
					.P_left(P_left),
					.P_right(P_right),
					.vga_xpos(vga_xpos),
					.vga_ypos(vga_ypos),
					.vga_red(vga_c_red),
					.vga_blue(vga_c_blue),
					.vga_green(vga_c_green),
					.the_end(the_end));
					
	Game_backgroud U2
					(.vga_xpos(vga_xpos),
					.vga_ypos(vga_ypos),
					.vga_green(vga_b_green));
					
	merge U3
				(.the_end(the_end),
				.vga_b_green(vga_b_green),
				.vga_c_red(vga_c_red),
				.vga_c_blue(vga_c_blue),
				.vga_c_green(vga_c_green),
				.vga_t_green(vga_t_green),
				.vga_red(vga_red),
				.vga_blue(vga_blue),
				.vga_green(vga_green));	
				
	The_End U4
				(.vga_xpos(vga_xpos),
				.vga_ypos(vga_ypos),
				.vga_green(vga_t_green));					
endmodule