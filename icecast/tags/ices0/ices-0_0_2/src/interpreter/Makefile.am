## Process this with automake to create Makefile.in

AUTOMAKE_OPTIONS = foreign

noinst_LIBRARIES = libinterpreter.a
noinst_HEADERS = interpreter.h

libinterpreter_a_SOURCES = interpreter.c interpreter_playlist.c

INCLUDES = -I$(top_srcdir)/src -I$(top_srcdir)/resolver \
	-I$(top_srcdir)/thread -I$(top_srcdir)/libshout

EXTRA_DIST = playlist_python.c python.c playlist_perl.c perl.c
