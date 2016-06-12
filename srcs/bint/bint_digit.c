#include "bint.h"

size_t bint_digit(t_bint *n) {
	//number of bitset
	double bitset = n->wordset * 4.0 * 8.0;
	//ln(2) / ln(10)
	return ((size_t)(0.30102999566 * bitset));
}
