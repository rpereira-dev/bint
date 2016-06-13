#include "bint.h"

#define _BINT_DEFAULT_SIZE (1024)

size_t _default_size = _BINT_DEFAULT_SIZE;

void bint_set_default_size(size_t size) {
	_default_size = size;
}

size_t bint_get_default_size(void) {
	return (_default_size);
}

void bint_reset_default_size(void) {
	_default_size = _BINT_DEFAULT_SIZE;
}