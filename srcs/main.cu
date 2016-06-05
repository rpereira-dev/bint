#include "fractal.h"
#include <time.h>

void testBint(int argc, char **argv) {

	t_bint *a = bint_new(1024);
	int value = atoi(argv[1]);
	bint_set32(a, value);

	char *bcd = bint_to_bcd(a);
	printf("final bcd is: "), bdump(bcd, strchr(bcd, 0xFF) - bcd), printf("\n");

	char *str = bcd_to_str(bcd);
	printf("BCD CONVERTED IS: %s , expected: %d\n", str, value);

	bint_delete(&a);
	free(bcd);
	free(str);
}

int main(int argc, char **argv) {
	
	//testFloatIEE754();
	testBint(argc, argv);

	return (EXIT_SUCCESS);
}
