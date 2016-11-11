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
}

# define BINT_NORMALIZED_OFFSET (1)

/** normalize the given integer so it take the least possible memory space */
void bint_normalize_dst(t_bint ** dst) {
	if (dst == NULL || *dst == NULL || bint_is_zero(*dst) || (*dst)->wordset >= (*dst)->size - BINT_NORMALIZED_OFFSET) {
		return ;
	}

	//move the memory
	t_word * dstaddr = (*dst)->words + BINT_NORMALIZED_OFFSET;
	t_word * srcaddr = (*dst)->words + (*dst)->size - (*dst)->wordset;
	size_t len = (*dst)->wordset * sizeof(t_word);

	puts("A");
	bint_dump(*dst), puts("");
	memmove(dstaddr, srcaddr, len);

	bint_dump(*dst), puts("");
	puts("B");

	//reallocate
	*dst = (t_bint*)realloc(*dst, sizeof(t_bint) + ((*dst)->wordset + BINT_NORMALIZED_OFFSET) * sizeof(t_word));
	if (*dst == NULL) {
		return ;
	}
	(*dst)->size = (*dst)->wordset + BINT_NORMALIZED_OFFSET;
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
	size_t size = src->wordset + BINT_NORMALIZED_OFFSET;
	t_bint * dst = bint_new(size);
	if (dst == NULL) {
		return (NULL);
	}

	//move the memory
	memcpy(dst->words + BINT_NORMALIZED_OFFSET, src->words + src->size - src->wordset, src->wordset);
	dst->wordset = src->wordset;
	dst->sign = src->sign;

	return (dst);
}