#include "bint.h"

/**
**	compute an approximation of the log of the given big integer in the given base
**
**	in :  integer, base
**	out:  logbase(integer)
**
**	the approximation give an error of 'logb(2)' in worst case:
**	abs(X - logbase(integer)) <= logbase(2)
**	//where X is the real value of logb(n)
**
**	proof:
**	
**	let n be a natural integer so that:
**	    2^n <= integer <= 2^(n + 1)
**	 We apply logbase() to the inequality:
**	 => logbase(2^n) <= logbase(integer) <= logbase(2^(n + 1))
**	 => n * logbase(2) <= logbase(integer) <= (n + 1)logbase(2)
**
**	1) to compute 'n', we check the last set bit of the integer.
**	2) logbase(2) is pre-computed for base in range of [2, 16], help it is computed dynamically using : logbase(2) = ln(2) / ln(base)
**
*/
static double _bint_log(t_bint *integer, int base, int bound) {

	static double _logtwos[] = {0, 1 / 0.0f, 1, 0.63092975357, 0.5,
		0.43067655807, 0.38685280723, 0.3562071871, 0.33333333333,
		0.31546487678, 0.30102999566, 0.28906482631, 0.27894294565,
		0.27023815442, 0.26264953503, 0.25595802481, 0.25};

	if (base < 0 || bint_is_zero(integer) || integer->sign == -1) {
		return (-1);
	}

	if (base < 0) {
		return (-1);
	}

	//compute logbase(2) : WARNING: C standart library ln function is called 'log'
	double logbtwo = (base == BINT_LOG_BASE_E) ? 0.69314718056 : (base > 16) ? log(base) / log(base) : _logtwos[base];

	//n computation
	t_word lastword = *(integer->words + integer->size - integer->wordset);
	int lastword_bitset = BINT_WORD_BITS;
	while (!(lastword & (1 << (BINT_WORD_BITS - 1))) && --lastword_bitset) {
		lastword = lastword << 1;
	}
	if (bound == 0) {
		--lastword_bitset;
	}
	double n = (integer->wordset - 1) * BINT_WORD_BITS + lastword_bitset;
	return (logbtwo * n);
}

double bint_log_lower(t_bint *integer, int base) {
	return (_bint_log(integer, base, 0));
}

double bint_log_upper(t_bint *integer, int base) {
	return (_bint_log(integer, base, 1));
}

double bint_log(t_bint *integer, int base) {
	return (bint_log_lower(integer, base));
}
