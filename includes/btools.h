#ifndef BINARY_TOOLS_H
# define BINARY_TOOLS_H

# include <stdio.h>

# define ENDIANESS ('ABCD' == 0x41424344)
# define BTOOLS_BIG_ENDIAN 0
# define BTOOLS_LITTLE_ENDIAN 1

typedef unsigned char t_byte;

/** dump the memory at the given address */
void bdump(void *data, int len);

/** return the endianness of the device */
int endianness(void);

/** swap endianness (assume 4 bytes sizes) */
void btools_swap_32(void *addr);

#endif