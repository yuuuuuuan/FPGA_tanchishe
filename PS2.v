// =======================================================//
//���а�������ʱ�����������ͨ��
//ps2_data��PS2��������
//ps2_clk��PS2ʱ������
//ps2_data���õ�������ͨ��
//ps2_done�������������ָʾ�ź�
// =======================================================//
module IP_PS2_keyboard(clk,rst,ps2_clk,ps2_dat,ps2_code,ps2_done);
	input clk,rst,ps2_clk,ps2_dat;//ʱ���ߺ͵�ַ��
	output reg[7:0] ps2_code; 
	output reg ps2_done;//�����������ָʾ�źţ�Ӧ����Ӧ���ź�
	//---------------------------------------------------	
	//ΪPS2ʱ���˲�	
	reg[7:0] PS2C_r; 
	wire PS2Cf;//ps2ʹ��ʱ��
	assign PS2Cf=(!rst)? 1'b1 : &PS2C_r; //PS2Cf=PS2C_r[0]&PS2C_r[1]......
	always @(posedge clk) 
		PS2C_r <= {ps2_clk,PS2C_r[7:1]};//PS2C_r���ƵĲ�������clkΪ�½��أ����ݸ�ps2ҲΪ�½��أ�ʱ��ת��
	//---------------------------------------------------	
	//��ȡͨ��Ͷ��룺register_register[8:1]Ϊ������ͨ�������е�8λ
	reg[10:0] register;
	always @(negedge PS2Cf or negedge rst) begin
		if(!rst) register<=11'h7ff;//11111111111
		else register<={ps2_dat,register[10:1]};//���ƣ�����ͨ��
	end
	//---------------------------------------------------	
	//PS2ʱ���½��ؼ���,11��Ϊһ���ֽ����ݵĴ��䣬���������������ź�
	reg[3:0] cnt;
	always @(negedge PS2Cf or negedge rst) begin //11��
		if(!rst) cnt<=0;
		else begin
			if(cnt==10) cnt<=0; 
			else cnt<=cnt+4'd1;
		end
	end
	//---------------------------------------------------
	//��ȡͨ�벢��־�������
	//�����־F0�Լ������־E0�ڽ��벽����Ҫ���ǡ�
	always @(posedge PS2Cf or negedge rst) begin
		if(!rst) begin 
			ps2_code<=8'h00;
			ps2_done<=0;
		end
		else begin
			if(cnt==10) begin //һ��������ͨ�봫�����
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