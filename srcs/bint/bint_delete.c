#include "bint.h"

void bint_delete(t_bint **dst) {
	if (dst == NULL || *dst == NULL) {
		return ;
	}
	free(*dst);
	*dst = NULL;
}