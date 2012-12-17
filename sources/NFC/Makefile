PROGRAM_NAME = nfcReader

all:
	avr-gcc -mmcu=atmega128 -o $(PROGRAM_NAME).o $(PROGRAM_NAME).c uart.c nfc.c timer.c -g -O0
	avr-objcopy -O ihex -R .eeprom $(PROGRAM_NAME).o $(PROGRAM_NAME).hex
	avr-objdump -S $(PROGRAM_NAME).o > list.lst


write:
	sudo avrdude -p m128 -c stk500 -P /dev/ttyUSB0 -U flash:w:$(PROGRAM_NAME).hex:i


clean:
	rm -rf *.hex
	rm -rf *.o
	rm -rf *.lst
