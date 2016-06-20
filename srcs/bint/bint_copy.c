#include "bint.h"

/** assumre that dst->size >= src->size */
void bint_copy(t_bint * dst, t_bint * src) {

	if (dst == src) {
		return ;
	}

	if (dst->size < src->wordset) {
		puts("COPY OVERFLOW! dst is too small");
		return ;
	}

	dst->sign = src->sign;
	dst->wordset = src->wordset;
	memcpy(dst->words + dst->size - src->wordset, src->words + src->size - src->wordset, src->wordset * sizeof(t_word));
}
