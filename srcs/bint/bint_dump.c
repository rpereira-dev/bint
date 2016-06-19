#include "bint.h"

void bint_dump(t_bint *integer) {

	if (integer == NULL) {
		printf("bint: {NULL}");
	}
	else if (bint_is_zero(integer)) {
		printf("bint: {0}");
	} else {
		char sign = (integer->sign == -1) ? '-' : (integer->sign == 1) ? '+' : '0';
		printf("bint: {size: %lu, wordset: %lu, sign: %c, words: ", integer->size, integer->wordset, sign);
		bdump(integer->words + integer->size - integer->wordset, integer->wordset * sizeof(t_word));
		printf("}");
	}
}
