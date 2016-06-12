#include "fractal.h"
#include <time.h>

void testDoubleDabble(int argc, char **argv) {

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
		bint_set(&a, i);

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

void testAddition(int argc, char **argv) {
	int avalue = atoi(argv[1]);
	int bvalue = atoi(argv[2]);
	t_bint * a = bint_set(NULL, avalue);
	t_bint * b = bint_set(NULL, bvalue);
	t_bint * r = bint_add(a, b);

	char * str = bint_to_str(r);
	printf("%d + %d = %s (expected %d)\n", avalue, bvalue, str, avalue + bvalue);


	free(str);
	bint_delete(&a);
	bint_delete(&b);
	bint_delete(&r);
}

void testShift(int argc, char **argv) {
	
	int value = atoi(argv[1]);
	int n = atoi(argv[2]);
	size_t capacity = n * 2;

	bint_set_default_size(capacity);
	t_bint * a = bint_set(NULL, value);
	t_bint * r = bint_shift_left(a, n);

	char * str = bint_to_str(r);
	printf("(%d << %d) = %s\n", value, n, str);

	while(1);
	free(str);
	bint_delete(&a);
	bint_delete(&r);
}


int main(int argc, char **argv) {
	
	//testDoubleDabble(argc, argv);
	//testAddition(argc, argv);
	testShift(argc, argv);

	return (EXIT_SUCCESS);
}
