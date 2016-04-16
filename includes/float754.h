#ifndef FLOAT_IEE754_H
# define FLOAT_IEE754_H

# include "binary_tools.h"
# include "bint.h"
# include <stdio.h>
# include <stdlib.h>
# include <string.h>

/**
*	A floating point number data structure which
 *	follows the IEEE754 norm. (but with dynamic size set on allocation)
 */
typedef struct	s_float754 {
	char sign; //the sign
	t_bint exposant; //the exposant
	unsigned int mantissasize; //number of byte for the mantissa
	unsigned int sizebyte; //total number of byte
}		t_float754;


#endif
