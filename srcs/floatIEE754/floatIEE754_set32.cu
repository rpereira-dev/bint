# include "float754.h"

//this method will not work on float with an exposant > 1 byte, FIX ME!
t_float754 *float754_set32(t_float754 *F, float f) {

	//reset the float
	memset(F + 1, 0, F->sizebyte);

	//check endianess so we always work in little endian
	f = ensure_float_endianess(f);

begin_exposant:

	//get the raw bits without the sign
	char *bytes = (char*)&f;
	int raw = *((int*)bytes) << 1;

	//get the real exposant value
	char exposant = *((char*)&raw) + 127;

	//copy the real exposant value
	char *dst = (char*)(F + 1);
	dst[F->exposantbyte - 1] = exposant;

	//apply offset on the copied exposant value
	//notice that this addition is done by doing it with integer to reduce instructions

	//small offset byte
	char soffbyte = (1 << 7) - 1; //01111111
	//big offset byte
	char boffbyte = -1; //11111111

	//small offset integer, this trick is done to handle different endianness
	int soffint; //01111111 11111111 11111111 11111111
	char *soffintaddr = (char*)&soffint;
	soffintaddr[0] = soffbyte;
	soffintaddr[1] = boffbyte;
	soffintaddr[2] = boffbyte;
	soffintaddr[3] = boffbyte;

	//big offset integer
	int boffint = -1; //11111111 11111111 11111111 11111111

	//iterator
	int i;
	//add integers by integers
	if (F->exposantbyte >= 4) {
		i = F->exposantbyte - 4;
		while (true) {

			//the exposant size is a multiple of 4, nice, we are done
			if (i == 0) {
				int *addr = (int*)(dst + i);
				*addr = *addr - soffint;
				goto end_exposant;
			}

			//we are not done yet, add the 4 byte part
			int *addr = (int*)(dst + i);
			*addr = *addr - boffint;

			//are we done? if so, stop adding them 4 by 4
			if (i < 4) {
				break ;
			}
		}
	} else {
		i = F->exposantbyte - 1;
	}

	//add the remaining byte one by one
	while (i > 0) {

		dst[i] = dst[i] - boffbyte;
		--i;
	}

	//add the final byte
	dst[0] = dst[0] - soffbyte;

end_exposant:

begin_mantissa:
	dst = dst + F->exposantbyte;
	char *mantissa = ((char*)&raw) + 1; //offset of the exposant
	memcpy(dst + F->exposantbyte, mantissa, 3);

	return (F);
}