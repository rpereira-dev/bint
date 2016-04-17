#include "bint.h"

/** no endian issues */
t_bint *bint_clone(t_bint *src) {

	if (src == NULL || src->sign == 0) {
		return (NULL);
	}

	t_bint *dst = bint_new(src->size);
	if (dst == NULL) {
		return (NULL);
	}
	dst->sign = src->sign;
	memcpy(dst->words, src->words, src->size * sizeof(int));
	dst->last_word_set = dst->words + (src->last_word_set - src->words);
	return (dst);
}