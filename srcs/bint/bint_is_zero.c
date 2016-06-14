#include "bint.h"

int bint_is_zero(t_bint *integer) {

	//fast check
	if (integer == BINT_ZERO || integer->sign == 0 || integer->wordset == 0) {
		return (1);
	}

	//slow check, should never occured as this means 'integer->wordset' should be set to 0, but nevermind...
	int i;
	for (i = 0 ; i < integer->wordset; i++) {
		if (*(integer->words + integer->size - integer->wordset + i) != 0) {
			return (0);
		}
	}

	//and then set the integer wordset to 0 as it should be
	integer->wordset = 0;

	return (1);
}