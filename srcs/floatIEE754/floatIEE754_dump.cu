# include "float754.h"

void float754_dump(t_float754 *f) {

	if (f == NULL) {
		printf("(null)\n");
	} else {

		char *addr = (char*)(f + 1);
		char *end = addr + f->sizebyte;
		char buffer[9];
		buffer[8] = 0;

		while (addr < end) {
			int i;
			for (i = 0 ; i < 8 ; i++) {
				buffer[i] = ((*addr) & (1 << (7 - i))) ? '1' : '0';
			}
			printf("%s ", buffer);
			++addr;
		}
		printf("\n");
	}
}