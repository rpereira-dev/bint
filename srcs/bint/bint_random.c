#include "bint.h"

t_bint * bint_random(size_t size) {
	return (bint_random_dst(NULL, size));
}

t_bint * bint_random_dst(t_bint ** dst, size_t size) {

	if (size == 0) {
		return (BINT_ZERO);
	}

	//ensure that 'dst' bint has the given size
	t_bint * r = bint_ensure_size(dst, size);
	if (r == NULL) {
		return (NULL);
	}

	size_t i;
	for (i = 0 ; i < r->size ; i++) {
		*(r->words + i) = rand();
	}

	r->wordset = size;
	r->sign = rand() % 2 == 0 ? -1 : 1;

	return (r);
}