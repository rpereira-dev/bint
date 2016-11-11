#include "bint.h"

t_bint * bint_new(unsigned int size) {

	//so the size is > 0 and multiple of sizeof(int)
	if (size == 0) {
		size = 1;
	}

	size_t words_size = size * sizeof(t_word);

	//allocate memory space
	t_bint * i = (t_bint*)malloc(sizeof(t_bint) + words_size);
	if (i == NULL) {
		return (NULL);
	}

	//assign size
	i->size = size;
	i->sign = 0;
	i->words = (t_word*)(i + 1);
	i->wordset = 0;

	memset(i->words, 0, words_size);

	//return it
	return (i);
}
