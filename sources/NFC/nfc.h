#ifndef __NFC_H
#define __NFC_H

#define POLLING 0
#define COMMAND 1

unsigned int memCat(unsigned char *dst, unsigned int dstPos, unsigned char *msg, unsigned int len);
void getPasswd(unsigned char *dst, unsigned char *msg);
void readTag();
#endif
