
int endianess() {
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

float ensure_float_endianess(float f) {
	char *bytes = (char*)&f;
	if (endianess() == 0) {
		swap_char(bytes, bytes + 3);	
		swap_char(bytes + 1, bytes + 2);	
	}
	return (f);
}

int ensure_int_endianess(int i) {
	char *bytes = (char*)&i;
	if (endianess() == 0) {
		swap_char(bytes, bytes + 3);	
		swap_char(bytes + 1, bytes + 2);	
	}
	return (i);
}
