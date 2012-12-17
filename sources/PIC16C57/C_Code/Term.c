#device PIC16C57

#define PORTA_DATA *(unsigned char*)0x05
#define PORTB_DATA *(unsigned char*)0x06
#define PORTC_DATA *(unsigned char*)0x07

int main()
{
   unsigned char portA, portC , portB = 0xFF;
   unsigned char oldKeyValue = 0xFF;
   
   unsigned char curPassWD[4] = {0x00, 0x01, 0x02, 0x03};
   unsigned char savPassWD[4] = {0x00, 0x00, 0x00, 0x00}; 
   unsigned char keypadPassWd[4] = {0x00, 0x00, 0x00, 0x00}; 
   unsigned char oldAVR = 0xFF;
   int currentIndex = 0;
   int currentKeyIndex = 0;
   
   #asm
      MOVLW 0xFF
      TRIS  5  //PORTA  :Input   // keyPAD
      TRIS  6  //PORTB  :Input   // AVR
      MOVLW 0x00
      TRIS  7  //PORC   :Output  // 
   #endasm
   portB = 0xFF;
   do
   {
      portA = PORTA_DATA;
      portB = PORTB_DATA;     
      portC = (portA & 0xFF);
      
      if(oldKeyValue != portC)
      {
         oldKeyValue = portC;

         
         switch(portC)
         {
            case 0x0F:
               break;
            case 0x0A:
               curPassWD[0] = keypadPassWd[0];
               curPassWD[1] = keypadPassWd[1];
               curPassWD[2] = keypadPassWd[2];
               curPassWD[3] = keypadPassWd[3];
               currentKeyIndex = 0; continue;
               break;
            default:
               keypadPassWd[currentKeyIndex] = portC;
               PORTC_DATA = keypadPassWd[currentKeyIndex];
               currentKeyIndex = (currentKeyIndex + 1) % 4;
               break;
         }
      }

      if(portB != oldAVR)
      {
         oldAVR = portB;
         switch(portB)
         {
            case 0xFF:
               break;
            case '*':
               if(curPassWD[0] == savPassWD[0] &&
                  curPassWD[1] == savPassWD[1] &&
                  curPassWD[2] == savPassWD[2] &&
                  curPassWD[3] == savPassWD[3]) {
                     PORTC_DATA = 0xFF;
                  }
               else
                 PORTC_DATA = 0x00;
               currentIndex = 0; continue;
               break;
            default:
               portB = portB - '0';
               savPassWD[currentIndex] = portB;
               currentIndex = (currentIndex + 1) % 4;
               break;
         }
      }
   
   }while(1);
   
   return 0;
}
