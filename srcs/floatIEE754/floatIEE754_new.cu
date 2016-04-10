# include "float754.h"

t_float754 *float754_new(unsigned int exposantbyte, unsigned int mantissabyte) {

	if (exposantbyte == 0 || mantissabyte < 4) {
		return (NULL);
	}

	//now we have a correct size for the mantissa and the exposant
	unsigned int sizebyte = exposantbyte + mantissabyte;
	t_float754 *f = (t_float754*)malloc(sizeof(t_float754) + sizebyte);
	if (f == NULL) {
		return (NULL);
	}
	f->exposantbyte = exposantbyte;
	f->mantissabyte = mantissabyte;
	f->sizebyte = sizebyte;

	//set the number to zero
	f->sign = 0;
	memset(f + 1, 0, sizebyte);
	
	return (f);
}

t_float754 *float754_new32(float f) {
	t_float754 *F = float754_new(1, 4);
	if (F == NULL) {
		return (NULL);
	}
	return (float754_set32(F, f));
}

