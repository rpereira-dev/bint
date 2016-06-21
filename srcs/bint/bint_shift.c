#include "bint.h"

# define FIRST_WORD_BIT (0)
# define LAST_WORD_BIT (sizeof(int) * 8 - 1)

/****************************    LEFT SHITING    **********************************/

/** left-shift n times the given big integer given that 0 <= n <= BINT_WORD_BITS */
static void bint_shift_left_n(t_bint *r, t_word *left, t_word *right, size_t n) {

	//we do the shift right to left to handle overflow

	if (n == 0) {
		return ;
	}

	//carry / reminder mask
	t_word carry_mask = 0;
	t_word tmp_mask = 0;

	//the raw mask to apply
	t_word mask = ((1 << n) - 1) << (BINT_WORD_BITS - n);

	//for each word
	while (right >= left) {
		//calculate next mask
		tmp_mask = (*right & mask) >> (BINT_WORD_BITS - n);

		//do the shift
		*right = *right << n | carry_mask;

		//assign next mask
		carry_mask = tmp_mask;
	
		//process next word
		--right;
	}

	if (carry_mask && r->wordset < r->size) {
		*right = carry_mask;
		++r->wordset;
	}
}

t_bint *bint_shift_left(t_bint * integer, int n) {
	return (bint_shift_left_dst(NULL, integer, n));
}

t_bint * bint_shift_left_dst(t_bint ** dst, t_bint * integer, int n) {

	//if left shifting negatively, then shift right
	if (n < 0) {
		return (bint_shift_right_dst(dst, integer, -n));
	}

	//if null
	if (integer == NULL) {
		return (NULL);
	}

	//if 0, return 0
	if (bint_is_zero(integer)) {
		if (dst != NULL && *dst != NULL) {
			free(*dst);
			*dst = BINT_ZERO;
		}
		return (BINT_ZERO);
	}

	//number of raw words to shift
	size_t word_to_shift = n / BINT_WORD_BITS;

	//size of dst so the result can be stored (left shiting handle overflow)
	size_t size = (word_to_shift < integer->size - integer->wordset) ? integer->size : (integer->size + word_to_shift + 1);

	//the pointer to store the result
	t_bint *r = bint_ensure_size(dst, size);

	//if allocation failed...
	if (r == NULL) {
		return (NULL);
	}

	//copy the integer to shift
	bint_copy(r, integer);

	//shift each word of the integer 'word_to_shift' times left
	if (word_to_shift >= 1) {

		//number of word to shift
		t_word *right = r->words + r->size - 1;
		t_word *left = r->words + r->size - r->wordset;

		while (left <= right) {
			*(left - word_to_shift) = *left;
			++left;
		}

		//set to most right word to 0 (they've been shifted to left already)
		memset(r->words + r->size - word_to_shift, 0, word_to_shift * sizeof(t_word));

		//increase number of wordset
		r->wordset += word_to_shift;

		//calculate the remaining bits to shift
		n = n % BINT_WORD_BITS;
	}

	printf("%d : %d\n", word_to_shift, n);

	//the begining shift address (most right word)
	t_word *right = r->words + r->size - 1 - word_to_shift;
	t_word *left = r->words + r->size - r->wordset;

	//shift the remaining bits
 	bint_shift_left_n(r, left, right, n);

 	bint_update_wordset(r);

	return (r);
}


/****************************    RIGHT SHITING    **********************************/

/** right shift n times the given big integer given that 0 <= n <= BINT_WORD_BITS */
static void bint_shift_right_n(t_bint *r, t_word *left, t_word *right, size_t n) {

	//we do the shift left to right to handle underflow on words
	if (n == 0) {
		return ;
	}

	//carry / reminder mask
	t_word carry_mask = 0;
	t_word tmp_mask = 0;

	//the raw mask to apply
	t_word mask = (1 << n) - 1;

	//for each word
	while (left <= right) {

		//calculate next mask
		tmp_mask = (*left & mask) << (BINT_WORD_BITS - n);

		//do the shift
		*left = *left >> n | carry_mask;

		//assign next mask
		carry_mask = tmp_mask;
	
		//process next word
		++left;
	}

	//call is_zero function : if the shift made the number equals to zero, 'bint_is_zero()' will set it properly to 0
	//bint_is_zero(r);
	//TODO
}


t_bint *bint_shift_right(t_bint * integer, int n) {
	return (bint_shift_right_dst(NULL, integer, n));
}

t_bint *bint_shift_right_dst(t_bint **dst, t_bint *integer, int n) {

	//if right shifting negatively, then shift left
	if (n < 0) {
		return (bint_shift_left_dst(dst, integer, -n));
	}

	//if null
	if (integer == NULL) {
		return (NULL);
	}

	//if 0, return 0
	if (bint_is_zero(integer)) {
		return (BINT_ZERO);
	}

	//number of raw words to shift
	size_t word_to_shift = n / BINT_WORD_BITS;

	//size of dst so the result can be stored (right shifting doesnt handle underflow)
	size_t size = integer->size;

	//the pointer to store the result
	t_bint *r = bint_ensure_size(dst, size);

	//if allocation failed...
	if (r == NULL) {
		return (NULL);
	}

	//copy the integer to shift
	bint_copy(r, integer);

	//shift each word of the integer 'word_to_shift' times left
	if (word_to_shift >= 1) {

		//number of word to shift
		t_word *right = r->words + r->size - 1 - word_to_shift;
		t_word *left = r->words + r->size - r->wordset;

		while (right >= left) {
			*(right + word_to_shift) = *right;
			--right;
		}

		//set to most left word to 0 (they've been shifted to right)
		memset(left, 0, word_to_shift * sizeof(t_word));

		//decrease number of wordset (most left words were unset by the shiting)
		r->wordset -= word_to_shift;
		if (r->wordset < 0) {
			r->wordset = 0;
		}

		//calculate the remaining bits to shift
		n = n % BINT_WORD_BITS;
	}

	//the begining shift address (most right word)
	t_word *right = r->words + r->size - 1;
	t_word *left = r->words + r->size - r->wordset;

	//shift the remaining bits
 	bint_shift_right_n(r, left, right, n);

 	bint_update_wordset(r);

	return (r);
}