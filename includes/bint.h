#ifndef BINT_H
# define BINT_H

# include "binary_tools.h"
# include <stdlib.h>

/** a data structure which represent integer with a custom size */
typedef struct	s_bint {
	unsigned int size;
	char sign;
	char *bits;
}				t_bint;


/** global number */
extern t_bint *bint_zero;
extern t_bint *bint_two;
extern t_bint *bint_eight;
extern t_bint *bint_ten;


/** initialize the library */
int bint_init(void);
int bint_deinit(void);

/** create a new big int on the given size */
t_bint *bint_new(unsigned int size);

/** 8bits version set */
t_bint *bint_new8(char value);

/** new */
t_bint *bint_new64(long int i);
t_bint *bint_new32(int i);
t_bint *bint_new16(short i);
t_bint *bint_new8(char value);

/** clone, resize */
t_bint *bint_clone(t_bint * i);
t_bint *bint_resize(t_bint *i, unsigned int size);

/** debug funtions */
t_bint *bint_dump(t_bint *i);

/** negate */
t_bint *bint_negate(t_bint *i);
void bint_negate_dst(t_bint *dst, t_bint *i);


/*********************************************************/
/** function pointer depending on the device starts here */
/*********************************************************/

/** set functions */
extern void(*bint_set64)(t_bint *, long int );
extern void(*bint_set32)(t_bint *, int );
extern void(*bint_set16)(t_bint *, short );

/** operations, allocate a new integer */
extern t_bint *(*bint_add)(t_bint *a, t_bint *b);
extern t_bint *(*bint_sub)(t_bint *a, t_bint *b);
extern t_bint *(*bint_mult)(t_bint *a, t_bint *b);
extern t_bint *(*bint_div)(t_bint *a, t_bint *b);
extern t_bint *(*bint_mod)(t_bint *a, t_bint *b);
extern t_bint **(*bint_divmod)(t_bint *a, t_bint *b);

/** operation with a destination pointer address given as argument */
/** arguments are : (dst, a, b) : dst = a OP b */
extern void (*bint_add_dst)(t_bint *dst, t_bint *a, t_bint *b);
extern void (*bint_sub_dst)(t_bint *dst, t_bint *a, t_bint *b);
extern void (*bint_mult_dst)(t_bint *dst, t_bint *a, t_bint *b);
extern void (*bint_div_dst)(t_bint *dst, t_bint *a, t_bint *b);
extern void (*bint_mod_dst)(t_bint *dst, t_bint *a, t_bint *b);
extern void (*bint_divmod_dst)(t_bint **dst, t_bint *a, t_bint *b);

/*********************************************************/
/** function pointer depending on the device ends here */
/*********************************************************/

/** no endian issues */
void bint_set8(t_bint *dst, char i);

/** big endian */
void bint_set64_be(t_bint *dst, long int i);
void bint_set32_be(t_bint *dst, int i);
void bint_set16_be(t_bint *dst, short i);

t_bint *bint_add_be(t_bint *a, t_bint *b);
t_bint *bint_sub_be(t_bint *a, t_bint *b);
t_bint *bint_mult_be(t_bint *a, t_bint *b);
t_bint *bint_div_be(t_bint *a, t_bint *b);
t_bint *bint_mod_be(t_bint *a, t_bint *b);
t_bint **bint_divmod_be(t_bint *a, t_bint *b);

void bint_add_dst_be(t_bint *dst, t_bint *a, t_bint *b);
void bint_sub_dst_be(t_bint *dst, t_bint *a, t_bint *b);
void bint_mult_dst_be(t_bint *dst, t_bint *a, t_bint *b);
void bint_div_dst_be(t_bint *dst, t_bint *a, t_bint *b);
void bint_mod_dst_be(t_bint *dst, t_bint *a, t_bint *b);
void bint_divmod_dst_be(t_bint **, t_bint *, t_bint *);
void bint_negate_dst_be(t_bint *, t_bint *);

/** little endian */
void bint_set64_le(t_bint *dst, long int i);
void bint_set32_le(t_bint *dst, int i);
void bint_set16_le(t_bint *dst, short i);

t_bint *bint_add_le(t_bint *a, t_bint *b);
t_bint *bint_sub_le(t_bint *a, t_bint *b);
t_bint *bint_mult_le(t_bint *a, t_bint *b);
t_bint *bint_div_le(t_bint *a, t_bint *b);
t_bint *bint_mod_le(t_bint *a, t_bint *b);
t_bint **bint_divmod_le(t_bint *a, t_bint *b);

void bint_add_dst_le(t_bint *dst, t_bint *a, t_bint *b);
void bint_sub_dst_le(t_bint *dst, t_bint *a, t_bint *b);
void bint_mult_dst_le(t_bint *dst, t_bint *a, t_bint *b);
void bint_div_dst_le(t_bint *dst, t_bint *a, t_bint *b);
void bint_mod_dst_le(t_bint *dst, t_bint *a, t_bint *b);
void bint_divmod_dst_le(t_bint **, t_bint *, t_bint *);
void bint_negate_dst_le(t_bint *, t_bint *);


#endif