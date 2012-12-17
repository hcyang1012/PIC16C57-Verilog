#include "typedef.h"
#include "timer.h"

extern volatile u16 Count; 
extern BOOL Wait; 
extern BOOL newValue;

void Init_Timer0(void) 
{ 
	TCCR0 = 0x05;       //프리스케일러 128 
	TCNT0 = 0x83; 
} 

void delay_ms(u16 dt) 
{ 
	Wait=TRUE; 
	Count=dt; 
	while(Count); 
	Wait=FALSE; 
} 

ISR(TIMER0_OVF_vect) //인터럽트 서비스 루틴. TIMER0가 오버플로되면 호출 
{ 
	TCNT0 = 0x83;    // 초기화 
	if(Wait)Count--; 
}
