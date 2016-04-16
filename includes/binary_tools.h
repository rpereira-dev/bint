#ifndef BINARY_TOOLS_H
# define BINARY_TOOLS_H

# include <stdio.h>

#define ENDIANESS ('ABCD' == 0x41424344)
#define BIG_ENDIAN 0
#define LITTLE_ENDIAN 1
#define BITSET(X, n) (X & (1 << n))
#define SETBIT(X, n) (X = X | (1 << n))
#define UNSETBIT(X, n) (X = X | ~(1 << n))

typedef unsigned char t_byte;

/** dump the memory at the given address */
void bdump(void *data, int len);

/** return the endianness of the device */
int endianness(void);

/** swap endianness (assume 4 bytes sizes) */
void btools_swap_endian(void *);

#endif