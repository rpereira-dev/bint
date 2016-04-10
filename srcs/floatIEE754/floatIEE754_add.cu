# include "float754.h"

t_float754 *float754_add(t_float754 *dst, t_float754 *a, t_float754 *b) {

	//assume that a and b are positive

	//always have a > b
	if (float754_cmp(a, b) < 0) {
		t_float754 *tmp = a;
		a = b;
		b = tmp;
	}

	//so here we always have b < a
	

	(void)dst;
	(void)a;
	(void)b;
	return (dst);
}
