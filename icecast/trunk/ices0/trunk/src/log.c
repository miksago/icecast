/* log.c
 * - Functions for logging in ices
 * Copyright (c) 2000 Alexander Hav�ng
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
 */

#include "definitions.h"

char lasterror[BUFSIZE];
FILE *logfile = NULL;

extern ices_config_t ices_config;

/* Private function declarations */
static void ices_log_string (char *format, char *string);
static int ices_log_open_logfile ();
static int ices_log_close_logfile ();

/* Public function definitions */
void
ices_log_initialize ()
{
	if (!ices_log_open_logfile ()) {
		ices_log ("%s", ices_log_get_error ());
	}
}

void
ices_log_shutdown ()
{
	if (!ices_log_close_logfile ()) {
		ices_log ("%s", ices_log_get_error ());
	}
}

int
ices_log_reopen_logfile ()
{
	ices_log_close_logfile ();
	return ices_log_open_logfile ();
}

void
ices_log_debug (const char *fmt, ...)
{
	char buff[BUFSIZE];
	va_list ap;

	if (!ices_config.verbose)
		return;

	va_start(ap, fmt);
#ifdef HAVE_VSNPRINTF
	vsnprintf(buff, BUFSIZE, fmt, ap);
#else
	vsprintf(buff, fmt, ap);
#endif
	va_end(ap);

	ices_log_string ("DEBUG: %s\n", buff);
}

void
ices_log (const char *fmt, ...)
{
	char buff[BUFSIZE];
	va_list ap;

	va_start(ap, fmt);
#ifdef HAVE_VSNPRINTF
	vsnprintf(buff, BUFSIZE, fmt, ap);
#else
	vsprintf(buff, fmt, ap);
#endif
	va_end(ap);

	ices_log_string ("%s\n", buff);
}

void
ices_log_error (const char *fmt, ...)
{
	char buff[BUFSIZE];
	va_list ap;

	va_start(ap, fmt);
#ifdef HAVE_VSNPRINTF
	vsnprintf(buff, BUFSIZE, fmt, ap);
#else
	vsprintf(buff, fmt, ap);
#endif
	va_end(ap);

	strncpy (lasterror, buff, BUFSIZE);
}

char *
ices_log_get_error ()
{
	return lasterror;
}

void
thread_log (char *type, int level, char *fmt, ...)
{
	char buff[BUFSIZE];
	va_list ap;

	if (!ices_config.verbose)
		return;
	
	va_start(ap, fmt);
#ifdef HAVE_VSNPRINTF
	vsnprintf(buff, BUFSIZE, fmt, ap);
#else
	vsprintf(buff, fmt, ap);
#endif
	va_end(ap);

	ices_log_string ("DEBUG: %s\n", buff);
}

/* Private function definitions */
static void
ices_log_string (char *format, char *string)
{
	if (logfile) {
		fprintf (logfile, format, string);
	}
	
	if (!ices_config.daemon) {
		fprintf (stdout, format, string);
	}
}

static int
ices_log_open_logfile ()
{
	char namespace[1024], errorspace[1024];
	char *filename;
	FILE *logfp;

	filename = ices_util_get_random_filename (namespace, "log");
	
	logfp = ices_util_fopen_for_writing (filename);

	if (!logfp) {
		ices_log_error ("Error while opening %s, error: %s", ices_util_strerror (errno, errorspace, 1024));
		return 0;
	}

	logfile = logfp;
	return 1;
}

static int
ices_log_close_logfile ()
{
	if (logfile) {
		ices_util_fclose (logfile);
	}

	return 1;
}



