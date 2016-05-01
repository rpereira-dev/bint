#include "fractal.h"
#include <time.h>

void testBint() {

	int avalue = 42;
	int bvalue = 10;

	t_bint *a = bint_new(10000000);
	t_bint *b = bint_new(10000000);
	t_bint *r = bint_new(10000000);

	bint_set32(a, avalue);
	bint_set32(b, bvalue);

	printf("%10d: ", avalue), bint_dump(a), printf("\n");
	printf("%10d: ", bvalue), bint_dump(b), printf("\n");

	clock_t t = clock();
	r = bint_add_dst(&r, a, b);
	printf("%u\n", clock() - t);
	printf("%10d: ", avalue + bvalue), bint_dump(r), printf("\n");

	free(a);
	free(b);
	free(r);
}

int main(void) {
	
	//testFloatIEE754();
	testBint();

	return (EXIT_SUCCESS);
}
