#include "bint.h"

//calculate actual wordset
static size_t bint_normalize_calculate_wordset(t_bint *integer) {
	size_t i = 0;
	while (*(integer->words + i) == 0) {
		++i;
	}
	return (integer->size - i);
}

void bint_normalize_dst(t_bint **dst) {
	if (dst == NULL || *dst == NULL) {
		return ;
	}

	//calculate actual wordset
	size_t wordset = bint_normalize_calculate_wordset(*dst);

	//if no word are set
	if (wordset == 0) {
		bint_delete(dst);
		*dst = BINT_ZERO;
		return ;
	}

	//set wordset
	(*dst)->wordset = wordset;

	//only reallocate if more than half the memory isnt used
	if (wordset >= (*dst)->size / 2) {
		return ;
	}

	//move the memory
	memmove((*dst)->words, (*dst)->words + (*dst)->size - wordset, wordset);

	//reallocate
	*dst = (t_bint*)realloc(*dst, sizeof(t_bint) + wordset * sizeof(t_word));
	(*dst)->size = wordset;
	(*dst)->wordset = wordset;
}

t_bint * bint_normalize(t_bint * src) {

	if (src == NULL) {
		return (NULL);
	}

	if (bint_is_zero(src)) {
		return (BINT_ZERO);
	}

	//calculate actual wordset
	size_t wordset = bint_normalize_calculate_wordset(src);

	//if no word are set
	if (wordset == 0) {
		return (BINT_ZERO);
	}

	//allocate new integer
	t_bint * dst = bint_new(wordset);
	if (dst == NULL) {
		return (NULL);
	}

	//move the memory
	memcpy(dst->words, src->words + src->size - wordset, wordset);
	dst->size = wordset;
	dst->wordset = wordset;
	dst->sign = src->sign;

	return (dst);
}