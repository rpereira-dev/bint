#include "bint.h"

/** a function which shift left the 'len' byte at addr 'addr' */
static void bcd_shift_left_once(unsigned char *addr, size_t len) {
	unsigned char *ptr = addr + len - 1;
	unsigned char *end = addr;
	unsigned char reminder = 0;
	while (ptr >= end) {

		//check overflow (if last bit is set, then it will overflow)
		unsigned char next_reminder = *ptr & (1 << 7);

		//operate the shift
		*ptr = *ptr << 1;

		//if there was a previous overflow, set the first bit
		if (reminder) {
			*ptr = *ptr | 1;
		}
		reminder = next_reminder;
		--ptr;
	}
}

/** interpret the given address has an integer 32 bits array, and swap the endian of each integer */
void bint_bcd_swap_endian(void *addr, unsigned int nword) {
	unsigned int *words = (unsigned int*)addr;
	int i;

	for (i = 0 ; i < nword ; i++) {
		unsigned int n = words[i];
		words[i] = ((n >> 24) & 0xff) | ((n << 8) & 0xff0000) | ((n >> 8) & 0xff00) | ((n << 24) & 0xff000000);
	}
}

/** implementation based on this document: http://www.tkt.cs.tut.fi/kurssit/1426/S12/Ex/ex4/Binary2BCD.pdf */
char *bint_to_bcd(t_bint *i) {

	//double dabble implementation

	//if zero, return NULL
	if (i == BINT_ZERO || i->sign == 0) {
		return (strdup(""));
	}

	//calculate the integer total size
	size_t wordset = i->words + i->size - i->last_word_set;
	size_t byteset = wordset * sizeof(unsigned int);

	//else calculate the bit sizes
	size_t bitset = byteset * 8;

	//total number of bits for the bcd storage
	size_t nbits_bcd = bitset + 4 * bitset / 3;
	size_t nbytes_bcd = nbits_bcd / 8 + (nbits_bcd % 8 != 0);
	if (nbytes_bcd % sizeof(int) != 0) {
		 nbytes_bcd += (sizeof(int) - nbytes_bcd % sizeof(int));
	}

	//alocate bcd storage
	unsigned char *bcd = (unsigned char*)malloc(nbytes_bcd);
	if (bcd == NULL) {
		return (NULL);
	}

	//prepare the bcd pointer
	memcpy(bcd + nbytes_bcd - byteset, i->last_word_set, byteset);
	memset(bcd, 0, nbytes_bcd - byteset);

	//printf("bcd after copy: ", 0), bdump(bcd, nbytes_bcd), printf("\n");

	//swap the endian so we always work in little endian
	if (endianness() == BIG_ENDIAN) {
		bint_bcd_swap_endian(bcd + nbytes_bcd - byteset, wordset);
	}

	//printf("bcd endian fix: ", 0), bdump(bcd, nbytes_bcd), printf("\n");

	//shift so last set bit is right before first column
	unsigned char *bcd_begin = bcd + nbytes_bcd - byteset;
	//the address of the first bit set
	size_t bits_begin = 0;
	//the address of the last bit set
	size_t bits_end = 0;
	while (!(*bcd_begin & (1 << 7))) {

		//do the shift
		bcd_shift_left_once(bcd_begin, byteset);
		++bits_end;
	}

	//the address of the last bit set
	bits_end = bitset - bits_end;

	//total number of bits to shift
	size_t nbits = bits_end - bits_begin;

	// bits counter in column
	size_t bits = 0;

	//number of column set
	size_t bytes_in_column = 0;

	//printf("bcd initial   : ", bits), bdump(bcd, nbytes_bcd), printf("\n");

	//for each bits
	while (true) {

		//total number of byte hold by the bcd pointer (+ 1 so we handle overflow on shifting)
		size_t bytes_to_shift = byteset + bytes_in_column + 1;
		//where the shift should end
		unsigned char *endshift = bcd + nbytes_bcd - bytes_to_shift;
		//do the shift
		bcd_shift_left_once(endshift, bytes_to_shift);

		//increment number of bits in column
		++bits;
		if (*(bcd + nbytes_bcd - byteset - bytes_in_column - 1)) {
			++bytes_in_column;
		}

		//printf("bcd shift %4d: ", bits), bdump(bcd, nbytes_bcd), printf("\n");

		if (bits >= nbits) {
			break ;
		}


		//for each bcd byte column set
		int i;
		for (i = 0; i < bytes_in_column; i++) {
			//get the byte
			unsigned char *byteaddr = bcd + nbytes_bcd - byteset - 1 - i;

			//columns (4bits of the byte) can be : 0000 / 0001 / 0010 / 0011 / 1000 / 0101 / 0110 / 0111....
			char col;

			//get the first column
			col = *byteaddr & 0xF;

			//if first column >= 5
			if (col >= 5) {
				unsigned char *add_addr = byteaddr;
				unsigned char to_add = 3;

				while (to_add != 0) {
					unsigned char can_hold = 255 - *add_addr;
					if (can_hold > 3) {
						can_hold = 3;
					}
					to_add -= can_hold;
					*add_addr += can_hold;
					--add_addr;
				}
				//printf("bcd +3(1) %4d: ", bits), bdump(bcd, nbytes_bcd), printf("\n");
			}

			//get the second column
			col = (*byteaddr & 0xF0) >> 4;

			//if the second column >= 5
			if (col >= 5) {
				if (col <= 12) {
					//printf("bcd +3(2) %4d: ", bits), bdump(bcd, nbytes_bcd), printf("\n");
					*byteaddr = (*byteaddr & 0xF) | ((col + 3) << 4);
					//printf("bcd +3(2) %4d: ", bits), bdump(bcd, nbytes_bcd), printf("\n");
				} else {
					puts("warning: bcd algorythm error (2nd 4 bytes > 12)");
				}
			}
		}
	}


	//reallocate a memory space to hold the final bcd number
	char *bcd_final = (char*)malloc(bytes_in_column + 1);
	if (bcd_final == NULL) {
		free(bcd);
		return (NULL);
	}

	//copy the data
	memcpy(bcd_final, bcd_begin - bytes_in_column, bytes_in_column);
	//last char
	bcd_final[bytes_in_column] = 0xFF;
	//printf("%d\n", bytes_in_column);

	free(bcd);
	return (bcd_final);
}

static char bcd_char_to_decimal(char c) {

	c = c + '0';
	return ((c >= '0' && c <= '9') ? c : '?');
}

/** convert the bcd number to a decimal string */
char *bcd_to_str(char *bcd) {
	if (bcd == NULL) {
		return (NULL);
	}
	//find end of the bcd string
	char *end = strchr(bcd, 0xFF);
	if (end == NULL) {
		return (NULL);
	}
	//allocate the new string
	size_t bcdlength = end - bcd;
	size_t strlength = bcdlength * 2;
	char *str = (char*)malloc(sizeof(char) * (strlength + 1));
	if (str == NULL) {
		return (NULL);
	}
	//null terminate the string
	str[strlength] = 0;

	//handle first two char (so there is no '0' heading the number)
	size_t i = 0;
	size_t j = 0;

	while (i < bcdlength) {
		
		//get bcd chars
		char c1 = ((bcd[i] & 0xF0) >> 4);
		char c2 = (bcd[i] & 0xF);

		//add the char
		str[j++] = bcd_char_to_decimal(c1);
		str[j++] = bcd_char_to_decimal(c2);
		++i;
	}

	return (str);
}