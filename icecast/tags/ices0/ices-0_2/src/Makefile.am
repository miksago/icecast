## Process this with automake to create Makefile.in

AUTOMAKE_OPTIONS = foreign

SUBDIRS = playlist

if NEED_SHOUT
SHOUT_LIBS = ../libshout/libices.la
SHOUT_INCLUDES = -I$(top_srcdir)/libshout
endif

bin_PROGRAMS = ices

noinst_HEADERS = icestypes.h definitions.h setup.h log.h stream.h util.h \
	cue.h metadata.h in_vorbis.h mp3.h id3.h signals.h reencode.h \
	ices_config.h

ices_SOURCES = ices.c log.c setup.c stream.c util.c mp3.c cue.c metadata.c \
	id3.c signals.c

EXTRA_ices_SOURCES = ices_config.c in_vorbis.c reencode.c

ices_LDADD = @ICES_OBJECTS@ playlist/libplaylist.a \
	../resolver/libresolver.a ../thread/libicethread.a \
	../avl/libiceavl.a ../log/libicelog.a $(SHOUT_LIBS)

ices_DEPENDENCIES = @ICES_OBJECTS@

INCLUDES = -DICES_ETCDIR=\"$(sysconfdir)\" \
	-I$(top_srcdir)/resolver -I$(top_srcdir)/thread $(SHOUT_INCLUDES)

