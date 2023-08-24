`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    lcd_disp 
//////////////////////////////////////////////////////////////////////////////////
module lcd_disp(
	 input lcd_clk,                //LCD��ʱ������
	 input lcd_rst,                 
	 input key1,                    //����1����LCD��ʾģʽ
	 input [127:0] ddr_data,        //DDR�е�ͼ������
 
    input lcd_en,                  //lcd��ʾʹ��
	 output lcd_dclk,
	 output [7:0] lcd_r,
    output [7:0] lcd_g,
    output [7:0] lcd_b,
    output lcd_hsync,
    output lcd_vsync,
    output lcd_de,	 

	 output reg ddr_addr_set,         //ddr����ַ��λ�ź�
	 output reg ddr_rden              //ddr����������
	     );

  reg[10 : 0] x_cnt;
  reg[9 : 0]  y_cnt;
  reg[3 : 0] lcd_dis_mode;
  reg[7 : 0]  lcd_r_reg;
  reg[7 : 0]  lcd_g_reg;
  reg[7 : 0]  lcd_b_reg;  
  reg hsync_r;
  reg vsync_r; 
  reg hsync_de;
  reg vsync_de;
  
  reg [127:0] ddr_data_reg;    //ddr���������ݴ洢
  reg [2:0] num_counter;    
  reg vsync_r_buf1;
  reg vsync_r_buf2;      

//LCD����źŸ�ֵ
  assign lcd_dclk = lcd_clk;
  assign lcd_hsync = hsync_r;
  assign lcd_vsync = vsync_r;
  assign lcd_de = hsync_de & vsync_de;
  assign lcd_r = (hsync_de & vsync_de)?lcd_r_reg:8'b00000000;
  assign lcd_g = (hsync_de & vsync_de)?lcd_g_reg:8'b00000000;
  assign lcd_b = (hsync_de & vsync_de)?lcd_b_reg:8'b00000000;
  
//-----------------------------------------------------------//
// ˮƽɨ��������趨480*272 60Hz LCD
//-----------------------------------------------------------//
parameter LinePeriod =525;           //��������
parameter H_SyncPulse=41;            //��ͬ�����壨Sync a��
parameter H_BackPorch=2;             //��ʾ���أ�Back porch b��
parameter H_ActivePix=480;           //��ʾʱ��Σ�Display interval c��
parameter H_FrontPorch=2;            //��ʾǰ�أ�Front porch d��
parameter Hde_start=43;
parameter Hde_end=523;
  
//-----------------------------------------------------------//
// ��ֱɨ��������趨480*272 60Hz LCD
//-----------------------------------------------------------//
parameter FramePeriod =286;           //��������
parameter V_SyncPulse=10;             //��ͬ�����壨Sync o��
parameter V_BackPorch=2;              //��ʾ���أ�Back porch p��
parameter V_ActivePix=272;            //��ʾʱ��Σ�Display interval q��
parameter V_FrontPorch=2;             //��ʾǰ�أ�Front porch r��
parameter Vde_start=12;
parameter Vde_end=284;

//----------------------------------------------------------------
////////// ˮƽɨ�����
//----------------------------------------------------------------
always @ (posedge lcd_clk)
       if(1'b0)    x_cnt <= 1;
       else if(x_cnt == LinePeriod) x_cnt <= 1;
       else x_cnt <= x_cnt+ 1;
		 
//----------------------------------------------------------------
////////// ˮƽɨ���ź�hsync,hsync_de����
//----------------------------------------------------------------
always @ (posedge lcd_clk)
   begin
       if(1'b0) hsync_r <= 1'b1;
       else if(x_cnt == 1) hsync_r <= 1'b0;            //����hsync�ź�
       else if(x_cnt == H_SyncPulse) hsync_r <= 1'b1;
		 
		 		 
	    if(1'b0) hsync_de <= 1'b0;
       else if(x_cnt == Hde_start) hsync_de <= 1'b1;    //����hsync_de�ź�
       else if(x_cnt == Hde_end) hsync_de <= 1'b0;	
	end

//----------------------------------------------------------------
////////// ��ֱɨ�����
//----------------------------------------------------------------
always @ (posedge lcd_clk)
       if(1'b0) y_cnt <= 1;
       else if(y_cnt == FramePeriod) y_cnt <= 1;
       else if(x_cnt == LinePeriod) y_cnt <= y_cnt+1;

//----------------------------------------------------------------
////////// ��ֱɨ���ź�vsync, vsync_de����
//----------------------------------------------------------------
always @ (posedge lcd_clk)
  begin
       if(1'b0) vsync_r <= 1'b1;
       else if(y_cnt == 1) vsync_r <= 1'b0;    //����vsync�ź�
       else if(y_cnt == V_SyncPulse) vsync_r <= 1'b1;
		 
	    if(1'b0) vsync_de <= 1'b0;
       else if(y_cnt == Vde_start) vsync_de <= 1'b1;    //����vsync_de�ź�
       else if(y_cnt == Vde_end) vsync_de <= 1'b0;	 
  end
		 
  
//ddr��ַ��λ�������	
always @(posedge lcd_clk)
begin
   if (lcd_rst) begin
	    vsync_r_buf1<=1'b0;
		 vsync_r_buf2<=1'b0;
	    ddr_addr_set<=1'b0;
     end
   else begin
		 vsync_r_buf1<=vsync_r;
		 vsync_r_buf2<=vsync_r_buf1;
       if (vsync_r_buf2&~vsync_r_buf1)      //���vsync���½���,ddr�ĵ�ַ��λ
		   ddr_addr_set<=1'b1;
		 else
		   ddr_addr_set<=1'b0;		   
	   end
end
		
 //ddr�������źŲ�������	, 128bit��DDR����ת��5���������
 always @(negedge lcd_clk)
 begin
   if (lcd_rst) 
	  begin
		 ddr_data_reg<=128'd0;
		 lcd_r_reg<=8'd0;
		 lcd_g_reg<=8'd0;
		 lcd_b_reg<=8'd0;
		 num_counter<=3'b000;
		 ddr_rden<=1'b0;   
     end
   else
      begin
		 if (ddr_addr_set)               //������һ��������
				ddr_rden<=1'b1;                       	     
       else if (lcd_de)                //���LCD�����Ч��ͼ������
		   begin
			  case(num_counter)
			    3'b000:begin 
                  lcd_r_reg<=ddr_data_reg[31:24];         //��N��������1��6��12....)
                  lcd_g_reg<=ddr_data_reg[23:16];
                  lcd_b_reg<=ddr_data_reg[15:8];	
						num_counter<=3'b001;
						ddr_rden<=1'b1;                        //ddr����������
						end
			    3'b001:begin                                  //��N+1��������2��7��13....)
                  lcd_r_reg<=ddr_data_reg[55:48];
                  lcd_g_reg<=ddr_data_reg[47:40];
                  lcd_b_reg<=ddr_data_reg[39:32];
						num_counter<=3'b010;
						ddr_rden<=1'b0; 
                  end						
			    3'b010:begin                                 //��N+2��������3��8��14....)
                  lcd_r_reg<=ddr_data_reg[79:72];
                  lcd_g_reg<=ddr_data_reg[71:64];
                  lcd_b_reg<=ddr_data_reg[63:56];
						num_counter<=3'b011;	
						ddr_rden<=1'b0;
						end
			    3'b011:begin                                //��N+3��������4��9��15....)
                  lcd_r_reg<=ddr_data_reg[103:96];
                  lcd_g_reg<=ddr_data_reg[95:88];
                  lcd_b_reg<=ddr_data_reg[87:80];
						num_counter<=3'b100;	
						ddr_rden<=1'b0;	
                  end						
			    3'b100:begin                                //��N+4��������5��10��16....)
                  lcd_r_reg<=ddr_data_reg[127:120];
                  lcd_g_reg<=ddr_data_reg[119:112];
                  lcd_b_reg<=ddr_data_reg[111:104];
						ddr_data_reg<=ddr_data;                 //ddr���ݸı�
						num_counter<=3'b000;	
						ddr_rden<=1'b0;
                  end						
            default:begin
					  lcd_r_reg<=8'd0;                    
                 lcd_g_reg<=8'd0;
                 lcd_b_reg<=8'd0;
					  num_counter<=3'b000;	
					  ddr_rden<=1'b0;
					  end
				endcase;
			end
		else begin
			  lcd_r_reg<=8'd0;                    
           lcd_g_reg<=8'd0;
           lcd_b_reg<=8'd0;
		     ddr_rden<=1'b0;
			  num_counter<=3'b000;	
			  ddr_data_reg<=ddr_data;                 //ddr���ݸı�
		end
	end
end



			
endmodule
