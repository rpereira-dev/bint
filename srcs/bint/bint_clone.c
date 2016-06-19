#include "bint.h"

/** clone the given integer */
t_bint *bint_clone(t_bint *src) {

	/** if zero, return a zero */
	if (bint_is_zero(src)) {
		return (BINT_ZERO);
	}

	// create a new integer
	t_bint *dst = bint_new(src->size);
	if (dst == NULL) {
		return (NULL);
	}
	
	// copy sign
	dst->sign = src->sign;
	//copy raw bytes
	memcpy(dst->words, src->words, src->size * sizeof(int));
	//copy number of word set
	dst->wordset = src->wordset;
	return (dst);
}
