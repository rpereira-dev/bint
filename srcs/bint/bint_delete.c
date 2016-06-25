#include "bint.h"

void bint_delete(t_bint **dst) {
	if (dst == NULL || *dst == NULL || *dst == BINT_ZERO) {
		return ;
	}
	free(*dst);
	//*dst = NULL;
}