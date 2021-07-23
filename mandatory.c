# include <fcntl.h>
# include <stdio.h>
# include <stdlib.h>
# define TESTS "./tests/"

#include "../get_next_line.h"

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
		'\0'
	};

	while (tests[i])
	{
		fd = open(tests[i], O_RDONLY);
		printf("file: %s\n", tests[i]);
		line = get_next_line(fd);
		while (line)
		{
			// printf("%s", line);
			free(line);
			line = get_next_line(fd);
		}
		i++;
	}
	return (0);
}