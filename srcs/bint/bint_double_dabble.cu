#include "bint.h"

//the index of the first and last bit of a word
#define FIRST_WORD_BIT (0)
#define LAST_WORD_BIT (sizeof(int) * 8 - 1)

static void bint_shift_left_once(unsigned int *addr, size_t len) {
	unsigned int *ptr = addr + len;
	unsigned int *end = addr;
	int reminder = 0;
	while (ptr > end) {
		//will it overflow: '* 1101' -> '* 1010' -> '*1 1010'
		unsigned int next_reminder = BITSET(*ptr, LAST_WORD_BIT);

		//operate the shift
		*ptr = *ptr << 1;

		//if there was a previous overflow, set the first bit
		if (reminder) {
			SETBIT(*ptr, FIRST_WORD_BIT);
		}
		reminder = next_reminder;
		--ptr;
	}
}

void *bint_double_dabble(t_bint *i) {

	//if zero, return NULL
	if (i == BINT_ZERO || i->sign == 0) {
		return (BINT_ZERO);
	}

	//else calculate the bit sizes
	size_t nbits = i->size * sizeof(unsigned int);
	size_t nbits_bcd = nbits + 4 * nbits / 3;
	size_t nbytes_bcd = nbits_bcd / 8 + (nbits_bcd % 8 != 0);
	if (nbytes_bcd % sizeof(int) != 0) {
		 nbytes_bcd += (sizeof(int) - nbytes_bcd % sizeof(int));
	}

	//alocate bcd dst
	char *bcd = (char*)malloc(nbytes_bcd);
	if (bcd == NULL) {
		return (NULL);
	}

	//prepare the bcd pointer
	size_t wordset = i->words + i->size - i->last_word_set;
	size_t byteset = wordset * sizeof(int);
	memcpy(bcd + nbytes_bcd - byteset, i->last_word_set, byteset);
	memset(bcd, 0, nbytes_bcd - byteset);

	
}