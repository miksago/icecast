/* interpreter.h
 * - Interpreter function declarations
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

#ifndef __ICECAST_INTERPRETER_H
# define __ICECAST_INTERPRETER_H

void interpreter_initialize (void);
void interpreter_shutdown (void);
# if defined(HAVE_PYTHON_H) && defined(HAVE_LIBPYTHON)
char *interpreter_playlist_python_get_next (void);
int interpreter_playlist_python_initialize (ices_config_t *ices_config);
int interpreter_playlist_python_shutdown (ices_config_t *ices_config);
int interpreter_playlist_python_get_current_lineno (void);
void *interpreter_python_eval_function (char *functionname);
# endif

# if defined(HAVE_LIBPERL)
char *interpreter_playlist_perl_get_next (void);
int interpreter_playlist_perl_initialize (ices_config_t *ices_config);
int interpreter_playlist_perl_shutdown (ices_config_t *ices_config);
int interpreter_playlist_perl_get_current_lineno (void);
void * interpreter_perl_eval_function (char *functionname);
# endif

#endif

