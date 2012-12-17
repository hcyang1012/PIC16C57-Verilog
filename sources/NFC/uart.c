#include <avr/io.h>
#include "uart.h"

void UART0Disable()
{

}
void SerialInit( unsigned int bps, unsigned char rx, unsigned char tx, unsigned char Port )
{
    switch(Port)
    {
    case 0 :
      {
          UBRR0H = ( unsigned char ) ( bps >> 8 );
          UBRR0L = ( unsigned char ) bps;        
          UCSR0B = 0x18;                        
          if( rx == 1 ) UCSR0B |= ( 1<< 7 );   
          if( tx == 1 ) UCSR0B |= ( 1<< 6 );  
          UCSR0C = 0x06;                     
          break;
      }
    case 1:
      {
          UBRR1H = ( unsigned char ) ( bps >> 8 );
          UBRR1L = ( unsigned char ) bps;   
          UCSR1B = 0x18;                    
          if( rx == 1 ) UCSR1B |= ( 1<< 7 );
          if( tx == 1 ) UCSR1B |= ( 1<< 6 );
          UCSR1C = 0x06;                    
          break;
      }
    }
}



unsigned char getByte1()
{
	char buf;
	while(!(UCSR1A & 0x80));
	buf=UDR1 & 0xFF;
	UCSR1A |= 0x80;
	return buf;
}

void putByte1(unsigned char data)
{
	while(!(UCSR1A & 0x20));
	UDR1 = data & 0xFF;
	UCSR1A |= 0x20;
}

unsigned char getByte0()
{
	unsigned  char buf;
	while(!(UCSR0A & 0x80));
	buf=UDR0 & 0xFF;
	UCSR0A |= 0x80;
	return buf;
}

void putByte0(unsigned char data)
{
	while(!(UCSR0A & 0x20));
	UDR0 = data & 0xFF;
	UCSR0A |= 0x20;
}


void putNFCByte(unsigned char data)
{
	putByte0(data);
}

unsigned char getNFCByte()
{
	return getByte0();
}

void getNFCBytes(unsigned char *buf, const unsigned int len)
{
	int index;
	for(index = 0 ; index < len ; index++)
	{
		buf[index] = getNFCByte();;
	}
}

void putNFCBytes(unsigned char *buf, const unsigned int len)
{
	int index;
	for(index = 0 ; index < len ; index++)
	{
		putNFCByte(buf[index]);
	}
}

void putDebugByte(unsigned char data)
{
	putByte1(data);
}

unsigned char getDebugByte()
{
	return getByte1();
}



void getDebugBytes(unsigned char *buf, const unsigned int len)
{
	#ifdef __DEBUG__
	int index;
	for(index = 0 ; index < len ; index++)
	{
		buf[index] = getDebugByte();;
	}
	#endif
}

void putDebugBytes(unsigned char *buf, const unsigned int len)
{
	int index;
	for(index = 0 ; index < len ; index++)
	{
		putDebugByte(buf[index]);
	}
}


