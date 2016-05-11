#include "bint.h"

void bint_set64(t_bint *dst, long long int i) {

}

void bint_set32(t_bint *dst, int i) {

	//if we are setting a zero
	if (i == 0) {
		dst->sign = 0;
		return ;
	}

	//set the sign
	if (i < 0) {
		dst->sign = -1;
		i = -i;
	} else {
		dst->sign = 1;
	}

	//set other bits to 0
	memset(dst->words, 0, (dst->size - 1) * sizeof(int));
	
	//set the value
	int *addr = (int*)(dst->words + dst->size - 1);
	*addr = i;
	dst->last_word_set = dst->words + dst->size - 1;
}

void bint_set16(t_bint *dst, short i) {
	
}

void bint_set8(t_bint *dst, char i) {

}
