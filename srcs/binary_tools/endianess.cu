
int endianness() {
	union {
		int i;
		char c[4];
	} bint = {0x01020304};
	return (bint.c[0] == 1); 
}

static void swap_char(char *a, char *b) {
	char c = *a;
	*a = *b;
	*b = c;
}

float btools_swap_float_endian(float f) {
	char *bytes = (char*)&f;
	swap_char(bytes, bytes + 3);	
	swap_char(bytes + 1, bytes + 2);	
	return (f);
}

int btools_swap_int_endian(int i) {
	char *bytes = (char*)&i;
	swap_char(bytes, bytes + 3);	
	swap_char(bytes + 1, bytes + 2);
	return (i);
}

unsigned int btools_swap_unsigned_int_endian(unsigned int i) {
	char *bytes = (char*)&i;
	swap_char(bytes, bytes + 3);	
	swap_char(bytes + 1, bytes + 2);
	return (i);
}
