#ifndef BINT_H
# define BINT_H

# include "btools.h"
# include <stdlib.h>

//we define zero != NULL so we can know whether a function returns a memory error (NULL) or actually zero (BINT_ZERO)
# define BINT_ZERO ((t_bint*)1)

/** a data structure which represent integer with a custom size */
/** the 'bits' address contains a raw array of 'int' in the device endianness */
typedef struct	s_bint {
	unsigned int *words; //the raw bits pointer
	unsigned int size; //size allocated in word at the address 'words'
	unsigned int *last_word_set; //the last non null bits
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
t_bint * bint_new(unsigned int size);
/** delete the given integer */
void bint_delete(t_bint ** dst);

/** ensure that the big integer at address 'dst' has the given size, if not, dst is deleted and a new one is allocated */
t_bint * bint_ensure_size(t_bint ** dst, int size);

/** new */
t_bint * bint_new64(long int i);
t_bint * bint_new32(int i);
t_bint * bint_new16(short i);
t_bint * bint_new8(char value);

/** clone, copy, resize */
t_bint * bint_clone(t_bint * i);
t_bint * bint_resize(t_bint * i, unsigned int size);

/** output funtions */
void bint_dump(t_bint * i);
t_bcd * bint_to_bcd(t_bint * i);
char * bcd_to_str(t_bcd * bcd);
void bcd_dump(t_bcd * bcd);
void bcd_delete(t_bcd **bcd);

/** comparison */
int bint_is_zero(t_bint *i);
int bint_cmp(t_bint * a, t_bint * b);

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
t_bint * bint_shift_left(t_bint * i, int n);
t_bint * bint_shift_left_dst(t_bint ** dst, t_bint * i, int n);
t_bint * bint_shift_right(t_bint * i, int n);
t_bint * bint_shift_right_dst(t_bint ** dst, t_bint * i, int n);

/** setters */
void bint_set64(t_bint * dst, long long int i);
void bint_set32(t_bint * dst, int i);
void bint_set16(t_bint * dst, short i);
void bint_set8(t_bint * dst, char i);

#endif