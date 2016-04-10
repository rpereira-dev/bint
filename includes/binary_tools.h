#ifndef BINARY_TOOLS_H
# define BINARY_TOOLS_H

# include <stdio.h>

void bindump(void *data, int len);

float ensure_float_endianess(float f);
	
int ensure_int_endianess(int i);

#endif