#include "bint.h"

int bint_is_zero(t_bint *i) {
	return (i == BINT_ZERO || i->sign == 0 || i->wordset == 0);
}