#include "binary_tools.h"

void bindump(void *data, int len) {

	if (data == NULL) {
		printf("(null)\n");
	} else if (len > 0) {

		char *addr = (char*)data;
		char *end = addr + len;
		char buffer[9];
		buffer[8] = 0;

		while (true) {

			buffer[0] = ((*addr) & (1 << 7)) ? '1' : '0';
			buffer[1] = ((*addr) & (1 << 6)) ? '1' : '0';
			buffer[2] = ((*addr) & (1 << 5)) ? '1' : '0';
			buffer[3] = ((*addr) & (1 << 4)) ? '1' : '0';
			buffer[4] = ((*addr) & (1 << 3)) ? '1' : '0';
			buffer[5] = ((*addr) & (1 << 2)) ? '1' : '0';
			buffer[6] = ((*addr) & (1 << 1)) ? '1' : '0';
			buffer[7] = ((*addr) & (1 << 0)) ? '1' : '0';

			printf(buffer);
			++addr;
			if (addr < end) {
				printf(" ");
			} else {
				break ;
			}
		}
	}
}
