module Game
	(
		input clk,
		input rst,
		input ps2_clk,
		input ps2_dat,

	//	input 
        output vga_hs,
        output vga_vs,
		output[2:0] vga_rgb
	);
	//ģ��������
	wire P_up,P_down,P_left,P_right,ps2_done,vga_red,vga_blue,vga_green;
	wire[2:0] vga_color;
	wire [7:0]ps2;
	wire [7:0]ps2_code;
	wire [10:0]vga_xpos;
	wire [9:0]vga_ypos;
	wire [20:0]vga_zuobiao;
	assign vga_color={vga_red,vga_green,vga_blue};
	assign {vga_xpos,vga_ypos}=vga_zuobiao;
	
	IP_PS2_keyboard U0(.clk(clk),
	                .rst(rst),
	                .ps2_clk(ps2_clk),
	                .ps2_dat(ps2_dat),
	                .ps2_done(ps2_done),
	                .ps2_code(ps2));
	//ps2���̴���ģ�飬����ģ��			
	ps2_deal_Model U1
				(.clk(clk),
				.rst(rst),
				.ps2_done(ps2_done),
				.ps2(ps2),
				.P_up(P_up),
				.P_down(P_down),
				.P_left(P_left),
				.P_right(P_right));
	//��Ϸ��ģ��
	Game_Main_Model U2
				(.clk(clk),
				.rst(rst),
				.P_up(P_up),
				.P_down(P_down),
				.P_left(P_left),
				.P_right(P_right),
				.vga_xpos(vga_xpos),
                .vga_ypos(vga_ypos),
				.vga_red(vga_red),
				.vga_blue(vga_blue),
				.vga_green(vga_green));
	IP_VGA_640X480 U3(.clk(clk),
	                   .rst(rst),
	                   .rgb_sig(vga_color),//(vga_green),(vga_blue)),
	                   .vga_rgb(vga_rgb),														
	                   .vga_hs(vga_hs),
	                   .vga_vs(vga_vs),
	                   .vga_xypos(vga_zuobiao));
	                   
endmodule