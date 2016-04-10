#ifndef BIGINT_H
# define BIGINT_H

# include "binary_tools.h"
# include <stdlib.h>

/** a data structure which represent integer with a custom size */
typedef struct	s_bigint {
	unsigned int bytes;
}				t_bigint;

/** create a new big int */
t_bigint *bigint_new(unsigned int bytes);

void bigint_dump(t_bigint *i);

/** set a value */
void bigint_set32(t_bigint *i, int value);

#endif