/* signals.h
 * - signal handling/setup
 *
 * $Id: signals.h,v 1.2 2001/09/25 12:04:22 msmith Exp $
 *
 * Copyright (c) 2001 Michael Smith <msmith@labyrinth.net.au>
 *
 * This program is distributed under the terms of the GNU General
 * Public License, version 2. You may use, modify, and redistribute
 * it under the terms of this license. A copy should be included
 * with this source.
 */

#ifndef __SIGNALS_H
#define __SIGNALS_H

#include <signal.h>

extern int move_to_next_input;


void signal_hup_handler(int signum);
void signal_int_handler(int signum);

void signals_setup(void);

#endif


