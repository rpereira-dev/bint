# include "float754.h"

t_float754 *float754_assign(t_float754 *dst, t_float754 *a) {

	//if dst is NULL, clone a
	if (dst == NULL) {
		return (float754_clone(a));
	}

	//if we want to assign 0
	if (a == NULL) {
		memset(dst + 1, 0, dst->sizebyte);
		return (dst);
	}

	//if sizes are different, return null
	if (memcmp(dst, a, sizeof(t_float754)) != 0) {
		return (NULL);
	}

	memcpy(dst + 1, a + 1, a->sizebyte);
	return (dst);
}