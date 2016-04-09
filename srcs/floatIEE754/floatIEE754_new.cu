# include "float754.h"

# define BIT_TO_BYTE(X) (X / 8 + ((X % 8 == 0) ? 0 : 1))

t_float754 *float754_new(unsigned int exposant_size, unsigned int mantissa_size) {
	if (exposant_size == 0 || mantissa_size == 0) {
		return (NULL);
	}
	unsigned int sizebit = exposant_size + mantissa_size + 1;
	unsigned int sizebyte = BIT_TO_BYTE(sizebit);
	t_float754 *f = (t_float754*)malloc(sizeof(t_float754) + sizebyte);
	if (f == NULL) {
		return (NULL);
	}
	f->exposantbit = exposant_size;
	f->exposantbyte = BIT_TO_BYTE(exposant_size);
	f->mantissabit = mantissa_size;
	f->mantissabyte = BIT_TO_BYTE(mantissa_size);
	f->sizebit = sizebit;
	f->sizebyte = sizebyte;
	return (f);
}

t_float754 *float754_new32(float f) {
	t_float754 *F = float754_new(8, 23);
	if (F == NULL) {
		return (NULL);
	}
	return (float754_set32(F, f));
}

