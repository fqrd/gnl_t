SRCDIR = ../

SRCMANDATORY = \
	$(SRCDIR)get_next_line.c \
	$(SRCDIR)get_next_line_utils.c

SRCBONUS = \
	$(SRCDIR)get_next_line_bonus.c \
	$(SRCDIR)get_next_line_utils_bonus.c

SRC_TESTS_MANDADORY = mandatory.c
SRC_TESTS_BONUS = bonus.c

CC = gcc
CFLAGS = -Wall -Wextra -Werror
VALGRIND = valgrind -q -s --leak-check=yes
FSANITIZE = -fsanitize=address

l: lm lb
m: mm mb

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
	$(info )
	rm -f *.o ./output $(SRCDIR)*.o

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
	$(info )
	rm -f *.o ./output $(SRCDIR)*.o

mm :
	$(info )
	$(info ********MANDATORY PART***********)
	$(info )
	@gcc -D BUFFER_SIZE=1 $(CFLAGS) -c $(SRCMANDATORY) $(SRC_TESTS_MANDADORY)
	@gcc $(FSANITIZE) ./*o -o output && ./output
	@gcc -D BUFFER_SIZE=42 $(CFLAGS) -c $(SRCMANDATORY) $(SRC_TESTS_MANDADORY)
	@gcc $(FSANITIZE) ./*o -o output && ./output
	@gcc -D BUFFER_SIZE=107 $(CFLAGS) -c $(SRCMANDATORY) $(SRC_TESTS_MANDADORY)
	@gcc $(FSANITIZE) ./*o -o output && ./output
	$(info )
	rm -f *.o ./output $(SRCDIR)*.o

mb : $(BONUS) $(TEST_BONUS)
	$(info )
	$(info ********BONUS PART***********)
	$(info )
	@gcc -D BUFFER_SIZE=1 $(CFLAGS) -c $(SRCBONUS) $(SRC_TESTS_BONUS)
	@gcc $(FSANITIZE) ./*o -o output && ./output
	@gcc -D BUFFER_SIZE=42 $(CFLAGS) -c $(SRCBONUS) $(SRC_TESTS_BONUS)
	@gcc $(FSANITIZE) ./*o -o output && ./output
	@gcc -D BUFFER_SIZE=107 $(CFLAGS) -c $(SRCBONUS) $(SRC_TESTS_BONUS)
	@gcc $(FSANITIZE) ./*o -o output && ./output
	$(info )
	rm -f *.o ./output $(SRCDIR)*.o

clean:
	$(info )
	$(info ********CLEARING***********)
	$(info )
	rm -f *.o ./output $(SRCDIR)*.o
