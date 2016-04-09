NAME = ./bin/fractal 

SRCS = ./srcs/main.cu $(wildcard ./srcs/floatIEE754/*.cu)
CU_OBJ = $(SRCS:.cu=.o)
LIBDIR = ./lib

all: $(NAME)

$(NAME): $(CU_OBJ)
	make -C $(LIBDIR)
	nvcc -o $(NAME) $(CU_OBJ)

%.o: %.cu
	nvcc -arch=sm_20 -o $@ -c $< -I includes
clean:
	make -C $(LIBDIR) clean
	rm -rf $(CU_OBJ)

fclean: clean
	make -C $(LIBDIR) fclean
	rm -rf $(NAME)

re: fclean all
