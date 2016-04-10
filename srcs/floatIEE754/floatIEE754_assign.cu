# include "float754.h"

t_float754 *float754_assign(t_float754 *dst, t_float754 *a) {

	//if dst is NULL, clone a
	if (dst == NULL) {
		return (float754_clone(a));
	}

	//if we want to assign 0
	if (a == NULL) {
		dst->sign = 0;
		memset(dst + 1, 0, dst->sizebyte);
		return (dst);
	}

	//wrong sizes
	if (dst->exposantbyte != a->exposantbyte || dst->mantissabyte != a->exposantbyte) {
		return (NULL);
	}

	memcpy(dst + 1, a + 1, a->sizebyte);
	return (dst);
}