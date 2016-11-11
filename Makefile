NAME = ./bin/bint 

SRCS = ./srcs/main.c $(wildcard ./srcs/bint/*.c) $(wildcard ./srcs/btools/*.c)
C_OBJ = $(SRCS:.c=.o)
LIBDIR = ./lib
FLAGS = -Wall -Werror -Wextra

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
