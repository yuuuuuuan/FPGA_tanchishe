module Game_control(clk,rst,P_up,P_down,P_left,P_right,vga_xpos,vga_ypos,vga_red,vga_green,vga_blue,the_end);
	input clk;
	input rst;    //*************hjk****************
	input P_up,P_down,P_left,P_right;
	input [10:0]vga_xpos;
	input [9:0]vga_ypos;
	output vga_red;
	output vga_blue;
	output vga_green;
	output the_end;
	//Ƶ��
	integer i,j;
	reg move,temp;
	always @(posedge clk)
		if(i==32'd4999999)
			begin i <= 1'b0; move <= ~move; end
		else if(j==32'd4999999)
			begin j <= 1'b0; temp <= ~temp; end
		else
			begin i <= i + 1'b1; j <= j + 1'b1; end
	//״̬
	reg [3:0]state;
	parameter left=4'b0001,right=4'b0010,down=4'b0100,up=4'b1000;
	always @(posedge P_left or posedge P_right or posedge P_down or posedge P_up)
		if(P_left)
			state <= left;
		else if(P_right)
			state <= right;
		else if(P_down)
			state <= down;
		else if(P_up)
			state <= up;
	//̰���߶���
	parameter N=4;    //�ɸı����
	reg [11:0]m[2**N-1:0];//�������鶨�巽����������Ͻ�
	reg [11:0]n[2**N-1:0];
	reg the_end=0;
	
  //*************ײ��Ĵ���ģ��
	reg hit; 
	reg[N-1:0] hit_cnt;    //������ɴ�2^N��
	always @(negedge rst, posedge clk)
		if(!rst) begin 
			hit_cnt <= 1'b1;
			hit <= 1'b0;
		end
		else begin
			if(hit_cnt >= a) hit_cnt <= 1'b1;
			else begin
				hit_cnt <= hit_cnt + 1'b1;
				hit <= hit | ((m[0] == m[hit_cnt]) && (n[0] == n[hit_cnt]));
			end
		end
	
  //̰�����˶�
   integer long_cnt;
	always @(posedge temp) begin
		if(!rst)
		begin m[0]<=200; n[0]<=200;end
		else if(m[0] > 600)
			m[0] <= 40;
		else if(m[0] < 40)
			m[0] <= 600;
		else if( n[0] > 420)
			n[0] <= 60;
		else if( n[0] < 60)
			n[0] <= 420;
		else if(hit)    //**************hjk*************
			begin m[0]<=0; n[0]<=0;the_end=1;end
		else
			begin//���������߷���
				case(state)
					left : m[0] <= m[0] - 12'd10;
					right : m[0] <= m[0] + 12'd10;
					down : n[0] <= n[0] + 12'd10;
					up: n[0] <= n[0] - 12'd10;
					default : m[0] <= m[0]+12'd10 ; //********hjk: ȱʡ���ã�OK!***********
				endcase
				for(long_cnt=0; long_cnt<(2**N-1); long_cnt=long_cnt+1) begin   //���2**N-1��
					m[long_cnt+1] <= m[long_cnt];
					n[long_cnt+1] <= n[long_cnt];
				end			
			end
		end

	
	//Сƻ��	�������			
	integer o,p,o_temp,p_temp;	
	always @(negedge rst,posedge clk)
		if(!rst) begin   //****hjk:����ֵ:�м�λ��*******
				p <= 300;//lie
				o <= 300;//hang
		end
		else if(change)//�Ե�changeΪ1�����ݳԵ�֮ǰ��ʱ����ʵ��������ֵĹ���
			begin 
				p <= p_temp;
				o <= o_temp;
			end
		else if(o_temp > 400)
			o_temp <= 100;
		else if(o_temp <100)
			o_temp <= 400;
		else if(p_temp > 400)
			p_temp <= 80;
		else if(p_temp < 80)
			p_temp <= 400;
		else
			begin
				o_temp <= o_temp + 10;
				p_temp <= p_temp + 10;
			end
			
	//�ж��Ƿ�Ե�
	reg change;
	always @(negedge rst, posedge clk)
		if(!rst) change <= 1'b0;   
		else 
		if(o==m[0] && p==n[0])
			change <= 1'b1;
		else
			change <= 1'b0;
	
	//�Ե�������
	reg s_all;   
	integer a;
	always @(negedge rst, posedge change)
		if(!rst) a<=1'b0;    
		else if(a==2**N-1)    
			a <= 1'b0;
		else
			a <= a + 1'b1;
	
	//��ʾ����
   reg[N-1:0] dsp_cnt;    //������ɴ�2^N��
	always @(a) begin
		s_all = 0;
		for(dsp_cnt=0; dsp_cnt<2**N-1; dsp_cnt=dsp_cnt+1)
			if(dsp_cnt < a)
				s_all = s_all | s[dsp_cnt];//ȫ����һ�𣬵õ�s_all,a�ͺ����for���
	end

	//��ͷ
	wire h;
	assign h = ((vga_xpos > m[0] ) && (vga_xpos < m[0] + 10) && (vga_ypos > n[0] ) && (vga_ypos < n[0] + 10) );
	//����
	reg s[2**N-2:0];//����+��ͷ��2^N��	
	reg[N-1:0] s_cnt;
	always @(*) begin
		for(s_cnt=0; s_cnt<(2**N-1); s_cnt=s_cnt+1)   //���2**N��
			s[s_cnt] <= ((vga_xpos > m[s_cnt+1] ) && (vga_xpos < m[s_cnt+1] + 10) && (vga_ypos > n[s_cnt+1] ) && (vga_ypos < n[s_cnt+1] + 10) );
   end

	//��ͷ
	wire h_vaild = ((vga_xpos > 40 ) && (vga_xpos < 600 ) && (vga_ypos > 60	) && (vga_ypos < 420) ); 
	//vga�ź����
	assign vga_green = h_vaild ? h : 1'b0;
	assign vga_blue = s_all;
	assign vga_red = ((vga_xpos > o ) && (vga_xpos < o + 10) && (vga_ypos > p	) && (vga_ypos < p + 10) );
	
endmodule