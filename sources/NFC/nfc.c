#include "nfc.h"
#include "uart.h"
#include "timer.h"

unsigned char CommandStart[6]	= {0xAA,0x00,0x01,0x00,0x01,0xFF};
unsigned char CommandEnd[6]	= {0xAA,0x00,0x02,0x00,0x02,0xFF};
unsigned char Ultra_ID_Read[6]	= {0xAA,0x05,0x01,0x00,0x04,0xFF};
unsigned char Ultra_Read[8]	= {0xAA,0x05,0x02,0x02,0x30,0x07,0x32,0xFF};


unsigned int memCat(unsigned char *dst, unsigned int dstPos, unsigned char *msg, unsigned int len)
{
	int index;
	for(index = 0 ; index < len ; index++)
	{
		*(dst + dstPos + index) = msg[index];
	}
	return dstPos + len;
}

void getPasswd(unsigned char *dst, unsigned char *msg)
{
	int index;
	for(index = 0 ; index < 4 ; index++)
	{
		dst[index] = msg[index + 7];
	}
}


void parseMsg()
{
	unsigned char header[4];
	int index;

	char buffer[256];
	int length;

	PORTA = 0xFF;
	PORTG = 0x00;
	getNFCBytes(header,4);
//	putDebugBytes(header,4);
	switch(header[1])//Protocol
	{
		case 0x00:
			break;
		default:	
			length = header[3];
			getNFCBytes(buffer,length + 2);
	//		putDebugBytes(buffer,length + 2);
			readTag();
			break;
	}
}


void readTag()
{
	int currentLength = 0;
	char buf[128];	
	char debugBuf[128];
	char passwd[4];
	int index;

	PORTG = 0xFF;
	currentLength = memCat(buf,0,CommandStart,6);
	currentLength = memCat(buf,currentLength,Ultra_ID_Read,6);
	putNFCBytes(buf,currentLength);
	getNFCBytes(debugBuf,20);
	putDebugBytes(debugBuf,20);



	currentLength = memCat(buf,0,Ultra_Read,8);	
	putNFCBytes(buf,currentLength);
	getNFCBytes(debugBuf,23);
	putDebugBytes(debugBuf,23);
	
	
	getPasswd(passwd, debugBuf);




	putDebugBytes(passwd,4);

	delay_ms(2000);

	for(index = 0 ; index < 2 ; index++)
	{
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = '*';
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = passwd[0] & 0xFF;//0x30;
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = passwd[1] & 0xFF;//0x31;
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = passwd[2] & 0xFF;//00x32;
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = passwd[3] & 0xFF;//00x33;
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = '*';
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
	}

	currentLength = memCat(buf,0,CommandEnd,6);
	putNFCBytes(buf,currentLength);
	getNFCBytes(debugBuf,7);
	putDebugBytes(debugBuf,7);

	PORTG = 0x00;

}
