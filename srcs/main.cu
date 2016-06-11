#include "fractal.h"
#include <time.h>

/*
void testBint(int argc, char **argv) {

	t_bint *a = bint_new(1024);
	int value = atoi(argv[1]);
	bint_set32(a, value);

	t_bcd *bcd = bint_to_bcd(a);
	printf("final bcd is: "), bcd_dump(bcd), printf("\n");

	char *str = bcd_to_str(bcd);
	printf("BCD CONVERTED IS: %s , expected: %d\n", str, value);

	bint_delete(&a);
	bcd_delete(&bcd);
	free(str);
}*/


void testBint(int argc, char **argv) {

	char buffer[64];
	t_bint *a = bint_new(1024);

	int begin = atoi(argv[1]);
	int end = atoi(argv[2]);
	int percent = (end - begin) / 10;
	printf("testing number from %d to %d\n", begin, end);
	for (unsigned int i = begin ; i <= end ; i++) {

		if (i % percent == 0) {
			printf("%f%%\n", ((i - begin) / (float)(end - begin)) * 100);
		}
		bint_set32(a, i);

		t_bcd *bcd = bint_to_bcd(a);
		char *str = bcd_to_str(bcd);

		itoa(i, buffer, 10);

		if (strcmp(str, buffer) != 0) {
			printf("ERROR OCCURED ON NUMBER %d: have(%s) : exepected(%s)\n", i, str, buffer);
		}

		bcd_delete(&bcd);
		free(str);
	}
}


int main(int argc, char **argv) {
	
	//testFloatIEE754();
	testBint(argc, argv);

	return (EXIT_SUCCESS);
}
