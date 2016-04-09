#include "float754.h"

t_float754 *float754_clone(t_float754 *a) {
	if (a == NULL) {
		return (NULL);
	}

	int size = sizeof(t_float754) + a->sizebyte;
	t_float754 *b = (t_float754*)malloc(size);
	if (b == NULL) {
		return (NULL);
	}
	memcpy(b, a, size);
	return (b);
}