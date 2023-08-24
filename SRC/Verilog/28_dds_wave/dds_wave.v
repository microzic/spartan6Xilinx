`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    dds_wave 
//////////////////////////////////////////////////////////////////////////////////
module dds_wave
    (
  input clk,
  input key1,
  output [7 : 0] dadata,
  output da_clk

    );

reg [15:0] key1_counter;                 //�������Ĵ���
reg [7:0] dadata_o;
reg dds_we;
reg [28:0] dds_data;
reg [3:0] dds_freq=0;
reg dds_we_req;

wire  [7 : 0] sine;

assign sine_reg=sine[6:0];
assign da_clk=clk;
assign dadata=dadata_o;


//�з�����ת��Ϊ�޷����������DA
always @(posedge clk)
begin
      if(sine[7]==1'b1)
         dadata_o<=sine-128;       
 		else
         dadata_o<=sine+128;		
end 

//����DDS�����ͬ��Ƶ��
always @(negedge clk)
begin
    dds_we<=dds_we_req;
    case(dds_freq)
         4'b0000:begin
            dds_data <= 29'd107;                       //10Hz: (dds_data*2^29)/(50*1000000)
			end
			4'b0001:begin
            dds_data <= 29'd1074;                      //100Hz: (dds_data*2^29)/(50*1000000)
			end
			4'b0010:begin
            dds_data <= 29'd10737;                     //1KHz: (dds_data*2^29)/(50*1000000)
         end			  
	      4'b0011:begin
            dds_data <= 29'd53687;                     //5KHz: (dds_data*2^29)/(50*1000000)
         end					  
         4'b0100:begin     
            dds_data <= 29'd107374;                     //10KHz: (dds_data*2^29)/(50*1000000)
			end
         4'b0101:begin     
            dds_data <= 29'd536871;                     //50KHz: (dds_data*2^29)/(50*1000000)
         end					  
         4'b0110:begin     
            dds_data <= 29'd1073742;                    //100KHz: (dds_data*2^29)/(50*1000000)
			end
		   4'b0111:begin     
            dds_data <= 29'd5368709;                    //500KMHz: (dds_data*2^29)/(50*1000000)
			end
		   4'b1000:begin     
            dds_data <= 29'd10737418;                   //1MHz: (dds_data*2^29)/(50*1000000)
			end
		   4'b1001:begin     
            dds_data <= 29'd21474836;                   //2MHz: (dds_data*2^29)/(50*1000000)
			end
		   4'b1010:begin     
            dds_data <= 29'd32212255;                   //3MHz: (dds_data*2^29)/(50*1000000)
			end
		   4'b1011:begin     
            dds_data <= 29'd42949672;                   //4MHz: (dds_data*2^29)/(50*1000000)		
			end
		   4'b1100:begin     
            dds_data <= 29'd53687091;                   //5MHz: (dds_data*2^29)/(50*1000000)			
			end
			4'b1101:begin     
            dds_data <= 29'd64424509;                   //6MHz: (dds_data*2^29)/(50*1000000)			
			end
			4'b1110:begin     
            dds_data <= 29'd75161928;                   //7MHz: (dds_data*2^29)/(50*1000000)			
			end
			4'b1111:begin     
            dds_data <= 29'd85899346;                   //8MHz: (dds_data*2^29)/(50*1000000)			
			end
		   default:begin
            dds_data <= 29'd10737;                      //1KHz: (dds_data*2^29)/(50*1000000)
			end					  
         endcase
end 

//��ť�������, �ı�DDS�����Ƶ��	
always @(posedge clk)
begin
	   if (key1==1'b0)                                  //�����ťû�а��£��Ĵ���Ϊ0
	       key1_counter<=0;
	   else if ((key1==1'b1)& (key1_counter<=16'hc350)) //�����ť���²�����ʱ������1ms,����      
          key1_counter<=key1_counter+1'b1;
  	  
      if (key1_counter==16'hc349) begin                //һ�ΰ�ť��Ч���ı�DDSƵ��
          dds_freq<=dds_freq+1'b1;
			 dds_we_req<=1'b1;
		end	  
      else begin
          dds_freq<=dds_freq; 
			 dds_we_req<=1'b0;	
      end			 
end	

//DDS IP����sin/cos����
sin_cos sin_cos_inst (
  .clk(clk),            // input clk
  .we(dds_we),          // input we
  .data(dds_data),      // input [28 : 0] data
  .cosine(cosine),      // output [7 : 0] cosine
  .sine(sine),          // output [7 : 0] sine
  .phase_out() // output [28 : 0] phase_out
);


endmodule
