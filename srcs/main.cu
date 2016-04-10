#include "fractal.h"

void testFloatIEE754() {

	float fa = 1.0f;
	float fb = 12.0f;
	float fc = fa + fb;

	t_float754 *a = float754_new32(fa);
	t_float754 *b = float754_new32(fb);
	t_float754 *c = float754_new32(fc);
	t_float754 *dst = float754_new32(0);

	//float754_add(dst, a, b);
	//float754_dump(c);
	//float754_dump(dst);

	bindump(&fc, 4), puts("");
	float754_dump(c);
}

void testBigInt() {
	t_bigint *a = bigint_new(8);
	t_bigint *b = bigint_new(8);

	bigint_set32(a, -42);
	bigint_set32(b, 42);

	bigint_dump(a);
	bigint_dump(b);
}

int main(void) {
	
	//testFloatIEE754();

	testBigInt();

	return (EXIT_SUCCESS);
}
