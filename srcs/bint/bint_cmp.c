#include "bint.h"

static int bint_cmp_abs_raw(t_bint * a, t_bint * b) {

	//if a is zero
	if (bint_is_zero(a)) {
		//if b is zero, return 0, else a < b
		return (bint_is_zero(b) ? 0 : -1);
	}

	//if b == 0, then we know that a != 0, return a > b
	if (bint_is_zero(b)) {
		return (1);
	}


	//if a is shorter than b
	if (a->wordset < b->wordset) {
		//return -sign(a) , e.g, a = 4, b = 47, return -sign(4) = -1
		return (-1);
	}

	if (a->wordset > b->wordset) {
		return (1);
	}

	//else they have the same size
	//get the biggest word set
	t_word * aword = a->words + a->size - a->wordset;
	t_word * bword = b->words + b->size - b->wordset;

	//the end of the loop, as we know a and b have the same size also
	t_word * aend = a->words + a->size;

	do {
		if (*aword < *bword) {
			return (-1);
		} else if (*aword > *bword) {
			return (1);
		}
		++aword, ++bword;
	} while (aword < aend);

	//else a strictly equals b
	return (0);
}


/** compare the two given integers absolutely */
int bint_cmp_abs(t_bint * a, t_bint * b) {

	//if a and b are the same pointer (can be both NULL thought)
	if (a == b) {
		return (0);
	}

	//if a is NULL, then b isnt NULL
	if (a == NULL) {
		return (-1);
	}

	//if b is NULL, then a isnt NULL
	if (b == NULL) {
		return (1);
	}

	//now we know that a's sign equals b's one
	return (bint_cmp_abs_raw(a, b));
}

/** compare the two given integers */
int bint_cmp(t_bint * a, t_bint * b) {
	
	//if a and b are the same pointer (can be both NULL thought)
	if (a == b) {
		return (0);
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

	//now we know that a's sign equals b's one
	return (bint_cmp_abs_raw(a, b) * a->sign);
}