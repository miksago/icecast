/* example.c: Demonstration of the libshout API. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <shout/shout.h>

int main(int argc, char **argv)
{
    FILE *fptr = stdin;
	shout_t *shout;
	char buff[4096];
	long read, ret, total;

	if (!(shout = shout_new())) {
		printf("Could not allocate shout_t\n");
		return 1;
	}

	if (shout_set_host(shout, "127.0.0.1") != SHOUTERR_SUCCESS) {
		printf("Error setting hostname: %s\n", shout_get_error(shout));
		return 1;
	}
	shout_set_user(shout, "source");
	shout_set_password(shout, "hackem");
	shout_set_port(shout, 8002);
	if (shout_set_password(shout, "hackme") != SHOUTERR_SUCCESS) {
		printf("Error setting password: %s\n", shout_get_error(shout));
		return 1;
	}
	if (shout_set_mount(shout, "/example.ogg") != SHOUTERR_SUCCESS) {
		printf("Error setting mount: %s\n", shout_get_error(shout));
		return 1;
	}
	shout_set_format(shout, SHOUT_FORMAT_OGG);

	if (shout_open(shout) == SHOUTERR_SUCCESS) {
		printf("Connected to server...\n");
		total = 0;
        if (argc > 1)
            fptr = fopen (argv[1], "rb");
		while (1) {
			read = fread(buff, 1, sizeof(buff), fptr);
			total = total + read;

			if (read > 0) {
				ret = shout_send(shout, buff, read);
				if (ret < SHOUTERR_SUCCESS) {
					printf("DEBUG: Send error: %s\n", shout_get_error(shout));
					break;
				}
			} else {
				break;
			}

            printf ("delay is %d ms\n", shout_delay(shout));
			shout_sync(shout);
		}
	} else {
		printf("Error connecting: %s\n", shout_get_error(shout));
	}

	shout_close(shout);
    fclose (fptr);

	return 0;
}
