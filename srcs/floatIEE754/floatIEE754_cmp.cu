# include "float754.h"

int float754_cmp(t_float754 *a, t_float754 *b) {

	//if we are comparing the same pointer address
	if (a == b) {
		return (0);
	}
	//else if a != b

	//if a is NULL, b isnt NULL (because a != b)
	if (a == NULL) {
		//if b is negative, return -1, +1 if positive
		return (float754_sign(b));
	}

	//if b is NULL, a isnt NULL (because a != b)
	if (b == NULL) {
		//if a is negative, return -1, +1 if positive
		return (float754_sign(a));
	}

	
	return (0);

	//TODO
}