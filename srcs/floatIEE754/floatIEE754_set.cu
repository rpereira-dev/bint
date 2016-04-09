# include "float754.h"

static int str_is_zero(unsigned char const *str) {

	//if the string is null
	if (str == NULL) {
		return (NULL);
	}

	//if the string only contains 0 char
	//TODO optimize this on this model: http://www.stdlib.net/~colmmacc/strlen.c.html
	const unsigned char *s;
	for (s = str; *s == '0'; ++s);
	return (*s == 0);
}

t_float754 *float754_set(t_float754 *f, unsigned char const *str) {

	//if the given float is NULL
	if (f == NULL) {
		//return NULL because we cannot know how to interpert the string
		return (NULL);
	}

	//if we want to set 0
	if (str_is_zero(str)) {
		//set it to zero
		memset(f + 1, 0, f->sizebyte);
		return (f);
	}

	//here we have a float with the right sizes
	const unsigned char *s = str;
	unsigned char *addr = (unsigned char*)(f + 1);
	int i = 0;

	memset(addr, 0, f->sizebyte);

	//for each byte
	while (i < f->sizebyte && *str) {
		addr[i] |= (*s++ == '1') ? (1 << 7) : 0;
		addr[i] |= (*s++ == '1') ? (1 << 6) : 0;
		addr[i] |= (*s++ == '1') ? (1 << 5) : 0;
		addr[i] |= (*s++ == '1') ? (1 << 4) : 0;
		addr[i] |= (*s++ == '1') ? (1 << 3) : 0;
		addr[i] |= (*s++ == '1') ? (1 << 2) : 0;
		addr[i] |= (*s++ == '1') ? (1 << 1) : 0;
		addr[i] |= (*s++ == '1') ? (1 << 0) : 0;

		if (*s == ' ') {
			++s;
		}

		//jump to next byte
		++i;
	}
	return (f);
}

static int endianess() {
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

t_float754 *float754_set32(t_float754 *F, float f) {

	char *bytes = (char*)&f;
	if (endianess() == 0) {
		swap_char(bytes, bytes + 3);	
		swap_char(bytes + 1, bytes + 2);	
	}

	memcpy(F + 1, &f, sizeof(float));
	return (F);
}