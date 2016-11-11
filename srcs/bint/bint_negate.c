#include "bint.h"

t_bint * bint_negate(t_bint * i) {
	return (bint_negate_dst(NULL, i));
}

t_bint * bint_negate_dst(t_bint ** dst, t_bint * i) {
	//if we try to negate 0....
	if (bint_is_zero(i)) {
		//if the given destination is non NULL
		if (dst != NULL) {
			//if the given destination is set to NULL
			if (*dst == NULL) {
				//set it to zero
				*dst = BINT_ZERO;
			} else if (*dst != BINT_ZERO) {
				//else set the sign to zero
				(*dst)->sign = 0;	
			}
			//else destination is already 0 (NULL), return it
			return (*dst);
		}
		//else destination is already 0 (NULL), return it
		return (NULL);
	}

	//else, i != 0
	
	//ensure that the destination where the result is stored has a correct size
	t_bint * r = bint_ensure_size(dst, i->size);

	//if allocation failed, return NULL
	if (r == NULL) {
		return (NULL);
	}

	//copy the number to the destination
	bint_copy(r, i);

	//negate the sign
	r->sign = -i->sign;

	//return it
	return (r);
}
