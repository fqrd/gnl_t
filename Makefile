SRCDIR = ../

SRCMANDATORY = \
	$(SRCDIR)get_next_line.c \
	$(SRCDIR)get_next_line_utils.c
MANDATORY = $(SRCMANDATORY:.c=.o)

SRCBONUS = get_next_line_bonus.c get_next_line_utils_bonus.c
BONUS = $(SRCBONUS:$(SRCDIR)/%.c=./%.o)

SRCTEST = main.c
TEST = $(SRCTEST:.c=.o)

CC = gcc
CFLAGS = -Wall -Wextra -Werror
VALGRIND = valgrind -s --leak-check=yes
NAME = gnlt.a

#MANDATORYTEST : $(MANDATORY) $(TEST)
#	ar rs $(NAME) $(MANDATORY) $(TEST)

# e : $(NAME)

# CREATE: $(TEST) $(MANDATORY)
# 	ar rs $(NAME) $(TEST) $(MANDATORY)

e : $(MANDATORY) $(TEST) 
#	ar rs $(NAME) $(MANDATORY) $(TEST)
	$(CC) $(CFLAGS) -D BUFFER_SIZE=12 $(SRCMANDATORY) $(SRCTEST)
	$(VALGRIND) ./a.out


clean:
	rm -f *.o ../*.o ./$(NAME) ./a.out

#re: fclean all