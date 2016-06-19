#include "bint.h"

static void bint_mult_dst_elementary(t_bint *r, t_bint *a, t_bint *b) {
	int i = 1;
	while (i <= a->wordset) {
		//reminder
		t_dword carry = 0;
		//the current 'a' digit processed
		t_dword aword = *(a->words + a->size - i);
		//the current 'r' digit to write
		t_word *rword = r->words + r->size - i;

		//for each of 'b' words ...
		t_word *bword = b->words + b->size - 1;
		t_word *bend = b->words + b->size - b->wordset - 1;

		while (bword >= bend) {
			carry += *rword + *bword * aword;
			*rword = carry;
			carry >>= BINT_WORD_BITS;
			--rword;
			--bword;
		}

		if (carry) {
			*rword += carry;
		}
		++i;
	}
}

t_bint *bint_mult(t_bint *a, t_bint *b) {
	return (bint_mult_dst(NULL, a, b));
}


/**
*	KARATSUBA multiplication algorythm (base 2)
*
*	SPLIT THE MULTIPLICATION INTO SMALLER MULTIPICATIONS
*
*	express 'a' and 'b' as:
*		a = 2^(n)  . x  + y
*		b = 2^(n') . x' + y'
*	so the product becomes:
*		a * b = 2^(n + n').x.x' + 2^(n).x.y' + 2^(n').x'.y + y.y'
*
*	we always ensure that:
*		x = x' = 1
*	and so the product becomes...:
*		a * b = 2^(n + n') + 2^(n).y' + 2^(n').y + y.y'
*		      = (1 << (n + n')) + (y' << n) + (y << n') + y.y'
*	... 3 bit shifts, 3 additions, 1 smaller multiplication
*	
*	repeat recursively on the product y.y' until y' has reached KARATSUBA_THRESHOLD bits
*
**/
static t_bint *bint_mult_karatsuba_get_y(t_bint *integer, size_t n) {
	t_bint * y = bint_normalize(integer);
	bint_unset_bit(y, n);
	return (y);
}

static size_t bint_mult_karatsuba_get_n(t_bint *integer) {
	t_word last_word = *(integer->words + integer->size - integer->wordset);
	size_t last_word_bit_count = 0;

	//TODO try to replace this 3 lines by a dichotomy algorythm
	// so we get 2^(last_word_bit_count - 1) <= last_word <= 2^last_word_bit_count
	while (last_word) {
		last_word >>= 1;
		++last_word_bit_count;
	}

	return ((integer->wordset - 1) * BINT_WORD_BITS + last_word_bit_count);
}

static void bint_mult_karatsuba(t_bint *r, t_bint *a, t_bint *b) {
	size_t n_a = bint_mult_karatsuba_get_n(a) - 1;
	size_t n_b = bint_mult_karatsuba_get_n(b) - 1;
	t_bint * y_a = bint_mult_karatsuba_get_y(a, n_a);
	t_bint * y_b = bint_mult_karatsuba_get_y(b, n_b);

	//create 2^(n + n')
	t_bint * two_n = bint_set_pow2(NULL, n_a + n_b);
	
	//process y.y'
	t_bint *y_r = bint_mult(y_a, y_b);

	//process 2^(n) * y' AND 2^(n') * y
	bint_shift_left(y_a, n_b);
	bint_shift_left(y_b, n_a);


	bint_add_dst(&r, two_n, y_a);
	bint_add_dst(&r, r, y_b);

	printf("r  : "), bint_dump(r), puts("");
	printf("y_r: "), bint_dump(y_r), puts("");
	bint_add_dst(&r, r, y_r);
	printf("r  : "), bint_dump(r), puts("");


	bint_delete(&y_a);
	bint_delete(&y_b);
	bint_delete(&two_n);
	bint_delete(&y_r);
}

t_bint *bint_mult_dst(t_bint **dst, t_bint *a, t_bint *b) {

	static int lol = 0;

	//if a or b is 0
	if (bint_is_zero(a) || bint_is_zero(b)) {
		//return 0
		return (BINT_ZERO);
	}

	//ensure that 'dst' bint has the given size
	t_bint * r = bint_ensure_size(dst, a->wordset + b->wordset);

	//if allocation failed
	if (r == NULL) {
		return (NULL);
	}

	//calculate sign
	r->sign = a->sign * b->sign;

	if (a->wordset > b->wordset) {
		t_bint *tmp = a;
		a = b;
		b = tmp;
	}

	//karatsuba algorythm optimized for base 2
	if (0) {
		lol = 1;
		bint_mult_karatsuba(r, a, b);
	}
	else {
		//do standart multiplication
		bint_mult_dst_elementary(r, a, b);
	}

	//normalize the result
	bint_normalize_dst(&r);

	return (r);
}

