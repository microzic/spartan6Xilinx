`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name:    uart_test 
// 
//////////////////////////////////////////////////////////////////////////////////
module uart_test(clk50, rx, tx, reset);
input clk50;
input reset;
input rx;
output tx;

wire clk;       //clock for 9600 uart port
wire [7:0] txdata,rxdata;     //���ڷ������ݺʹ��ڽ�������



//����ʱ�ӵ�Ƶ��Ϊ16*9600
clkdiv u0 (
		.clk50                   (clk50),               //50Mhz�ľ�������                     
		.clkout                  (clk)                  //16�������ʵ�ʱ��                        
 );

//���ڽ��ճ���
uartrx u1 (
		.clk                     (clk),                 //16�������ʵ�ʱ�� 
      .rx	                   (rx),  	               //���ڽ���
		.dataout                 (rxdata),              //uart ���յ�������,һ���ֽ�                     
      .rdsig                   (rdsig),               //uart ���յ�������Ч 
		.dataerror               (),
		.frameerror              ()
);

//���ڷ��ͳ���
uarttx u2 (
		.clk                     (clk),                  //16�������ʵ�ʱ��  
	   .tx                      (tx),			          //���ڷ���
		.datain                  (txdata),               //uart ���͵�����   
      .wrsig                   (wrsig),                //uart ���͵�������Ч  
      .idle                    () 	
	
 );

//�������ݷ��Ϳ��Ƴ���
uartctrl u3 (
		.clk                     (clk),                           
		.rdsig                   (rdsig),                //uart ���յ�������Ч   
      .rxdata                  (rxdata), 		          //uart ���յ������� 
      .wrsig                   (wrsig),                //uart ���͵�������Ч  
      .dataout                 (txdata)	             //uart ���͵����ݣ�һ���ֽ� 
	
 );
 

endmodule

