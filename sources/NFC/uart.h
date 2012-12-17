#ifndef __UART_H

#define __UART_H

#include <avr/io.h>

#define   Baud2400     416
#define   Baud4800     207
#define   Baud9600     103
#define   Baud14400     68
#define   Baud19200     51
#define   Baud28800     34
#define   Baud38400     25
#define   Baud57600     16
#define   Baud115200     8

unsigned char getByte0();
void putByte0(unsigned char data);


unsigned char getByte1();
void putByte1(unsigned char data);

int putch(char ch);
void putstr(char* str);


void putNFCByte(unsigned char data);
unsigned char getNFCByte();
void getNFCBytes(unsigned char *buf, const unsigned int len);
void putNFCBytes(unsigned char *buf, const unsigned int len);
void putDebugByte(unsigned char data);
unsigned char getDebugByte();
void getDebugBytes(unsigned char *buf, const unsigned int len);
void putDebugBytes(unsigned char *buf, const unsigned int len);



#endif
