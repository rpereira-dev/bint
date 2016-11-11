#include "bint.h"

int bint_is_zero(t_bint * integer) {

	//fast check
	if (integer == BINT_ZERO || integer->sign == 0 || integer->wordset == 0) {
		return (1);
	}

	return (0);
}