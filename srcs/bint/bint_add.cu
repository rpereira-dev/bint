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

t_bint *bint_add(t_bint *a, t_bint *b) {
	return (bint_add_dst(NULL, a, b));
}

t_bint *bint_add_dst(t_bint **dst, t_bint *a, t_bint *b) {

	//if a and b are 0
	if (bint_is_zero(a) && bint_is_zero(b)) {
		//return 0
		return (BINT_ZERO);
	}

	//the size to store the result
	int size = a == NULL ? b->size : b == NULL ? a->size : a->size > b->size ? a->size : b->size;

	//ensure that 'dst' bint has the given size
	t_bint * r = bint_ensure_size(dst, size);

	//if allocation failed
	if (r == NULL) {
		return (NULL);
	}

	//do the addition, r has now a correct size to store the result

	//if one is NULL, return a copy of the other
	if (a == NULL || a->sign == 0) {
		bint_copy(r, b);
	} else if (b == NULL || b->sign == 0) {
		bint_copy(r, a);
	} else {

		//compare the two integers
		int cmp = bint_cmp(a, b);
		
		//if a == b, then return 2 * a
		if (cmp == 0) {
			//dst = a << 1 = 2 * a
			bint_shift_left_dst(dst, a, 1);
		} else {

			//else, if a < b
			if (cmp < 0) {
				//swap them, so we always then have a > b
				t_bint *tmp = a;
				a = b;
				b = tmp;
			}
			
			//' a + (-b) ' becomes ' a - b '
			//notice that the case '(-a) + b ' becoming ' b - a' is impossible here: a > b
			if (a->sign == 1 && b->sign == -1) {
				//TODO : a - abs(b)
			} else {
				//a and b have the same size, and a > b
				//set the sign
				r->sign = a->sign;

				//finally do the addition
				_bint_add_dst_raw(r, a, b);
			}

		}
	}

	//return the result
	return (r);
}

