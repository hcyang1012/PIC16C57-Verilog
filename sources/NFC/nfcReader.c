#include <stdio.h>
#include "uart.h"
#include "nfc.h"
#include "timer.h"

volatile u16 Count = 0; 
BOOL Wait = FALSE; 
BOOL newValue = FALSE;


int main(void)
{
	cli();
	DDRA = 0xFF;
	DDRG = 0xFF;
	Init_Timer0();
	TIMSK=0x01;     //Timer0 overflow 인터럽트. 
	SerialInit(Baud19200,0,0,0);
	SerialInit(Baud19200,0,0,1);
	sei();
	PORTG = 0xFF;
	while(1)
	{
/*		PORTA = 0xFF;
		delay_ms(0);
		PORTA = '*';
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = 0x30;
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = 0x31;
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = 0x32;
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = 0x33;
		delay_ms(0);
		PORTA = 0xFF;
		delay_ms(0);
		PORTA = '*';
		delay_ms(0);
*/
		parseMsg();

		
	}
	return 0;
}

