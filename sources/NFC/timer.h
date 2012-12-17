#ifndef __TIMER_H
#define __TIMER_H
#include <avr/interrupt.h>
#include "typedef.h"
void Init_Timer0(void);
void delay_ms(u16 dt);
#endif
