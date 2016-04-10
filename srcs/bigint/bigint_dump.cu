#include "bigint.h"

void bigint_dump(t_bigint *i) {
	
	char *addr = (char*)(i + 1);
	printf("bigint:{");
	bindump(addr, i->bytes);
	printf("}\n");
}