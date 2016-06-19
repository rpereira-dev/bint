#include "fractal.h"

/*
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

		snprintf(buffer, sizeof(buffer), "%d", i);

		if (strcmp(str, buffer) != 0) {
			printf("ERROR OCCURED ON NUMBER %d: have(%s) : exepected(%s)\n", i, str, buffer);
		}

		bcd_delete(&bcd);
		free(str);
	}
}
*/
/*
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
}*/

/**
void testShift(int argc, char **argv) {
	
	int value = atoi(argv[1]);
	int n = atoi(argv[2]);
	size_t capacity = n * 2;

	bint_set_default_size(capacity);
	t_bint * a = bint_set(NULL, value);
	t_bint * r = bint_shift_left(a, n);

	char * str = bint_to_str(r);
	printf("(%d << %d) = %s\n", value, n, str);

	free(str);
	bint_delete(&a);
	bint_delete(&r);
}
*/

void testMult(int argc, char **argv) {
	int avalue = atoi(argv[1]);
	int bvalue = atoi(argv[2]);
	//t_bint * a = bint_set_pow2(NULL, avalue);
	//t_bint * b = bint_set_pow2(NULL, bvalue);
	t_bint * a = bint_set(NULL, avalue);
	t_bint * b = bint_set(NULL, bvalue);
	t_bint * r = bint_mult(a, b);

	//bint_dump(r), puts("");

	char * astr = bint_to_str(a);
	char * bstr = bint_to_str(b);
	char * rstr = bint_to_str(r);
	printf("%s x %s = \n%s\n", astr, bstr, rstr);

}

/**
void testPow2(int argc, char **argv) {


	t_bint *a = bint_set_pow2(NULL, atoi(argv[1]));
	t_bcd * bcd;
	char * str;

	{
		struct timeval stop, start;
		gettimeofday(&start, NULL);

		bcd = bint_to_bcd(a);

		gettimeofday(&stop, NULL);
		size_t lasted = stop.tv_usec - start.tv_usec;
		//printf("bint -> bcd: %lu\n", lasted);
	}


	{
		struct timeval stop, start;
		gettimeofday(&start, NULL);

		str = bcd_to_str(bcd);

		gettimeofday(&stop, NULL);
		size_t lasted = stop.tv_usec - start.tv_usec;
		//printf("bcd -> str: %lu\n", lasted);
	}

	printf("%s\n", str);

	bcd_delete(&bcd);
	free(str);
	bint_delete(&a);
}
*/

/**
void testBigAddition(int argc, char **argv) {
	
	t_bint * n = bint_new(100000);
	
	bint_set(&n, atoi(argv[1]));

	int end = atoi(argv[2]);

	for (int i = 0 ; i < end ; i++) {
		bint_add_dst(&n, n, n);
	}

	puts("add ended");

	//printf("%s\n", bint_to_str(n));

	bint_delete(&n);
}
*/

/*
void testLog(int argc, char **argv) {
	int base = strcmp(argv[1], "e") == 0 ? BINT_LOG_BASE_E : atoi(argv[1]);
	int value = atoi(argv[2]);
	t_bint * integer = bint_set(NULL, value);
	double logvalue = bint_log(integer, base);
	bint_delete(&integer);

	printf("log_%s(%d) = %f\n", argv[1], value, logvalue);
}*/


int main(int argc, char **argv) {
	
	testMult(argc, argv);
	//testDoubleDabble(argc, argv);
	//testAddition(argc, argv);
	//testShift(argc, argv);
	//testPow2(argc, argv);
	//testBigAddition(argc, argv);
	//testLog(argc, argv);
	return (EXIT_SUCCESS);
}





