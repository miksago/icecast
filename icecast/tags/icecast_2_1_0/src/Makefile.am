## Process this with automake to create Makefile.in

AUTOMAKE_OPTIONS = foreign

SUBDIRS = avl thread httpp net log timing

bin_PROGRAMS = icecast

noinst_HEADERS = admin.h cfgfile.h os.h logging.h sighandler.h connection.h global.h\
	 util.h slave.h source.h stats.h refbuf.h client.h format.h format_vorbis.h\
	 compat.h format_mp3.h fserve.h xslt.h yp.h event.h auth.h md5.h
icecast_SOURCES = cfgfile.c main.c logging.c sighandler.c connection.c global.c\
	 util.c slave.c source.c stats.c refbuf.c client.c format.c format_vorbis.c\
	 format_mp3.c xslt.c fserve.c event.c admin.c auth.c md5.c
EXTRA_icecast_SOURCES = yp.c
    
icecast_DEPENDENCIES = @ICECAST_OPTIONAL@ net/libicenet.la thread/libicethread.la \
    httpp/libicehttpp.la log/libicelog.la avl/libiceavl.la timing/libicetiming.la
icecast_LDADD = $(icecast_DEPENDENCIES) @XIPH_LIBS@

AM_CFLAGS = @XIPH_CFLAGS@
AM_CPPFLAGS = @XIPH_CPPFLAGS@


debug:
	$(MAKE) all CFLAGS="@DEBUG@"

profile:
	$(MAKE) all CFLAGS="@PROFILE@"

