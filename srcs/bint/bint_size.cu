#include "bint.h"

#define _BINT_DEFAULT_SIZE (sizeof(int) * 1024)

unsigned int _default_size = _BINT_DEFAULT_SIZE;

void bint_set_default_size(unsigned int size) {
	_default_size = size;
}

unsigned int bint_get_default_size(void) {
	return (_default_size);
}

void bint_reset_default_size(void) {
	_default_size = _BINT_DEFAULT_SIZE;
}