# include "float754.h"

int float754_sign(t_float754 *f) {
	
	if (f == NULL) {
		return (0);
	}

	int sign = *((char*)(f + 1)) & (1 << 7);
	return (sign == 0 ? 1 : -1);
}
