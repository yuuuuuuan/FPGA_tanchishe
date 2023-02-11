// =======================================================//
//当有按键输入时，输出按键的通码
//ps2_data：PS2数据输入
//ps2_clk：PS2时钟输入
//ps2_data：得到按键的通码
//ps2_done：按键操作完成指示信号
// =======================================================//
module IP_PS2_keyboard(clk,rst,ps2_clk,ps2_dat,ps2_code,ps2_done);
	input clk,rst,ps2_clk,ps2_dat;//时钟线和地址线
	output reg[7:0] ps2_code; 
	output reg ps2_done;//按键操作完成指示信号，应该是应答信号
	//---------------------------------------------------	
	//为PS2时钟滤波	
	reg[7:0] PS2C_r; 
	wire PS2Cf;//ps2使用时钟
	assign PS2Cf=(!rst)? 1'b1 : &PS2C_r; //PS2Cf=PS2C_r[0]&PS2C_r[1]......
	always @(posedge clk) 
		PS2C_r <= {ps2_clk,PS2C_r[7:1]};//PS2C_r右移的操作，当clk为下降沿，传递给ps2也为下降沿，时钟转换
	//---------------------------------------------------	
	//获取通码和断码：register_register[8:1]为按键的通码或断码中的8位
	reg[10:0] register;
	always @(negedge PS2Cf or negedge rst) begin
		if(!rst) register<=11'h7ff;//11111111111
		else register<={ps2_dat,register[10:1]};//右移，接受通码
	end
	//---------------------------------------------------	
	//PS2时钟下降沿计数,11次为一个字节数据的传输，键盘向主机发送信号
	reg[3:0] cnt;
	always @(negedge PS2Cf or negedge rst) begin //11次
		if(!rst) cnt<=0;
		else begin
			if(cnt==10) cnt<=0; 
			else cnt<=cnt+4'd1;
		end
	end
	//---------------------------------------------------
	//获取通码并标志解码完成
	//断码标志F0以及长码标志E0在解码步骤需要考虑。
	always @(posedge PS2Cf or negedge rst) begin
		if(!rst) begin 
			ps2_code<=8'h00;
			ps2_done<=0;
		end
		else begin
			if(cnt==10) begin //一个按键的通码传输完毕
				if((register[9:2]!=8'hff)&(register[9:2]!=8'he0)&(register[9:2]!=8'hf0)) begin//ff,e0,f0???
					ps2_code<=register[9:2];
					ps2_done<=1;
				end				
			end
			else begin
				ps2_done<=0;
			end
		end
	end
endmodule