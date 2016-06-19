#include "bint.h"

void bint_set_bit(t_bint *integer, size_t bit) {

	if (integer == NULL) {
		return ;
	}

	//word of this bit
	size_t words = bit / BINT_WORD_BITS;
	//position of this bit on the words
	char bits = bit % BINT_WORD_BITS;

	//set it
	*(integer->words + integer->size - words) |= (1 << bits);
}

void bint_unset_bit(t_bint *integer, size_t bit) {
	if (integer == NULL) {
		return ;
	}

	//word of this bit
	size_t words = bit / BINT_WORD_BITS;
	//position of this bit on the words
	char bits = bit % BINT_WORD_BITS;


	//unset it
	*(integer->words + integer->size - words - 1) &= ~(1 << bits);
}