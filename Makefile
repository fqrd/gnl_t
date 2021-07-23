SRCDIR = ../

SRCMANDATORY = \
	$(SRCDIR)get_next_line.c \
	$(SRCDIR)get_next_line_utils.c
MANDATORY = $(SRCMANDATORY:.c=.o)

SRCBONUS = \
	$(SRCDIR)get_next_line_bonus.c \
	$(SRCDIR)get_next_line_utils_bonus.c
BONUS = $(SRCBONUS:.c=.o)

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

all: m b

m : $(MANDATORY) $(TEST)
	$(info )
	$(info ********MANDATORY PART***********)
	$(info )
	$(CC) $(CFLAGS) -D BUFFER_SIZE=1 $(SRCMANDATORY) $(SRCTEST)
	$(VALGRIND) ./a.out
	$(clean)
	$(CC) $(CFLAGS) -D BUFFER_SIZE=42 $(SRCMANDATORY) $(SRCTEST)
	$(VALGRIND) ./a.out
	$(clean)
	$(CC) $(CFLAGS) -D BUFFER_SIZE=107 $(SRCMANDATORY) $(SRCTEST)
	$(VALGRIND) ./a.out
	$(clean)

b : $(BONUS) $(TEST) 
	$(info )
	$(info ********BONUS PART***********)
	$(info )
	$(CC) $(CFLAGS) -D BUFFER_SIZE=1 $(SRCBONUS) $(SRCTEST)
	$(VALGRIND) ./a.out
	$(clean)
	$(CC) $(CFLAGS) -D BUFFER_SIZE=42 $(SRCBONUS) $(SRCTEST)
	$(VALGRIND) ./a.out
	$(clean)
	$(CC) $(CFLAGS) -D BUFFER_SIZE=107 $(SRCBONUS) $(SRCTEST)
	$(VALGRIND) ./a.out
	$(clean)


clean:
	rm -f *.o ../*.o ./$(NAME) ./a.out

#re: fclean all