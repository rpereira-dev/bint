#include "bigint.h"

t_bigint *bigint_new(unsigned int bytes) {

	if (bytes < 4) {
		bytes = 4;
	}

	t_bigint *i = (t_bigint*)malloc(sizeof(t_bigint) + bytes);
	if (i == NULL) {
		return (NULL);
	}
	i->bytes = bytes;
	return (i);
}