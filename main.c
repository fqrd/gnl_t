#include "gnl_test.h"

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
		"\0"
	};

	while (tests[i])
	{
		fd = open(tests[i], O_RDONLY);
		while ((line = get_next_line(fd)) != NULL)
		{
			printf("%s", line);
			free(line);
		}
		i++;
	}
	return (0);
}