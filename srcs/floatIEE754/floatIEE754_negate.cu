# include "float754.h"

t_float754 *float754_negate(t_float754 *f) {

	f->sign = -f->sign;

	return (f);
}
