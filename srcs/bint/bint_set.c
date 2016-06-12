#include "bint.h"

t_bint * bint_set(t_bint **dst, int i) {

	//ensure dst capacity
	t_bint * r = bint_ensure_size(dst, bint_get_default_size());
	if (r == NULL) {
		return (NULL);
	}

	//if we are setting a zero
	if (i == 0) {
		r->sign = 0;
		r->wordset = 0;
		return (r);
	}

	//set the sign
	if (i < 0) {
		r->sign = -1;
		i = -i;
	} else {
		r->sign = 1;
	}

	//set other bits to 0
	memset(r->words, 0, (r->size - 1) * sizeof(int));
	
	//set the value
	int *addr = (int*)(r->words + r->size - 1);
	*addr = i;
	r->wordset = 1;
	return (r);
}

t_bint * bint_set_pow2(t_bint **dst, size_t i) {
	int wordbits = sizeof(int) * 8;
	size_t nwords = i / wordbits + 1;
	t_bint * r = bint_ensure_size(dst, nwords);
	if (r == NULL) {
		return (NULL);
	}

	r->sign = 1;
	r->wordset = nwords;

	memset(r->words, 0, r->size * sizeof(int));
	i = i % wordbits;
	*(r->words + r->size - r->wordset) = (1 << i);
	return (r);
}