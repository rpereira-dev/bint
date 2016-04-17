
int endianness() {
	union {
		int i;
		char c[4];
	} bint = {0x01020304};
	return (bint.c[0] == 1); 
}

void btools_swap_32(void *addr) {
	char *ptr = (char*)addr;
	
	char tmp = ptr[0];
	ptr[0] = ptr[3];
	ptr[3] = tmp;

	tmp = ptr[1];
	ptr[1] = ptr[2];
	ptr[2] = tmp;
}
