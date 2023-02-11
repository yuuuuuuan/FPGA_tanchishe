//VGA
//(vga_xpos,vga_ypos)：当前点的坐标
module IP_VGA_640X480(clk,rst,rgb_sig,vga_rgb,vga_hs,vga_vs,vga_xypos);
	input clk;
	input rst;
	input[2:0] rgb_sig;
	output[2:0] vga_rgb;
	output vga_hs, vga_vs;
	output[20:0] vga_xypos;
	//行
	parameter H_CNT_MAX=10'd800; 
	parameter H_HS=10'd96;
	parameter H_BP=10'd48;
	parameter H_DISP=10'd640;
	parameter H_FP=10'd16;
	parameter H_Left=H_HS+H_BP;
	parameter H_Right=H_HS+H_BP+H_DISP;
	//列
	parameter V_CNT_MAX=10'd521;
	parameter V_HS=10'd2;
	parameter V_BP=10'd29;
	parameter V_DISP=10'd480;
	parameter V_FP=10'd10;
	parameter V_Left=V_HS+V_BP;
	parameter V_Right=V_HS+V_BP+V_DISP;	
	//25M时钟
	reg clk_25M;
	always@(posedge clk or negedge rst)
		if(!rst) clk_25M=0;
		else clk_25M=~clk_25M;
	//行列扫描
	reg[9:0] h_cnt,v_cnt;
	always@(posedge clk_25M or negedge rst) begin
		if(!rst) begin
			h_cnt<=0;
			v_cnt<=0;
		end
		else begin
			if(h_cnt==(H_CNT_MAX-1)) begin
				h_cnt<=0;
				if(v_cnt==(V_CNT_MAX-1)) v_cnt<=0;
				else v_cnt<=v_cnt+10'd1;
			end
			else h_cnt<=h_cnt+10'd1;
		end
	end
	//当前点在显示屏上的位置坐标
	wire[10:0]vga_xpos;
	wire[9:0]vga_ypos;
	assign vga_xypos={vga_xpos,vga_ypos};
	assign vga_xpos = h_cnt - H_Left;
	assign vga_ypos = v_cnt - V_Left;
	//HS
	assign vga_hs=(h_cnt<H_HS)? 1'b0: 1'b1;
	//VS
	assign vga_vs=(v_cnt<V_HS)? 1'b0: 1'b1;
	//显示的有效区域
	wire disp_valid;
	assign disp_valid=((h_cnt>=H_Left)&&(h_cnt<H_Right)&& (v_cnt>=V_Left)&&(v_cnt<V_Right)) ? 1'b1:1'b0;
	//液晶三色信号
	assign vga_rgb = disp_valid ? rgb_sig : 3'b000;
endmodule