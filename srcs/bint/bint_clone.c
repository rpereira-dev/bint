#include "bint.h"

/** no endian issues */
t_bint *bint_clone(t_bint *src) {

	if (bint_is_zero(src)) {
		return (BINT_ZERO);
	}

	t_bint *dst = bint_new(src->size);
	if (dst == NULL) {
		return (NULL);
	}
	
	dst->sign = src->sign;
	memcpy(dst->words, src->words, src->size * sizeof(int));
	dst->wordset = src->wordset;
	return (dst);
}