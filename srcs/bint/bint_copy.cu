#include "bint.h"

/** assumre that dst->size >= src->size */
void bint_copy(t_bint *dst, t_bint *src) {

	unsigned int src_word_set = src->words + src->size - src->last_word_set;
	dst->sign = src->sign;
	dst->last_word_set = dst->words + dst->size - src_word_set;
	memcpy(dst->last_word_set, src->last_word_set, src_word_set * sizeof(int));
}
