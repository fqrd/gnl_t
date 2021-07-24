SRCDIR = ../

# SRC_MANDATORY_HEADER = $(SRCDIR)get_next_line.h
SRCMANDATORY = \
	$(SRCDIR)get_next_line.c \
	$(SRCDIR)get_next_line_utils.c
MANDATORY = $(SRCMANDATORY:$(SRCDIR)%.c=$(SRCDIR)%.o)

# SRC_BONUS_HEADER = $(SRCDIR)get_next_line_bonus.h
SRCBONUS = \
	$(SRCDIR)get_next_line_bonus.c \
	$(SRCDIR)get_next_line_utils_bonus.c
BONUS = $(SRCBONUS:.c=.o)

SRC_TESTS_MANDADORY = mandatory.c
TESTS = $(SRC_TESTS_MANDADORY:%.c=%.o)

SRC_TESTS_BONUS = bonus.c
TESTS_BONUS = $(SRC_TESTS_BONUS:.c=.o)

CC = gcc
CFLAGS = -Wall -Wextra -Werror
VALGRIND = valgrind -q -s --leak-check=yes
FSANITIZE = -fsanitize=address

l: lm lb clean

m: mm mb clean

lm :
	$(info )
	$(info ********MANDATORY PART***********)
	$(info )
	@gcc -D BUFFER_SIZE=1 $(CFLAGS) -c $(SRCMANDATORY) $(SRC_TESTS_MANDADORY)
	@gcc ./*o -o output && $(VALGRIND) ./output
	@gcc -D BUFFER_SIZE=42 $(CFLAGS) -c $(SRCMANDATORY) $(SRC_TESTS_MANDADORY)
	@gcc ./*o -o output && $(VALGRIND) ./output
	@gcc -D BUFFER_SIZE=107 $(CFLAGS) -c $(SRCMANDATORY) $(SRC_TESTS_MANDADORY)
	@gcc ./*o -o output && $(VALGRIND) ./output

lb : $(BONUS) $(TEST_BONUS)
	$(info )
	$(info ********BONUS PART***********)
	$(info )
	@gcc -D BUFFER_SIZE=1 $(CFLAGS) -c $(SRCBONUS) $(SRC_TESTS_BONUS)
	@gcc ./*o -o output && $(VALGRIND) ./output
	@gcc -D BUFFER_SIZE=42 $(CFLAGS) -c $(SRCBONUS) $(SRC_TESTS_BONUS)
	@gcc ./*o -o output && $(VALGRIND) ./output
	@gcc -D BUFFER_SIZE=107 $(CFLAGS) -c $(SRCBONUS) $(SRC_TESTS_BONUS)
	@gcc ./*o -o output && $(VALGRIND) ./output

mm :
	$(info )
	$(info ********MANDATORY PART***********)
	$(info )
	@gcc -D BUFFER_SIZE=1 $(CFLAGS) -c $(SRCMANDATORY) $(SRC_TESTS_MANDADORY)
	@gcc ./*o -o output && $(FSANITIZE) ./output
	@gcc -D BUFFER_SIZE=42 $(CFLAGS) -c $(SRCMANDATORY) $(SRC_TESTS_MANDADORY)
	@gcc ./*o -o output && $(FSANITIZE) ./output
	@gcc -D BUFFER_SIZE=107 $(CFLAGS) -c $(SRCMANDATORY) $(SRC_TESTS_MANDADORY)
	@gcc ./*o -o output && $(FSANITIZE) ./output

mb : $(BONUS) $(TEST_BONUS)
	$(info )
	$(info ********BONUS PART***********)
	$(info )
	@gcc -D BUFFER_SIZE=1 $(CFLAGS) -c $(SRCBONUS) $(SRC_TESTS_BONUS)
	@gcc ./*o -o output && $(FSANITIZE) ./output
	@gcc -D BUFFER_SIZE=42 $(CFLAGS) -c $(SRCBONUS) $(SRC_TESTS_BONUS)
	@gcc ./*o -o output && $(FSANITIZE) ./output
	@gcc -D BUFFER_SIZE=107 $(CFLAGS) -c $(SRCBONUS) $(SRC_TESTS_BONUS)
	@gcc ./*o -o output && $(FSANITIZE) ./output


clean:
	$(info )
	$(info ********CLEARING***********)
	$(info )
	rm -f *.o ./a.out $(SRCDIR)*.o
