## Process this with automake to create Makefile.in

AUTOMAKE_OPTIONS = foreign

if NEED_SHOUT
SHOUT_INCLUDES = -I$(top_srcdir)/libshout
endif

INCLUDES = -DICES_MODULEDIR=\"$(moddir)\" \
	-I$(top_srcdir)/src $(SHOUT_INCLUDES)

noinst_LIBRARIES = libplaylist.a
noinst_HEADERS = playlist.h pm_builtin.h rand.h

libplaylist_a_SOURCES = playlist.c pm_builtin.c rand.c

libplaylist_a_LIBADD = @PLAYLIST_OBJECTS@

libplaylist_a_DEPENDENCIES = @PLAYLIST_OBJECTS@

EXTRA_DIST = pm_perl.c pm_python.c
