`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    key_dect 
//////////////////////////////////////////////////////////////////////////////////
module key_dect(
	input clk50M,
	input reset_n,
	input  key1,

 	output reg record_start,
	
//	output reg sdr_raddr_set,
	output reg sdr_waddr_set

    );

reg [15:0] down_counter;                 //�������¼Ĵ���
reg [15:0] up_counter;                 //�����ɿ��Ĵ���

reg voice_en;

//�������´������
always @(negedge clk50M)
begin
   if (reset_n==1'b0) begin
	    down_counter<=0;
		 sdr_waddr_set<=1'b1;
		 record_start<=1'b0; 

	end
	else begin
	    if (key1==1'b1) begin                             //�����ťû�а��£��Ĵ���Ϊ0
	       down_counter<=0;
		    record_start<=1'b0;
       end 			 
	    else begin                                       //�����ť����
          if(down_counter<=16'h0350) begin            
              sdr_waddr_set<=1'b1;                     //sdr��д��ַ��λ           
			     down_counter<=down_counter+1'b1;         //�����ť���²�����,����  
			     record_start<=1'b0;
		    end	
  	       else if (down_counter==16'h0351) begin                  
			    down_counter<=down_counter+1'b1;
		       record_start<=1'b1;                      //һ�ΰ�����Ч��ʼ¼��                   
             sdr_waddr_set<=1'b0;
			 end
			 else
			    record_start<=1'b0;
       end
   end 
end


endmodule
