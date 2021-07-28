#include "../get_next_line_bonus.h"
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#define TESTS "./tests/"

int main(void)
{
	int fd;
	int i = 0;
	char *line;
	char *tests[] = 
	{
		TESTS "empty",
		TESTS "line_nl",
		TESTS "nl",
		TESTS "no_nl",
		TESTS "only_nl",
		TESTS "long_nl",
		TESTS "long_no_nl",
		NULL
	};

	while (tests[i])
	{
		fd = open(tests[i], O_RDONLY);
		printf("file: %s\n", tests[i]);
		line = get_next_line(fd);
		while (line)
		{
			printf("%s", line);
			free(line);
			line = get_next_line(fd);
		}
		printf("%s", line);
		printf("\n");
		i++;
	}
	return (0);
}
