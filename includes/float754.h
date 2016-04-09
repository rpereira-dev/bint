#ifndef FLOAT_EXTENDED_H
# define FLOAT_EXTENDED_H

# include <stdio.h>
# include <stdlib.h>
# include <string.h>

/**
*	A floating point number data structure which
 *	follows the IEEE754 norm. (but with dynamic size set on allocation)
 */
typedef struct	s_float754 {
	unsigned int exposantbit;
	unsigned int mantissabit;
	unsigned int exposantbyte;
	unsigned int mantissabyte;
	unsigned int sizebit;
	unsigned int sizebyte;
}		t_float754;

/** create a new t_float754, sizes are in bits */
t_float754 *float754_new(unsigned int exposant_size, unsigned int mantissa_size);
t_float754 *float754_new32(float f);

/** clone the given float */
t_float754 *float754_clone(t_float754 *a);


/** dump the given float to stdout */
void float754_dump(t_float754 *f);

/**
*	set the float value from the given binary string.
*	if f is NULL, NULL is returned
*	if sizes doesnt match or an error occured, NULL is returned.
*	if str is NULL, f is set to 0
*
*	support two format for now:
*			"01011011 01011011 01011011 01011011"
*		or
*			"01011011010110110101101101011011"
*/
t_float754 *float754_set(t_float754 *f, unsigned char const *str);

/**
*	set version for float32 which is faster than converting the float to a string.
*	NO CHECK ARE DONE: the given float754 parameter should be properly sized
*/
t_float754 *float754_set32(t_float754 *F, float f);


/**
*	compare the two given floats, behave as 'strcmp()' :
*	if a < b:
*		return -1
*	if a > b:
*		return 1
*	if a == b:
*		return 0
*/
int float754_cmp(t_float754 *a, t_float754 *b);

/** return the sign of the given float: -1 on negative, 1 on positive, 0 on 0 */
int float754_sign(t_float754 *f);

/** negate the number: f <- -f */
t_float754 *float754_negate(t_float754 *f);

/**
*	README:
*
*	- The given operation functions bellow take a float with any sizes
*
*	- NULL is always interpreted as 0
*	
*	- dst pointer is always the destination pointer, where the operation should be store
*	if NULL, it allocates a new pointer with the greatest sizes of the given operands.
*	This destination pointer is always returned (can be null on insuffisant memory)
*
*/

/**
*	(dst) <- a
*/
t_float754 *float754_assign(t_float754 *dst, t_float754 *a);


/**
*	(dst) <- (a + b)
*/
t_float754 *float754_add(t_float754 *dst, t_float754 *a, t_float754 *b);

/**
*	(dst) <- (a - b)
*/
t_float754 *float754_sub(t_float754 *dst, t_float754 *a, t_float754 *b);

/**
*	(dst) <- (a * b)
*/
t_float754 *float754_mult(t_float754 *dst, t_float754 *a, t_float754 *b);

/**
*	(dst) <- (a / b)
*/
t_float754 *float754_div(t_float754 *dst, t_float754 *a, t_float754 *b);

/**
*	(dst) <-  floor(f)
*/
t_float754 *float754_floor(t_float754 *dst, t_float754 *a, t_float754 *b);

/**
*	(dst) <-  ceil(f)
*/
t_float754 *float754_ceil(t_float754 *dst, t_float754 *f);

/**
*	(dst) <- abs(f)
*/
t_float754 *float754_abs(t_float754 *dst, t_float754 *f);

#endif
