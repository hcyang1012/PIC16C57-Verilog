#device PIC16C57

#define PORTA_DATA *(unsigned char*)0x05  // KEYPAD
#define PORTB_DATA *(unsigned char*)0x06  // 
#define PORTC_DATA *(unsigned char*)0x07  // LED

int main()
{
   unsigned char portA, portB, portC = 0x0F;
   unsigned char oldKeyValue = 0x0F;
   unsigned char savPassWD[4] = {0x01, 0x01, 0x01, 0x01};
   unsigned char curPassWD[4] = {0x0F, 0x0F, 0x0F, 0x0F};
   int i = 0;
   int j = 0;
   #asm
      MOVLW 0xFF
      TRIS  5  //PORTA  :Input
      TRIS  6  //PORTB  :Input
      MOVLW 0x00
      
      TRIS  7  //PORC   :Output
   #endasm
   portB = 0xFF;
   PORTB_DATA = portB;
   while(1)
   {
      portA = PORTA_DATA;
      //portC = (portA & 0xFF);
      //portB = PORTB_DATA;
      
      if(oldKeyValue != (portA & 0xFF))
      {
         oldKeyValue = (portA & 0xFF);
         if((portA & 0xFF) != 0x0F)
         { 
            switch((portA & 0xFF))
            {
              case 0x00:
                  curPassWD[i] = 0x00;
                  break;
              case 0x01:
                  curPassWD[i] = 0x01;
                  break;
              case 0x02:
                  curPassWD[i] = 0x02;
                  break;
              case 0x03:
                  curPassWD[i] = 0x03;
                  break;
              case 0x04:
                  curPassWD[i] = 0x04;
                  break;
              case 0x05:
                  curPassWD[i] = 0x05;
                  break;
              case 0x06:
                  curPassWD[i] = 0x06;
                  break;
              case 0x07:
                  curPassWD[i] = 0x07;
                  break;
              case 0x08:
                  curPassWD[i] = 0x08;
                  break;
              case 0x09:
                  curPassWD[i] = 0x09;
                  break;
              default:
            }
            i = i + 1;
         }
      }
      
      if( i == 4)
      {
         j = 0;
         while( (curPassWD[j] == savPassWD[j]) && j < 4 )
         {
            j = j+1;
         }
         if( j == 4)
         {
            PORTB_DATA = portB;
         }
         else
         {
            PORTC_DATA = curPassWD[j];
         }
         i = 0;
      }
   }
   
   return 0;
}
