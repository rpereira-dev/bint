#include "bint.h"

/** a slow addition version which add bits by bits, but handle overflowing */

/*
#define PROCESS_BIT(i) total = BITSET(*abits, i) + BITSET(*bbits, i) + reminder; \
			if (total == 0) {\
				UNSETBIT(*dstbits, i);\
			} else if (total == 1 && reminder == 0) {\
				SETBIT(*dstbits, i);\
			} else if (total == 1 && reminder != 0) {\
				reminder = 0;\
				SETBIT(*dstbits, i);\
			} else if (total == 2 && reminder == 0) {\
				reminder = 1;\
				UNSETBIT(*dstbits, i);\
			} else if (total == 2 && reminder != 0) {\
				reminder = 0;\
				UNSETBIT(*dstbits, i);\
			} else if (total == 3) {\
				reminder = 1,\
				SETBIT(*dstbits, i);\
			}

static void bint_add_bits_by_bits_dst(t_bint *dst, t_bint *a, t_bint *b) {

	dst->sign = a->sign;
	int *abits = (int*)(a->bits + a->size);
	int *bbits = (int*)(b->bits + b->size);
	int *dstbits = (int*)(dst->bits + dst->size);
	int reminder = 0;
	int total = 0;
	int *end = (int*)a->bits;

	while (--abits >= end) {

		--bbits;
		--dstbits;

		PROCESS_BIT(0);
		PROCESS_BIT(1);
		PROCESS_BIT(2);
		PROCESS_BIT(3);
		PROCESS_BIT(4);
		PROCESS_BIT(5);
		PROCESS_BIT(6);
		PROCESS_BIT(7);

		PROCESS_BIT(8);
		PROCESS_BIT(9);
		PROCESS_BIT(10);
		PROCESS_BIT(11);
		PROCESS_BIT(12);
		PROCESS_BIT(13);
		PROCESS_BIT(14);
		PROCESS_BIT(15);

		PROCESS_BIT(16);
		PROCESS_BIT(17);
		PROCESS_BIT(18);
		PROCESS_BIT(19);
		PROCESS_BIT(20);
		PROCESS_BIT(21);
		PROCESS_BIT(22);
		PROCESS_BIT(23);

		PROCESS_BIT(24);
		PROCESS_BIT(25);
		PROCESS_BIT(26);
		PROCESS_BIT(27);
		PROCESS_BIT(28);
		PROCESS_BIT(29);
		PROCESS_BIT(30);
		PROCESS_BIT(31);
	}
}
*/

/** add the two numbers, assuming they have the same sign and a >= b */
static void _bint_add_dst_raw(t_bint *dst, t_bint *a, t_bint *b) {

	unsigned int *awords = a->words + a->size;
	unsigned int *bwords = b->words + b->size;
	unsigned int *dstwords = dst->words + dst->size;
	unsigned int reminder = 0;

	//add the two integers
	do {
		*(--dstwords) = *(--awords) + *(--bwords) + reminder;
		reminder = *dstwords < *awords || *dstwords < *bwords;
	} while (bwords >= b->last_word_set);

	//if they are remaining bits to add in 'a' and a reminder
	if (awords >= b->last_word_set && reminder) {
		*(--dstwords) = *(--awords) + reminder;
	}

	//if they are STILL remaining bits to add in 'a'
	while (awords >= b->last_word_set) {
		*(--dstwords) = *(--awords);
	}

	dst->last_word_set = dstwords + 1;
}

/** add two integer a, b, with the same sizes, they are assumed non-both NULL */
static void _bint_add_dst(t_bint *dst, t_bint *a, t_bint *b) {

	//if one is NULL, return a copy of the other
	if (a == NULL || a->sign == 0) {
		bint_copy(dst, b);
		return ;
	}
	if (b == NULL || b->sign == 0) {
		bint_copy(dst, a);
		return ;
	}

	//if a < b
	if (bint_cmp(a, b) < 0) {
		//swap them
		t_bint *tmp = a;
		a = b;
		b = tmp;
	}

	//if both negative or both positive
	if (a->sign == -1 && b->sign == 1) {
		//TODO SUB b - abs(a)
		return ;
	} else if (a->sign == 1 && b->sign == -1) {
		//TODO sub fast a - abs(b)
		return ;
	} else {
		dst->sign = a->sign;
		_bint_add_dst_raw(dst, a, b);
	}
}

t_bint *bint_add(t_bint *a, t_bint *b) {
	return (bint_add_dst(NULL, a, b));
}

t_bint *bint_add_dst(t_bint **dst, t_bint *a, t_bint *b) {

	//if a and b are 0
	if ((a == NULL || a->sign == 0) && (b == NULL || b->sign == 0)) {
		//return 0
		return (NULL);
	}

	//the size to store the result
	int size = a == NULL ? b->size : b == NULL ? a->size : a->size > b->size ? a->size : b->size;

	//the return value
	t_bint *r;

	//if dst is NULL
	if (dst == NULL) {
		//create a new integer
		r = bint_new(size);
	} else if ((*dst) == NULL || (*dst)->size < size) {
		//free it
		free(*dst);
		//allocate the return value
		r = bint_new(size);
		//set the return value to dst
		*dst = r;
	} else {
		r = *dst;
	}

	_bint_add_dst(r, a, b);

	return (r);
}

