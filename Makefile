NAME = ./bin/fractal 

SRCS = ./srcs/main.c $(wildcard ./srcs/floatIEE754/*.c) $(wildcard ./srcs/bint/*.c) $(wildcard ./srcs/binary_tools/*.c)
C_OBJ = $(SRCS:.c=.o)
LIBDIR = ./lib
CC = gcc
FLAGS = -Ofast

all: $(NAME)

$(NAME): $(C_OBJ)
	make -C $(LIBDIR)
	$(CC) -o $(NAME) $(C_OBJ)

%.o: %.c
	$(CC) $(FLAGS) -o $@ -c $< -I includes
clean:
	make -C $(LIBDIR) clean
	rm -rf $(C_OBJ)

fclean: clean
	make -C $(LIBDIR) fclean
	rm -rf $(NAME)

re: fclean all
