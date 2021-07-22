SRCFOLDER = "./get_next_line/"

CC = gcc
CFLAGS = -Wall -Wextra -Werror
SANITIZE = -fsanitize=address
NAME = gnltest.a

SRC =									\
	main.c								\
	${SRCFOLDER}get_next_line.c 		\
	${SRCFOLDER}get_next_line_utils.c 	\
	${SRCFOLDER}get_next_line.h

TESTMANDATORY = $(SRC:.c=.o)

all : $(NAME)

$(NAME): $(TESTMANDATORY)
	ar rs $(NAME) $(TESTMANDATORY)

clean:
	rm -f *.o

fclean: clean
	rm -f ./$(NAME)

re: fclean all

