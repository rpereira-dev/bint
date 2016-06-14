#include "bint.h"

t_bint *bint_new(unsigned int size) {

	//so the size is > 0 and multiple of sizeof(int)
	if (size == 0) {
		size = 1;
	}

	//allocate memory space
	t_bint *i = (t_bint*)malloc(sizeof(t_bint) + size * sizeof(t_word));
	if (i == NULL) {
		return (NULL);
	}

	//assign size
	i->size = size;
	i->sign = 0;
	i->words = (unsigned int*)(i + 1);
	i->wordset = 0;

	//return it
	return (i);
}
