`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module name    uartrx.v
// ˵����          16��clock����һ��bit��16��ʱ�Ӳ�����ȡ�м�Ĳ���ֵ
//////////////////////////////////////////////////////////////////////////////////
module uartrx(clk, rx, dataout, rdsig, dataerror, frameerror);
input clk;             //����ʱ��
input rx;              //UART��������
output dataout;        //�����������
output rdsig;          //����������Ч����˵�����յ�һ���ֽ�
output dataerror;      //���ݳ���ָʾ
output frameerror;     //֡����ָʾ

reg[7:0] dataout;
reg rdsig, dataerror;
reg frameerror;
reg [7:0] cnt;
reg rxbuf, rxfall, receive;
parameter paritymode = 1'b0;
reg presult, idle;

always @(posedge clk)   //�����·rx���½���, ��·���е�ʱ��rxΪ�ߵ�ƽ
begin
  rxbuf <= rx;
  rxfall <= rxbuf & (~rx);
end

always @(posedge clk)
begin
  if (rxfall && (~idle))  //��⵽��·���½��ز���ԭ����·Ϊ���У������������ݽ���
  begin
    receive <= 1'b1;      //��ʼ��������
  end
  else if(cnt == 8'd168)  //�����������
  begin
   receive <= 1'b0;
  end
end

/////////////////////////////////////////////////////////////////////////
//ʹ��176��ʱ�ӽ���һ�����ݣ���ʼλ��8λ���ݡ���żУ��λ��ֹͣλ����ÿλռ��16��ʱ��//
////////////////////////////////////////////////////////////////////////
always @(posedge clk)
begin
  if(receive == 1'b1)
  begin
   case (cnt)
   8'd0:                   //0~15��ʱ��Ϊ���յ�һ�����أ���ʼλ
     begin
      idle <= 1'b1;
      cnt <= cnt + 8'd1;
      rdsig <= 1'b0;
     end
   8'd24:                  //16~31��ʱ��Ϊ��1��bit���ݣ�ȡ�м��24��ʱ�ӵĲ���ֵ
	begin
      idle <= 1'b1;
      dataout[0] <= rx;
      presult <= paritymode^rx;
      cnt <= cnt + 8'd1;
      rdsig <= 1'b0;
     end
   8'd40:                 //47~32��ʱ��Ϊ��2��bit���ݣ�ȡ�м��40��ʱ�ӵĲ���ֵ 
	begin
      idle <= 1'b1;
      dataout[1] <= rx;
      presult <= presult^rx;
      cnt <= cnt + 8'd1;
      rdsig <= 1'b0;
     end
   8'd56:                 //63~48��ʱ��Ϊ��3��bit���ݣ�ȡ�м��56��ʱ�ӵĲ���ֵ   
	begin
      idle <= 1'b1;
      dataout[2] <= rx;
      presult <= presult^rx;
      cnt <= cnt + 8'd1;
      rdsig <= 1'b0;
     end
   8'd72:                //79~64��ʱ��Ϊ��4��bit���ݣ�ȡ�м��72��ʱ�ӵĲ���ֵ   
	begin
      idle <= 1'b1;
      dataout[3] <= rx;
      presult <= presult^rx;
      cnt <= cnt + 8'd1;
      rdsig <= 1'b0;
     end
   8'd88:               //95~80��ʱ��Ϊ��5��bit���ݣ�ȡ�м��88��ʱ�ӵĲ���ֵ    
	begin
      idle <= 1'b1;
      dataout[4] <= rx;
      presult <= presult^rx;
      cnt <= cnt + 8'd1;
      rdsig <= 1'b0;
     end
   8'd104:             //111~96��ʱ��Ϊ��6��bit���ݣ�ȡ�м��104��ʱ�ӵĲ���ֵ    
	begin
      idle <= 1'b1;
      dataout[5] <= rx;
      presult <= presult^rx;
      cnt <= cnt + 8'd1;
      rdsig <= 1'b0;
     end
   8'd120:             //127~112��ʱ��Ϊ��7��bit���ݣ�ȡ�м��120��ʱ�ӵĲ���ֵ     
	begin
      idle <= 1'b1;
      dataout[6] <= rx;
      presult <= presult^rx;
      cnt <= cnt + 8'd1;
      rdsig <= 1'b0;
     end
   8'd136:            //143~128��ʱ��Ϊ��8��bit���ݣ�ȡ�м��136��ʱ�ӵĲ���ֵ   
	begin
      idle <= 1'b1;
      dataout[7] <= rx;
      presult <= presult^rx;
      cnt <= cnt + 8'd1;
      rdsig <= 1'b1;      //����������Ч
     end
   8'd152:            //159~144��ʱ��Ϊ������żУ��λ��ȡ�м��152��ʱ�ӵĲ���ֵ     
	begin
      idle <= 1'b1;
      if(presult == rx)
        dataerror <= 1'b0;
      else
        dataerror <= 1'b1;       //�����żУ��λ���ԣ���ʾ���ݳ���
      cnt <= cnt + 8'd1;
      rdsig <= 1'b1;             
      end
   8'd168:            //160~175��ʱ��Ϊ����ֹͣλ��ȡ�м��168��ʱ�ӵĲ���ֵ  
     begin
     idle <= 1'b1;
     if(1'b1 == rx)
       frameerror <= 1'b0;
     else
       frameerror <= 1'b1;      //���û�н��յ�ֹͣλ����ʾ֡����
     cnt <= cnt + 8'd1;
     rdsig <= 1'b1;
     end
   default:
     begin
      cnt <= cnt + 8'd1;
     end
   endcase
  end
  else
  begin
    cnt <= 8'd0;
    idle <= 1'b0;
    rdsig <= 1'b0;
  end
 end
endmodule
