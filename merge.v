module merge(the_end,vga_b_green,vga_c_red,vga_c_green,vga_c_blue,vga_t_green,vga_red,vga_blue,vga_green);	
	input the_end;
	input vga_b_green;
	input vga_c_red;
	input vga_c_blue;
	input vga_c_green;
	input vga_t_green;
	output vga_red;
	output vga_blue;
	output vga_green;
	//判断是否撞身，加上颜色
	//先把颜色合在一起，在gamemain模块实现类似vhdl的元件例化
	assign vga_red =  the_end ? 1'b0 : vga_c_red ;
	assign vga_blue = the_end ? 1'b0 : vga_c_blue;
	assign vga_green = the_end ? vga_t_green : (vga_b_green | vga_c_green);
	
endmodule
//(这只是对游戏模块的颜色合并在一起，后面的例化更方便)