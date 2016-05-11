#include "bint.h"

t_bint *bint_ensure_size(t_bint **dst, int size) {

	//the return value
	t_bint *r;

	//if dst is NULL
	if (dst == NULL) {
		//create a new integer
		r = bint_new(size);
	} else if ((*dst) == NULL) {
		//allocate the return value
		r = bint_new(size);
		//set the return value to dst
		*dst = r;
	} else if ((*dst)->size < size) {
		//delete it
		bint_delete(dst);
		//allocate the return value
		r = bint_new(size);
		//set the return value to dst
		*dst = r;
	} else {
		r = *dst;
	}
	return (r);
}
