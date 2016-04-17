#include "bint.h"

void bint_dump(t_bint *i) {

	if (i == NULL || i->sign == 0) {
		printf("bint: {NULL or 0}");
	} else {
		char *sign = i->sign == -1 ? "-" : i->sign == 1 ? "+" : NULL;
		printf("bint: {size: %u, sign: %2d, words: %s", i->size, i->sign, sign);
		bdump(i->last_word_set, (i->size - (i->last_word_set - i->words)) * 4);
	}
}
