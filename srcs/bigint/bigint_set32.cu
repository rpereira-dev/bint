#include "bigint.h"

void bigint_set32(t_bigint *i, int value) {

	char *bytes = (char*)(i + 1);

	if (value < 0) {
		memset(bytes, -1, i->bytes - 4);
	}

	value = ensure_int_endianess(value);

	memcpy(bytes + i->bytes - 4, &value, 4);
}