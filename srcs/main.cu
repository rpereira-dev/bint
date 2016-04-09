#include "fractal.h"

int main(void) {
	
	t_float754 *a = float754_new32(42.0f);
	t_float754 *b = float754_new32(24.0f);
	t_float754 *c = float754_new32(42.0f + 24.0f);
	t_float754 *dst = float754_new32(0);

	float754_add(dst, a, b);
	printf("%d\n", float754_cmp(c, dst));

	float754_dump(c);
	float754_dump(dst);

	return (EXIT_SUCCESS);
}
