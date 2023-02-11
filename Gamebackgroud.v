//±³¾°
module Game_backgroud(vga_xpos,vga_ypos,vga_green);
	input [10:0]vga_xpos;
	input [9:0]vga_ypos;
	output vga_green;

	//ËÄ¶ÂÇ½
	wire k1 , k2 , k3 , k4 ,k_all;
	assign k1 = ((vga_xpos > 30 ) && (vga_xpos < 40 ) && (vga_ypos > 50 ) && (vga_ypos < 440 ) );
	assign k2 = ((vga_xpos > 610 ) && (vga_xpos < 620 ) && (vga_ypos > 50 ) && (vga_ypos < 440 ) );
	assign k3 = ((vga_xpos > 30 ) && (vga_xpos <620 ) && (vga_ypos > 50 ) && (vga_ypos < 60 ) );
	assign k4 = ((vga_xpos > 30 ) && (vga_xpos < 620 ) && (vga_ypos > 430 ) && (vga_ypos < 440 ) );
	
	assign k_all = k1 | k2 | k3 | k4;
   //my mame:DLH 
	//d
	wire d1,d2,d3,d4,d_all;
	assign d1 = ((vga_xpos > 40 ) && (vga_xpos < 50 ) && (vga_ypos > 20 ) && (vga_ypos < 40 ) );
	assign d2 = ((vga_xpos > 70 ) && (vga_xpos < 80 ) && (vga_ypos > 0 ) && (vga_ypos < 40 ) );
	assign d3 = ((vga_xpos > 40 ) && (vga_xpos <80 ) && (vga_ypos > 20 ) && (vga_ypos < 25 ) );
	assign d4 = ((vga_xpos > 40 ) && (vga_xpos < 80 ) && (vga_ypos > 35 ) && (vga_ypos < 40 ) );
	
	assign d_all = d1 | d2 | d3 | d4;
	//l
	wire l1,l2,l_all;
	assign l1 = ((vga_xpos > 200 ) && (vga_xpos < 210 ) && (vga_ypos > 0 ) && (vga_ypos < 40 ) );
	assign l2 = ((vga_xpos >200) && (vga_xpos < 230 ) && (vga_ypos > 35 ) && (vga_ypos < 40 ) );
	
	assign l_all = l1 | l2 ; 	
	
	//h
	wire h1,h2,h3,h_all;
	assign h1 = ((vga_xpos > 350 ) && (vga_xpos <360 ) && (vga_ypos > 0 ) && (vga_ypos < 40 ) );
	assign h2 = ((vga_xpos > 380 ) && (vga_xpos < 390 ) && (vga_ypos > 0 ) && (vga_ypos < 40 ) );
	assign h3 = ((vga_xpos > 350 ) && (vga_xpos < 390 ) && (vga_ypos > 18 ) && (vga_ypos < 23 ) );	
	
	assign h_all = h1 | h2 | h3 ;

	
	assign vga_green = k_all | d_all | l_all | h_all ;
	
endmodule