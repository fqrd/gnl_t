SRCDIR = ../

SRCMANDATORY = \
	$(SRCDIR)get_next_line.c \
	$(SRCDIR)get_next_line_utils.c
MANDATORY = $(SRCMANDATORY:.c=.o)

SRCBONUS = \
	$(SRCDIR)get_next_line_bonus.c \
	$(SRCDIR)get_next_line_utils_bonus.c
BONUS = $(SRCBONUS:.c=.o)

SRC_TEST_MANDADORY = mandatory.c
TEST_MANDADORY = $(SRC_TEST_MANDADORY:.c=.o)

SRC_TEST_BONUS = bonus.c
TEST_BONUS = $(SRC_TEST_BONUS:.c=.o)

CC = gcc
CFLAGS = -Wall -Wextra -Werror
VALGRIND = valgrind -q -s --leak-check=yes
QSANITIZE = -fsanitize=address

l: lm lb clean

m: mm mb clean

lm : $(MANDATORY) $(TEST_MANDADORY)
	$(info )
	$(info ********MANDATORY PART***********)
	$(info )
	$(CC) $(CFLAGS) -D BUFFER_SIZE=1 $(SRCMANDATORY) $(SRC_TEST_MANDADORY)
	$(VALGRIND) ./a.out
	$(CC) $(CFLAGS) -D BUFFER_SIZE=42 $(SRCMANDATORY) $(SRC_TEST_MANDADORY)
	$(VALGRIND) ./a.out
	$(CC) $(CFLAGS) -D BUFFER_SIZE=107 $(SRCMANDATORY) $(SRC_TEST_MANDADORY)
	$(VALGRIND) ./a.out

lb : $(BONUS) $(TEST_BONUS)
	$(info )
	$(info ********BONUS PART***********)
	$(info )
	$(CC) $(CFLAGS) -D BUFFER_SIZE=1 $(SRCBONUS) $(SRC_TEST_BONUS)
	$(VALGRIND) ./a.out
	$(CC) $(CFLAGS) -D BUFFER_SIZE=42 $(SRCBONUS) $(SRC_TEST_BONUS)
	$(VALGRIND) ./a.out
	$(CC) $(CFLAGS) -D BUFFER_SIZE=107 $(SRCBONUS) $(SRC_TEST_BONUS)
	$(VALGRIND) ./a.out

mm : $(MANDATORY) $(TEST_MANDADORY)
	$(info )
	$(info ********MANDATORY PART***********)
	$(info )
	$(CC) $(CFLAGS) -D BUFFER_SIZE=1  $(QSANITIZE) $(SRCMANDATORY) $(SRC_TEST_MANDADORY)
	./a.out
	$(CC) $(CFLAGS) -D BUFFER_SIZE=42  $(QSANITIZE) $(SRCMANDATORY) $(SRC_TEST_MANDADORY)
	./a.out
	$(CC) $(CFLAGS) -D BUFFER_SIZE=107 $(QSANITIZE) $(SRCMANDATORY) $(SRC_TEST_MANDADORY)
	./a.out

mb : $(BONUS) $(TEST_BONUS)
	$(info )
	$(info ********BONUS PART***********)
	$(info )
	$(CC) $(CFLAGS) -D BUFFER_SIZE=1 $(QSANITIZE) $(SRCBONUS) $(SRC_TEST_BONUS)
	./a.out
	$(CC) $(CFLAGS) -D BUFFER_SIZE=42 $(QSANITIZE) $(SRCBONUS) $(SRC_TEST_BONUS)
	./a.out
	$(CC) $(CFLAGS) -D BUFFER_SIZE=107 $(QSANITIZE) $(SRCBONUS) $(SRC_TEST_BONUS)
	./a.out


clean:
	$(info )
	$(info ********CLEARING***********)
	$(info )
	rm -f *.o ./a.out $(SRCDIR)*.o
