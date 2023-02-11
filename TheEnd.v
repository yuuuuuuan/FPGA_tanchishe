module The_End(vga_xpos,vga_ypos,vga_green);
	input [10:0] vga_xpos;
	input [9:0] vga_ypos;
	output vga_green;
	//The End
	//T
	wire letter_t_1, letter_t_2,letter_t_all;
	assign letter_t_1  = ((vga_xpos > 60 ) && (vga_xpos < 120 ) && (vga_ypos > 200 ) && (vga_ypos < 205 ) );
	assign letter_t_2  = ((vga_xpos > 90 ) && (vga_xpos < 95 ) && (vga_ypos > 200 ) && (vga_ypos < 300 ) );
	assign letter_t_all = letter_t_1 | letter_t_2 ;
	//h
	wire letter_h_1, letter_h_2, letter_h_3,letter_h_all;
	assign letter_h_1  = ((vga_xpos > 160 ) && (vga_xpos < 165 ) && (vga_ypos > 200 ) && (vga_ypos < 300 ) );
	assign letter_h_2  = ((vga_xpos > 160 ) && (vga_xpos < 220 ) && (vga_ypos > 250 ) && (vga_ypos < 255 ) );
	assign letter_h_3  = ((vga_xpos > 215 ) && (vga_xpos < 220 ) && (vga_ypos > 250 ) && (vga_ypos < 300 ) );
	assign letter_h_all = letter_h_1 | letter_h_2 | letter_h_3;
	//e
	wire letter_e1_1, letter_e1_2,letter_e1_3, letter_e1_4, letter_e1_5 ,letter_e1_all;
	assign letter_e1_1  = ((vga_xpos > 260 ) && (vga_xpos < 320 ) && (vga_ypos > 220 ) && (vga_ypos < 225 ) );
	assign letter_e1_2  = ((vga_xpos > 260 ) && (vga_xpos < 265 ) && (vga_ypos > 220 ) && (vga_ypos < 300 ) );
	assign letter_e1_3  = ((vga_xpos > 260 ) && (vga_xpos < 320 ) && (vga_ypos > 250 ) && (vga_ypos < 255 ) );
	assign letter_e1_4  = ((vga_xpos > 260 ) && (vga_xpos < 320 ) && (vga_ypos > 295 ) && (vga_ypos < 300 ) );
	assign letter_e1_5  = ((vga_xpos > 315 ) && (vga_xpos < 320 ) && (vga_ypos > 220 ) && (vga_ypos < 255 ) );
	assign letter_e1_all = letter_e1_1 | letter_e1_2 | letter_e1_3 | letter_e1_4 | letter_e1_5;
	//E
	wire letter_e2_1, letter_e2_2,letter_e2_3, letter_e2_4 ,letter_e2_all;
	assign letter_e2_1  = ((vga_xpos > 360 ) && (vga_xpos < 420 ) && (vga_ypos > 200 ) && (vga_ypos < 205 ) );
	assign letter_e2_2  = ((vga_xpos > 360 ) && (vga_xpos < 365 ) && (vga_ypos > 200 ) && (vga_ypos < 300 ) );
	assign letter_e2_3  = ((vga_xpos > 360 ) && (vga_xpos < 410 ) && (vga_ypos > 250 ) && (vga_ypos < 255 ) );
	assign letter_e2_4  = ((vga_xpos > 360 ) && (vga_xpos < 420 ) && (vga_ypos > 295 ) && (vga_ypos < 300 ) );
	assign letter_e2_all = letter_e2_1 | letter_e2_2 | letter_e2_3 | letter_e2_4;	
	//n
	wire letter_n_1, letter_n_2, letter_n_3,letter_n_all;
	assign letter_n_1  = ((vga_xpos > 460 ) && (vga_xpos < 465 ) && (vga_ypos > 230 ) && (vga_ypos < 300 ) );
	assign letter_n_2  = ((vga_xpos > 460 ) && (vga_xpos < 520 ) && (vga_ypos > 230 ) && (vga_ypos < 235 ) );
	assign letter_n_3  = ((vga_xpos > 515 ) && (vga_xpos < 520 ) && (vga_ypos > 230 ) && (vga_ypos < 300 ) );
	assign letter_n_all = letter_n_1 | letter_n_2 | letter_n_3;	
	//d
	wire letter_d_1, letter_d_2,letter_d_3,letter_d_4,letter_d_all;
	assign letter_d_1  = ((vga_xpos > 560 ) && (vga_xpos < 565 ) && (vga_ypos > 250 ) && (vga_ypos < 300 ) );
	assign letter_d_2  = ((vga_xpos > 560 ) && (vga_xpos < 620 ) && (vga_ypos > 250 ) && (vga_ypos < 255 ) );
	assign letter_d_3  = ((vga_xpos > 560 ) && (vga_xpos < 620 ) && (vga_ypos > 295 ) && (vga_ypos < 300 ) );
	assign letter_d_4  = ((vga_xpos > 615 ) && (vga_xpos < 620 ) && (vga_ypos > 200 ) && (vga_ypos < 300 ) );
	assign letter_d_all = letter_d_1 | letter_d_2 | letter_d_3 | letter_d_4;
	//The End
	assign vga_green = letter_t_all | letter_h_all | letter_e1_all | letter_e2_all | letter_n_all | letter_d_all; 
	
endmodule