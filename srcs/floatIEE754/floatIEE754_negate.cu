# include "float754.h"

t_float754 *float754_negate(t_float754 *f) {

	if (f != NULL) {
		((char*)(f + 1))[0] ^= (1 << 7);
	}

	return (f);
}
