/* signals.c
 * - Functions for signal handling in ices
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

#ifdef HAVE_SYS_WAIT_H
#include <sys/wait.h>
#endif

#ifdef HAVE_SYS_TYPES_H
#include <sys/types.h>
#endif

#ifdef HAVE_SIGNAL_H
#include <signal.h>
#endif

#ifdef HAVE_SYS_SIGNAL_H
#include <sys/signal.h>
#endif

/* Private function declarations */
static RETSIGTYPE ices_signals_child (const int sig);
static RETSIGTYPE ices_signals_int (const int sig);
static RETSIGTYPE ices_signals_hup (const int sig);

/* Global function definitions */

/* Setup signal handlers for some signals that we don't want
 * delivered to icecast, and some that we want to handle in
 * a certain way, like SIGINT to cleanup and exit, and hup
 * to close and reopen logfiles */
void
ices_signals_setup (void)
{
#ifndef _WIN32
	signal (SIGPIPE, SIG_IGN);
	signal (SIGCHLD, ices_signals_child);
	signal (SIGIO, SIG_IGN);
	signal (SIGALRM, SIG_IGN);
	signal (SIGINT, ices_signals_int);
	signal (SIGHUP, ices_signals_hup);
}

/* SIGINT, ok, let's be nice and just drop dead */
static RETSIGTYPE
ices_signals_int (const int sig)
{
	ices_log_debug ("Caught SIGINT, closing down...");
	ices_setup_shutdown ();
}
			
/* Guess we fork()ed, let's take care of the dead process */
static RETSIGTYPE
ices_signals_child (const int sig)
{
	pid_t pid;
	int stat;

	ices_signals_setup ();
	pid = wait (&stat);
}

/* SIGHUP caught, let's cycle logfiles */
static RETSIGTYPE
ices_signals_hup (const int sig)
{
	ices_log_debug ("Caught SIGHUP, cycling logfiles...");
	ices_log_reopen_logfile ();
}

#endif
