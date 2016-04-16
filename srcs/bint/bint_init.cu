#include "bint.h"

t_bint * bint_zero;
t_bint * bint_two;
t_bint *bint_eight;
t_bint * bint_ten;

void(*bint_set64)(t_bint *, long int );
void(*bint_set32)(t_bint *, int );
void(*bint_set16)(t_bint *, short );

/** operations, allocate a new integer */
t_bint *(*bint_add)(t_bint *a, t_bint *b);
t_bint *(*bint_sub)(t_bint *a, t_bint *b);
t_bint *(*bint_mult)(t_bint *a, t_bint *b);
t_bint *(*bint_div)(t_bint *a, t_bint *b);
t_bint *(*bint_mod)(t_bint *a, t_bint *b);
t_bint **(*bint_divmod)(t_bint *a, t_bint *b);

/** operation with a destination pointer address given as argument */
/** arguments are : (dst, a, b) : dst = a OP b */
void (*bint_add_dst)(t_bint *dst, t_bint *a, t_bint *b);
void (*bint_sub_dst)(t_bint *dst, t_bint *a, t_bint *b);
void (*bint_mult_dst)(t_bint *dst, t_bint *a, t_bint *b);
void (*bint_div_dst)(t_bint *dst, t_bint *a, t_bint *b);
void (*bint_mod_dst)(t_bint *dst, t_bint *a, t_bint *b);
void (*bint_divmod_dst)(t_bint **dst, t_bint *a, t_bint *b);


int bint_init() {

	int endian = endianness();

	if (endian == BIG_ENDIAN) {
		//big endian function set
		bint_set64 = bint_set64_be;
		bint_set32 = bint_set32_be;
		bint_set16 = bint_set16_be;

		bint_add = bint_add_be;
		bint_sub = bint_sub_be;
		bint_mult = bint_mult_be;
		bint_div = bint_div_be;
		bint_mod = bint_mod_be;
		bint_divmod = bint_divmod_be;

		bint_add_dst = bint_add_dst_be;
		bint_sub_dst = bint_sub_dst_be;
		bint_mult_dst = bint_mult_dst_be;
		bint_div_dst = bint_div_dst_be;
		bint_mod_dst = bint_mod_dst_be;
		bint_divmod_dst = bint_divmod_dst_be;
	} else {
		//little endian function set
		bint_set64 = bint_set64_le;
		bint_set32 = bint_set32_le;
		bint_set16 = bint_set16_le;

		bint_add = bint_add_le;
		bint_sub = bint_sub_le;
		bint_mult = bint_mult_le;
		bint_div = bint_div_le;
		bint_mod = bint_mod_le;
		bint_divmod = bint_divmod_le;

		bint_add_dst = bint_add_dst_le;
		bint_sub_dst = bint_sub_dst_le;
		bint_mult_dst = bint_mult_dst_le;
		bint_div_dst = bint_div_dst_le;
		bint_mod_dst = bint_mod_dst_le;
		bint_divmod_dst = bint_divmod_dst_le;
	}


	//constants
	bint_zero = bint_new32(0);
	bint_two = bint_new32(2);
	bint_eight = bint_new32(8);
	bint_ten = bint_new32(10);

	return (1);
}

int bint_deinit() {
	
	bint_set64 = NULL;
	bint_set32 = NULL;
	bint_set16 = NULL;

	bint_add = NULL;
	bint_sub = NULL;
	bint_mult = NULL;
	bint_div = NULL;
	bint_mod = NULL;
	bint_divmod = NULL;

	bint_add_dst = NULL;
	bint_sub_dst = NULL;
	bint_mult_dst = NULL;
	bint_div_dst = NULL;
	bint_mod_dst = NULL;
	bint_divmod_dst = NULL;

	free(bint_zero);
	free(bint_two);
	free(bint_ten);

	return (1);
}