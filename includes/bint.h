#ifndef BINT_H
# define BINT_H

# include "btools.h"
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <sys/time.h>
# include <math.h>
# include <limits.h>

//we define zero != NULL so we can know whether a function returns a memory error (NULL) or actually zero (BINT_ZERO)
# define BINT_ZERO ((t_bint*)1)

//the 't_word' type: the big integer is stored in an array of t_word
typedef unsigned int t_word;

//size of a word in bit
# define BINT_WORD_BITS (sizeof(t_word) * 8)

/** a data structure which represent integer with a custom size */
/** the 'bits' address contains a raw array of 'int' in the device endianness */
typedef struct	s_bint {
	t_word *words; //the raw bits pointer
	size_t size; //size allocated in word at the address 'words'
	size_t wordset; //the last non null bits
	char sign; //the sign
}				t_bint;

/**
**	a data structure which represent a bcd number representation.
**	attribute:
**		- length : number of byte for this bcd
**		- raw_bytes : the raw bcd bytes
*/
typedef struct	s_bcd {
	size_t length;
	unsigned char *raw_bytes;
}				t_bcd;

/** create a new big int on the given size */
t_bint * bint_new(t_word size);
/** delete the given integer */
void bint_delete(t_bint ** dst);

/** ensure that the big integer at address 'dst' has the given size, if not, dst is deleted and a new one is allocated */
t_bint * bint_ensure_size(t_bint ** dst, int size);

/** new */
void bint_set_default_size(size_t size);
size_t bint_get_default_size(void);

/** clone, copy, resize */
t_bint * bint_clone(t_bint * i);
t_bint * bint_resize(t_bint * i, size_t size);

/** output funtions */
void bint_dump(t_bint * i);
t_bcd * bint_to_bcd(t_bint * i);
char * bcd_to_str(t_bcd * bcd);
char * bint_to_str(t_bint * i);
void bcd_dump(t_bcd * bcd);
void bcd_delete(t_bcd ** bcd);

/** log */
# define BINT_LOG_BASE_E (INT_MAX)
double bint_log_lower(t_bint *integer, int base);
double bint_log_upper(t_bint *integer, int base);
double bint_log(t_bint *integer, int base);

/** comparison */
int bint_cmp(t_bint * a, t_bint * b);

/**
**	return 1 if the given number is 0, or return 0 if the number isnt 0.
**	N.B: a 0 bint should always has it 'wordset' set to 0, HOWEVER, if it isnt,
**	     a comparison word by word is done to check is the number is actually 0 or not.
**	     if it is, it 'wordset' is reset to 0.
*/
int bint_is_zero(t_bint *i);

/** copy (unsafe) */
void bint_copy(t_bint * dst, t_bint * i);

/** negate */
t_bint * bint_negate(t_bint * i);
t_bint * bint_negate_dst(t_bint ** dst, t_bint * i);

/** operations, allocate a new integer */
t_bint * bint_add(t_bint * a, t_bint * b);
t_bint * bint_sub(t_bint * a, t_bint * b);
t_bint * bint_mult(t_bint * a, t_bint * b);
t_bint * bint_div(t_bint * a, t_bint * b);
t_bint * bint_mod(t_bint * a, t_bint * b);
t_bint ** bint_divmod(t_bint * a, t_bint * b);

/** operation with a destination pointer address given as argument */
/** arguments are : (dst, a, b) : dst = a OP b */
t_bint * bint_add_dst(t_bint ** dst, t_bint * a, t_bint * b);
t_bint * bint_sub_dst(t_bint ** dst, t_bint * a, t_bint * b);
t_bint * bint_mult_dst(t_bint ** dst, t_bint * a, t_bint * b);
t_bint * bint_div_dst(t_bint ** dst, t_bint * a, t_bint * b);
t_bint * bint_mod_dst(t_bint ** dst, t_bint * a, t_bint * b);
t_bint ** bint_divmod_dst(t_bint *** dst, t_bint * a, t_bint * b);

/** shift functions */
t_bint * bint_shift_left(t_bint * integer, int n);
t_bint * bint_shift_left_dst(t_bint ** dst, t_bint * integer, int n);
t_bint * bint_shift_right(t_bint * integer, int n);
t_bint * bint_shift_right_dst(t_bint ** dst, t_bint * integer, int n);

/** setters */
t_bint *bint_set(t_bint **dst, int i);
t_bint * bint_set_pow2(t_bint **dst, size_t i);

#endif
