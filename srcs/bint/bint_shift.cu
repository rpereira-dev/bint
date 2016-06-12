#include "bint.h"

#define FIRST_WORD_BIT (0)
#define LAST_WORD_BIT (sizeof(int) * 8 - 1)

static void bint_shift_left_once(t_bint *dst) {
	unsigned int *ptr = dst->words + dst->size - 1;
	unsigned int *end = dst->words + dst->size - dst->wordset;
	int reminder = 0;

	while (ptr >= end) {

		//check overflow (if the last bit is set, then it will overflow)
		unsigned int next_reminder = *ptr & (1 << LAST_WORD_BIT);

		//operate the shift
		*ptr = *ptr << 1;

		//if there was a previous overflow, set the first bit
		if (reminder) {
			*ptr = *ptr | (1 << FIRST_WORD_BIT);
		}
		reminder = next_reminder;
		--ptr;
	}

	if (reminder) {	
		*ptr = *ptr | (1 << FIRST_WORD_BIT);
		dst->wordset++;
	}
}

static void bint_shift_right_once(t_bint *dst) {
	unsigned int *ptr = dst->words + dst->size - dst->wordset;
	unsigned int *end = dst->words + dst->size;
	int reminder = 0;
	while (ptr < end) {
		//check underflow (if the first bit is set, then it will underflow)
		unsigned int next_reminder = *ptr & (1 << FIRST_WORD_BIT);

		//operate the shift
		*ptr = *ptr >> 1;

		//if there was a previous overflow, set the last bit
		if (reminder) {
			*ptr = *ptr | (1 << LAST_WORD_BIT);
		}
		reminder = next_reminder;
		--ptr;
	}
}

static t_bint *bint_shift_dst_raw(t_bint **dst, t_bint *integer, unsigned int n, void (*shift_function)(t_bint *)) {

	//the pointer to store the result
	t_bint *r = bint_ensure_size(dst, integer->size);

	//if allocation failed...
	if (r == NULL) {
		return (NULL);
	}

	//copy the integer to shift
	bint_copy(r, integer);

	//shift it n times
	unsigned int i;
	for (i = 0 ; i < n ; i++) {
		shift_function(r);
	}

	return (r);
}

t_bint *bint_shift_left(t_bint *i, int n) {
	return (bint_shift_left_dst(NULL, i, n));
}

t_bint *bint_shift_left_dst(t_bint **dst, t_bint *i, int n) {

	//if i is 0, return 0
	if (i == NULL || i->sign == 0) {
		return (NULL);
	}

	//the shift function to use (left or right)
	void (*shift_function)(t_bint *);
	//the number of time to shift
	unsigned int times;

	//if n is negative, then we shift right -n times
	if (n < 0) {
		times = -n;
		shift_function = bint_shift_right_once;
	} else {
		//else n is positive, we shift left n times
		times = n;
		shift_function = bint_shift_left_once;
	}
	return (bint_shift_dst_raw(dst, i, times, shift_function));
}


t_bint *bint_shift_right(t_bint *i, int n) {
	return (bint_shift_left_dst(NULL, i, n));
}

t_bint *bint_shift_right_dst(t_bint **dst, t_bint *i, int n) {

	//if i is 0, return 0
	if (bint_is_zero(i)) {
		return (BINT_ZERO);
	}

	//the shift function to use (left or right)
	void (*shift_function)(t_bint *);
	//the number of time to shift
	unsigned int times;

	//if n is negative, then we shift left -n times
	if (n < 0) {
		times = -n;
		shift_function = bint_shift_left_once;
	} else {
		//else n is positive, we shift right n times
		times = n;
		shift_function = bint_shift_right_once;
	}
	return (bint_shift_dst_raw(dst, i, times, shift_function));
}