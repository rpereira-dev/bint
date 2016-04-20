#include "bint.h"

int bint_cmp(t_bint *a, t_bint *b) {
	//if a and b are NULL
	if (a == NULL && b == NULL) {
		//0 == 0
		return (1);
	}

	//if a is NULL, then b isnt NULL
	if (a == NULL) {
		return (b->sign);
	}

	//if b is NULL, then a isnt NULL
	if (b == NULL) {
		return (a->sign);
	}

	//if they are both non NULL
	//compare sign
	if (a->sign > b->sign) {
		return (1);
	}
	if (a->sign < b->sign) {
		return (-1);
	}

	//now we ensure that a's sign equals b's one
	int sign = a->sign;

	//compare word set (as they now have the same sign)
	unsigned int aset = a->last_word_set - a->words;
	unsigned int bset = b->last_word_set - b->words;

	//if a is shorter than b
	if (aset < bset) {
		//return -sign(a) , e.g, a = 4, b = 47, return -sign(4) = -1
		return (-sign);
	}

	if (aset > bset) {
		return (sign);
	}

	//else they have the same size
	//get the biggest word set
	unsigned int *aword = a->last_word_set;
	unsigned int *bword = b->last_word_set;

	//the end of the loop, as we know a and b have the same size also
	unsigned int *aend = a->words + a->size;

	do {
		if (*aword < *bword) {
			return (-sign);
		} else if (*aword > *bword) {
			return (sign);
		}
		++aword;
		++bword;
	} while (aword < aend);

	puts("OK MEC");

	//else a strictly equals b
	return (0);
}