/* interpreter_playlist.c
 * - Interpreter playlist functions
 * Copyright (c) 2000 Alexander Havang
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

#if defined(HAVE_PYTHON_H) && defined(HAVE_LIBPYTHON)
/* Python.h defines this, compilers complain about multiple definitions */
#undef _REENTRANT
# include "playlist_python.c"
#endif

#if defined(HAVE_LIBPERL)
/* Same thing here, perl redefines this */
# ifdef ANY
#  undef ANY
# endif
# include "playlist_perl.c"
#endif
