#include "fractal.h"

void testBint() {

	bint_init();

	int avalue = -8;
	int bvalue = 5;

	t_bint *a = bint_new(12);
	t_bint *b = bint_new(12);
	t_bint *r = NULL;

	//bint_set32(a, avalue);
	//bint_set32(b, bvalue);

	//printf("%10d: ", avalue), bint_dump(a);
	//printf("%10d: ", bvalue), bint_dump(b);

	//r = bint_add(a, b);
	//printf("%10d: ", avalue + bvalue), bint_dump(r);
}

int main(void) {
	
	//testFloatIEE754();
	testBint();

	return (EXIT_SUCCESS);
}
