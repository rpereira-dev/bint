#include "bint.h"

t_bint *bint_new(unsigned int size) {

	//so the size is > 0 and multiple of sizeof(int)
	if (size == 0) {
		size = 1;
	}

	//allocate memory space
	t_bint *i = (t_bint*)malloc(sizeof(t_bint) + size * sizeof(int));
	if (i == NULL) {
		return (NULL);
	}

	//assign size
	i->size = size;
	i->sign = 0;
	i->words = (unsigned int*)(i + 1);
	i->last_word_set = i->words + size;

	//return it
	return (i);
}

/** 8bits version new and set */
t_bint *bint_new8(char value) {
	t_bint *i = bint_new(sizeof(char));
	if (i == NULL) {
		return (NULL);
	}
	bint_set8(i, value);
	return (i);
}

/** 16bits version new and set */
t_bint *bint_new16(short value) {
	t_bint *i = bint_new(sizeof(short));
	if (i == NULL) {
		return (NULL);
	}
	bint_set16(i, value);
	return (i);
}

/** 32bits version new and set */
t_bint *bint_new32(int value) {
	t_bint *i = bint_new(sizeof(int));
	if (i == NULL) {
		return (NULL);
	}
	bint_set32(i, value);
	return (i);
}

/** 64bits version new and set */
t_bint *bint_new64(long int value) {
	t_bint *i = bint_new(sizeof(long long int));
	if (i == NULL) {
		return (NULL);
	}
	bint_set64(i, value);
	return (i);
}