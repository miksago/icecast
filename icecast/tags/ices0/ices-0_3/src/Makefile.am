## Process this with automake to create Makefile.in

SUBDIRS = playlist

bin_PROGRAMS = ices

noinst_HEADERS = icestypes.h definitions.h setup.h log.h stream.h util.h \
	cue.h metadata.h in_vorbis.h mp3.h id3.h signals.h reencode.h \
	ices_config.h

ices_SOURCES = ices.c log.c setup.c stream.c util.c mp3.c cue.c metadata.c \
	id3.c signals.c

EXTRA_ices_SOURCES = ices_config.c reencode.c in_vorbis.c

ices_LDADD = $(ICES_OBJECTS) playlist/libplaylist.a
ices_DEPENDENCIES = $(ices_LDADD)

AM_CPPFLAGS = -DICES_ETCDIR=\"$(sysconfdir)\" -DICES_MODULEDIR=\"$(moddir)\"
