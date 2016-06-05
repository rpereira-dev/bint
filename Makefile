NAME = ./bin/fractal 

SRCS = ./srcs/main.cu $(wildcard ./srcs/floatIEE754/*.cu) $(wildcard ./srcs/bint/*.cu) $(wildcard ./srcs/binary_tools/*.cu)
CU_OBJ = $(SRCS:.cu=.o)
LIBDIR = ./lib
CC = nvcc
FLAGS = -arch=sm_20

all: $(NAME)

$(NAME): $(CU_OBJ)
	make -C $(LIBDIR)
	$(CC) -o $(NAME) $(CU_OBJ)

%.o: %.cu
	$(CC) $(FLAGS) -o $@ -c $< -I includes
clean:
	make -C $(LIBDIR) clean
	rm -rf $(CU_OBJ)

fclean: clean
	make -C $(LIBDIR) fclean
	rm -rf $(NAME)

re: fclean all
