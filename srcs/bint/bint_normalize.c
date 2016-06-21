#include "bint.h"

/** recalculate the number of words set */
void bint_update_wordset(t_bint * integer) {
	if (integer == NULL || integer == BINT_ZERO) {
		return ;
	}

	size_t i = 0;
	while (*(integer->words + i) == 0 && i < integer->size) {
		++i;
	}
	integer->wordset = integer->size - i;
	printf("wordset set to: %d\n", integer->wordset);
}

/** normalize the given integer so it take the least possible memory space */
void bint_normalize_dst(t_bint ** dst) {
	if (dst == NULL || *dst == NULL || bint_is_zero(*dst)) {
		return ;
	}

	//move the memory
	memmove((*dst)->words, (*dst)->words + (*dst)->size - (*dst)->wordset, (*dst)->wordset * sizeof(t_word));

	//reallocate
	*dst = (t_bint*)realloc(*dst, sizeof(t_bint) + (*dst)->wordset * sizeof(t_word));
	if (*dst == NULL) {
		return ;
	}
	(*dst)->size = (*dst)->wordset;
}

/** normalize the given integer so it take the least possible memory space */
t_bint * bint_normalize(t_bint * src) {

	if (src == NULL) {
		return (NULL);
	}

	if (bint_is_zero(src)) {
		return (BINT_ZERO);
	}

	//allocate new integer
	t_bint * dst = bint_new(src->wordset);
	if (dst == NULL) {
		return (NULL);
	}

	//move the memory
	memcpy(dst->words, src->words + src->size - src->wordset, src->wordset);
	dst->wordset = src->wordset;
	dst->sign = src->sign;

	return (dst);
}