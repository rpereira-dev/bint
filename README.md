# bint ANSI C library
A simple but yet powerful C library on big integers. It shouldn't face any portability issue, only std functions are used here. (malloc(), memset(), memcpy() ...)

This library was made for a school (which likely became personal) project.

Ideas of applications are:
  - Collatz conjecture, Lychrel number ...
  - Primary number database creation
  - Compression / Cryptography (assume raw memory as a big integer, and apply mathematics transformation on it)
  - Fractal rendering

Also, notice that this library can easily be ported for GPU (I'm thinking of CUDA particularly). This would allow parallelization which is definetly wanted on some of upper ideas.

## About implementation
If you have any guesses about implementation, I recommend you jumping directly into the code, which I tried to comment at most
