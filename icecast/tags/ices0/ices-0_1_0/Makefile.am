## Process this with automake to create Makefile.in

AUTOMAKE_OPTIONS = foreign

SUBDIRS = @subdirs@ resolver avl log thread src conf doc

install-data-local:
	mkdir -p $(DESTDIR)$(ICES_LOGDIR_INST)
	mkdir -p $(DESTDIR)$(ICES_MODULEDIR)

EXTRA_DIST = README FEATURES BUGS AUTHORS TODO INSTALL COPYING CHANGES FAQ TESTED README.playlist ices.pm ices.py README.old FILES
