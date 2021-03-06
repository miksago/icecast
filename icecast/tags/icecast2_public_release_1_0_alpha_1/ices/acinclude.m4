# Configure paths for libogg
# Jack Moffitt <jack@icecast.org> 10-21-2000
# Shamelessly stolen from Owen Taylor and Manish Singh

dnl AM_PATH_OGG([ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl Test for libogg, and define OGG_CFLAGS and OGG_LIBS
dnl
AC_DEFUN(AM_PATH_OGG,
[dnl 
dnl Get the cflags and libraries
dnl
AC_ARG_WITH(ogg-prefix,[  --with-ogg-prefix=PFX   Prefix where libogg is installed (optional)], ogg_prefix="$withval", ogg_prefix="")
AC_ARG_ENABLE(oggtest, [  --disable-oggtest       Do not try to compile and run a test Ogg program],, enable_oggtest=yes)

  if test "x$ogg_prefix" != "xNONE" ; then
    ogg_args="$ogg_args --prefix=$ogg_prefix"
    OGG_CFLAGS="-I$ogg_prefix/include"
    OGG_LIBS="-L$ogg_prefix/lib"
  elif test "$prefix" != ""; then
    ogg_args="$ogg_args --prefix=$prefix"
    OGG_CFLAGS="-I$prefix/include"
    OGG_LIBS="-L$prefix/lib"
  fi

  OGG_LIBS="$OGG_LIBS -logg"

  AC_MSG_CHECKING(for Ogg)
  no_ogg=""


  if test "x$enable_oggtest" = "xyes" ; then
    ac_save_CFLAGS="$CFLAGS"
    ac_save_LIBS="$LIBS"
    CFLAGS="$CFLAGS $OGG_CFLAGS"
    LIBS="$LIBS $OGG_LIBS"
dnl
dnl Now check if the installed Ogg is sufficiently new.
dnl
      rm -f conf.oggtest
      AC_TRY_RUN([
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ogg/ogg.h>

int main ()
{
  system("touch conf.oggtest");
  return 0;
}

],, no_ogg=yes,[echo $ac_n "cross compiling; assumed OK... $ac_c"])
       CFLAGS="$ac_save_CFLAGS"
       LIBS="$ac_save_LIBS"
  fi

  if test "x$no_ogg" = "x" ; then
     AC_MSG_RESULT(yes)
     ifelse([$1], , :, [$1])     
  else
     AC_MSG_RESULT(no)
     if test -f conf.oggtest ; then
       :
     else
       echo "*** Could not run Ogg test program, checking why..."
       CFLAGS="$CFLAGS $OGG_CFLAGS"
       LIBS="$LIBS $OGG_LIBS"
       AC_TRY_LINK([
#include <stdio.h>
#include <ogg/ogg.h>
],     [ return 0; ],
       [ echo "*** The test program compiled, but did not run. This usually means"
       echo "*** that the run-time linker is not finding Ogg or finding the wrong"
       echo "*** version of Ogg. If it is not finding Ogg, you'll need to set your"
       echo "*** LD_LIBRARY_PATH environment variable, or edit /etc/ld.so.conf to point"
       echo "*** to the installed location  Also, make sure you have run ldconfig if that"
       echo "*** is required on your system"
       echo "***"
       echo "*** If you have an old version installed, it is best to remove it, although"
       echo "*** you may also be able to get things to work by modifying LD_LIBRARY_PATH"],
       [ echo "*** The test program failed to compile or link. See the file config.log for the"
       echo "*** exact error that occured. This usually means Ogg was incorrectly installed"
       echo "*** or that you have moved Ogg since it was installed. In the latter case, you"
       echo "*** may want to edit the ogg-config script: $OGG_CONFIG" ])
       CFLAGS="$ac_save_CFLAGS"
       LIBS="$ac_save_LIBS"
     fi
     OGG_CFLAGS=""
     OGG_LIBS=""
     ifelse([$2], , :, [$2])
  fi
  AC_SUBST(OGG_CFLAGS)
  AC_SUBST(OGG_LIBS)
  rm -f conf.oggtest
])
# Configure paths for libvorbis
# Jack Moffitt <jack@icecast.org> 10-21-2000
# Shamelessly stolen from Owen Taylor and Manish Singh

dnl AM_PATH_VORBIS([ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl Test for libvorbis, and define VORBIS_CFLAGS and VORBIS_LIBS
dnl
AC_DEFUN(AM_PATH_VORBIS,
[dnl 
dnl Get the cflags and libraries
dnl
AC_ARG_WITH(vorbis-prefix,[  --with-vorbis-prefix=PFX   Prefix where libvorbis is installed (optional)], vorbis_prefix="$withval", vorbis_prefix="")
AC_ARG_ENABLE(vorbistest, [  --disable-vorbistest       Do not try to compile and run a test Vorbis program],, enable_vorbistest=yes)

  if test "x$vorbis_prefix" != "xNONE" ; then
    vorbis_args="$vorbis_args --prefix=$vorbis_prefix"
    VORBIS_CFLAGS="-I$vorbis_prefix/include"
    VORBIS_LIBDIR="-L$vorbis_prefix/lib"
  elif test "$prefix" != ""; then
    vorbis_args="$vorbis_args --prefix=$prefix"
    VORBIS_CFLAGS="-I$prefix/include"
    VORBIS_LIBDIR="-L$prefix/lib"
  fi

  VORBIS_LIBS="$VORBIS_LIBDIR -lvorbis -lm"
  VORBISFILE_LIBS="-lvorbisfile"
  VORBISENC_LIBS="-lvorbisenc"

  AC_MSG_CHECKING(for Vorbis)
  no_vorbis=""


  if test "x$enable_vorbistest" = "xyes" ; then
    ac_save_CFLAGS="$CFLAGS"
    ac_save_LIBS="$LIBS"
    CFLAGS="$CFLAGS $VORBIS_CFLAGS"
    LIBS="$LIBS $VORBIS_LIBS $OGG_LIBS"
dnl
dnl Now check if the installed Vorbis is sufficiently new.
dnl
      rm -f conf.vorbistest
      AC_TRY_RUN([
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <vorbis/codec.h>

int main ()
{
  system("touch conf.vorbistest");
  return 0;
}

],, no_vorbis=yes,[echo $ac_n "cross compiling; assumed OK... $ac_c"])
       CFLAGS="$ac_save_CFLAGS"
       LIBS="$ac_save_LIBS"
  fi

  if test "x$no_vorbis" = "x" ; then
     AC_MSG_RESULT(yes)
     ifelse([$1], , :, [$1])     
  else
     AC_MSG_RESULT(no)
     if test -f conf.vorbistest ; then
       :
     else
       echo "*** Could not run Vorbis test program, checking why..."
       CFLAGS="$CFLAGS $VORBIS_CFLAGS"
       LIBS="$LIBS $VORBIS_LIBS $OGG_LIBS"
       AC_TRY_LINK([
#include <stdio.h>
#include <vorbis/codec.h>
],     [ return 0; ],
       [ echo "*** The test program compiled, but did not run. This usually means"
       echo "*** that the run-time linker is not finding Vorbis or finding the wrong"
       echo "*** version of Vorbis. If it is not finding Vorbis, you'll need to set your"
       echo "*** LD_LIBRARY_PATH environment variable, or edit /etc/ld.so.conf to point"
       echo "*** to the installed location  Also, make sure you have run ldconfig if that"
       echo "*** is required on your system"
       echo "***"
       echo "*** If you have an old version installed, it is best to remove it, although"
       echo "*** you may also be able to get things to work by modifying LD_LIBRARY_PATH"],
       [ echo "*** The test program failed to compile or link. See the file config.log for the"
       echo "*** exact error that occured. This usually means Vorbis was incorrectly installed"
       echo "*** or that you have moved Vorbis since it was installed." ])
       CFLAGS="$ac_save_CFLAGS"
       LIBS="$ac_save_LIBS"
     fi
     VORBIS_CFLAGS=""
     VORBIS_LIBS=""
     VORBISFILE_LIBS=""
     VORBISENC_LIBS=""
     ifelse([$2], , :, [$2])
  fi
  AC_SUBST(VORBIS_CFLAGS)
  AC_SUBST(VORBIS_LIBS)
  AC_SUBST(VORBISFILE_LIBS)
  AC_SUBST(VORBISENC_LIBS)
  rm -f conf.vorbistest
])
# Configure paths for libshout
# Jack Moffitt <jack@icecast.org> 08-06-2001
# Shamelessly stolen from Owen Taylor and Manish Singh

dnl AM_PATH_SHOUT([ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
dnl Test for libshout, and define SHOUT_CFLAGS and SHOUT_LIBS
dnl
AC_DEFUN(AM_PATH_SHOUT,
[dnl 
dnl Get the cflags and libraries
dnl
AC_ARG_WITH(shout-prefix,[  --with-shout-prefix=PFX   Prefix where libshout is installed (optional)], shout_prefix="$withval", shout_prefix="")
AC_ARG_ENABLE(shouttest, [  --disable-shouttest       Do not try to compile and run a test Shout program],, enable_shouttest=yes)

  if test "x$shout_prefix" != "xNONE" ; then
    shout_args="$shout_args --prefix=$shout_prefix"
    SHOUT_CFLAGS="-I$shout_prefix/include"
    SHOUT_LIBS="-L$shout_prefix/lib"
  elif test "$prefix" != ""; then
    shout_args="$shout_args --prefix=$prefix"
    SHOUT_CFLAGS="-I$prefix/include"
    SHOUT_LIBS="-L$prefix/lib"
  fi

  SHOUT_LIBS="$SHOUT_LIBS -lshout -lpthread"

  case $host in
  *-*-solaris*)
  	SHOUT_LIBS="$SHOUT_LIBS -lnsl -lsocket -lresolv"
  esac

  AC_MSG_CHECKING(for Shout)
  no_shout=""

  if test "x$enable_shouttest" = "xyes" ; then
    ac_save_CFLAGS="$CFLAGS"
    ac_save_LIBS="$LIBS"
    CFLAGS="$CFLAGS $SHOUT_CFLAGS $OGG_CFLAGS $VORBIS_CFLAGS"
    LIBS="$LIBS $SHOUT_LIBS $OGG_LIBS $VORBIS_LIBS"
dnl
dnl Now check if the installed Shout is sufficiently new.
dnl
      rm -f conf.shouttest
      AC_TRY_RUN([
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <shout/shout.h>

int main ()
{
  system("touch conf.shouttest");
  return 0;
}

],, no_shout=yes,[echo $ac_n "cross compiling; assumed OK... $ac_c"])
       CFLAGS="$ac_save_CFLAGS"
       LIBS="$ac_save_LIBS"
  fi

  if test "x$no_shout" = "x" ; then
     AC_MSG_RESULT(yes)
     ifelse([$1], , :, [$1])     
  else
     AC_MSG_RESULT(no)
     if test -f conf.shouttest ; then
       :
     else
       echo "*** Could not run Shout test program, checking why..."
       CFLAGS="$CFLAGS $SHOUT_CFLAGS $OGG_CFLAGS $VORBIS_CFLAGS"
       LIBS="$LIBS $SHOUT_LIBS $OGG_LIBS $VORBIS_LIBS"
       AC_TRY_LINK([
#include <stdio.h>
#include <shout/shout.h>
],     [ return 0; ],
       [ echo "*** The test program compiled, but did not run. This usually means"
       echo "*** that the run-time linker is not finding Shout or finding the wrong"
       echo "*** version of Shout. If it is not finding Shout, you'll need to set your"
       echo "*** LD_LIBRARY_PATH environment variable, or edit /etc/ld.so.conf to point"
       echo "*** to the installed location  Also, make sure you have run ldconfig if that"
       echo "*** is required on your system"
       echo "***"
       echo "*** If you have an old version installed, it is best to remove it, although"
       echo "*** you may also be able to get things to work by modifying LD_LIBRARY_PATH"],
       [ echo "*** The test program failed to compile or link. See the file config.log for the"
       echo "*** exact error that occured. This usually means Shout was incorrectly installed"
       echo "*** or that you have moved Shout since it was installed. In the latter case, you"
       echo "*** may want to edit the shout-config script: $SHOUT_CONFIG" ])
       CFLAGS="$ac_save_CFLAGS"
       LIBS="$ac_save_LIBS"
     fi
     SHOUT_CFLAGS=""
     SHOUT_LIBS=""
     ifelse([$2], , :, [$2])
  fi
  AC_SUBST(SHOUT_CFLAGS)
  AC_SUBST(SHOUT_LIBS)
  rm -f conf.shouttest
])
