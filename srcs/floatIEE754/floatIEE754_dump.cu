# include "float754.h"

void float754_dump(t_float754 *f) {

	char *addr = (char*)(f + 1);
	printf("exposant:{");
	bindump(addr, f->exposantbyte);
	printf("} , mantissa:{");
	bindump(addr + f->exposantbyte, f->mantissabyte);
	printf("}\n");
}