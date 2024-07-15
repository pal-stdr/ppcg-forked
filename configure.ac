AC_INIT([ppcg], [0.09.1], [isl-development@googlegroups.com])
AC_CONFIG_AUX_DIR([autoconf])
AC_CONFIG_MACRO_DIR([m4])
AM_INIT_AUTOMAKE([foreign])
m4_ifdef([AM_SILENT_RULES],[AM_SILENT_RULES([yes])])

dnl Determine a C compiler to use
AC_PROG_CC

dnl Set C standard to C17
AX_CHECK_COMPILE_FLAG([-std=gnu17],
 [CFLAGS="$CFLAGS -std=gnu17"],
  [AC_MSG_ERROR([Compiler does not support C17])])


if test -n "${CXXFLAGS}"; then
	user_set_cxxflags=yes
fi

dnl Determine a C++ compiler to use
AC_PROG_CXX
AX_CXX_COMPILE_STDCXX(17, noext, mandatory)
if test X$user_set_cxxflags != Xyes; then
	dnl Enable all warnings.
	CXXFLAGS="-Wall"
fi


dnl Checks for header files.
AC_CHECK_HEADERS([float.h limits.h locale.h stddef.h stdint.h stdlib.h string.h])


dnl LT_INIT is a libtool package used in Autotools projects to handle the building and installation of shared libraries, static libraries, and executable programs.
LT_INIT

dnl a macro provided by pkg-config. This helper tool used when compiling applications and libraries. It simplifies the process of managing library compile and link flags, ensuring that the correct paths and options are used during the build process.
PKG_PROG_PKG_CONFIG

AX_CHECK_OPENMP
AX_CHECK_OPENCL
if test $HAVE_OPENCL = yes; then
	extra_tests="$extra_tests opencl_test.sh"
fi

AX_SUBMODULE(isl,build|bundled|system,bundled)
AM_CONDITIONAL(BUNDLED_ISL, test $with_isl = bundled)

AC_SUBST(ISL_CFLAGS)
AC_SUBST(ISL_LIBS)
case "$with_isl" in
bundled)
	ISL_CFLAGS="-I\$(top_srcdir)/isl/include -I\$(top_builddir)/isl/include"
	ISL_CFLAGS="$ISL_CFLAGS"
	ppcg_configure_args="$ppcg_configure_args --with-isl-builddir=../isl"
	ppcg_configure_args="$ppcg_configure_args --with-isl=build"
	ppcg_configure_args="$ppcg_configure_args --with-clang=system"
	;;
build)
	ISL_BUILDDIR=`echo @abs_builddir@ | $with_isl_builddir/config.status --file=-`
	ppcg_configure_args="$ppcg_configure_args --with-isl-builddir=$ISL_BUILDDIR"
	ISL_CFLAGS="-I$isl_srcdir/include -I$ISL_BUILDDIR/include"
	ISL_CFLAGS="$ISL_CFLAGS"
	ISL_LIBS="$with_isl_builddir/libisl.la"
	;;
system)
	PKG_CHECK_MODULES([ISL], [isl])
esac

AX_SUBMODULE(pet,bundled|system,bundled)
AM_CONDITIONAL(BUNDLED_PET, test $with_pet = bundled)

AC_SUBST(PET_CFLAGS)
AC_SUBST(PET_LIBS)
case "$with_pet" in
bundled)
	PET_CFLAGS="$PET_CFLAGS -I\$(top_srcdir)/pet/include"
	;;
system)
	PKG_CHECK_MODULES([PET], [pet])
	;;
esac


dnl ============ openscop (osl) ==============
AX_SUBMODULE(osl,build|bundled,bundled)
AM_CONDITIONAL(BUNDLED_OSL, test $with_osl = bundled)
dnl AX_SUBMODULE(osl,build|bundled,build)
dnl AM_CONDITIONAL(BUILD_OSL, test $with_osl = build)
AC_SUBST(OSL_CFLAGS)
AC_SUBST(OSL_LIBS)
case "$with_osl" in
bundled)
	OSL_CFLAGS="$OSL_CFLAGS -I\$(top_srcdir)"
	OSL_CFLAGS="$OSL_CFLAGS"
	;;

build)
	echo "Debug: with_osl_builddir = $with_osl_builddir"
    if test -n "$with_osl_builddir"; then
        OSL_BUILDDIR=`cd $with_osl_builddir && pwd`
    else
        OSL_BUILDDIR=`pwd`/osl  # Assuming the osl directory is in the current build directory
    fi
    echo "Debug: OSL_BUILDDIR = $OSL_BUILDDIR"
	# OSL_BUILDDIR=`echo @abs_builddir@ | $with_osl_builddir/config.status --file=-`
	ppcg_configure_args="$ppcg_configure_args --with-osl-builddir=$CJSON_BUILDDIR"
	OSL_CFLAGS="-I$OSL_BUILDDIR"
	OSL_CFLAGS="$OSL_CFLAGS"
	OSL_LIBS="$OSL_BUILDDIR/libosl.la"
	;;

esac
dnl ============ openscop (osl) ==============



dnl ============ cJSON (cjson) ==============
AX_SUBMODULE(cjson,build|bundled|system,bundled)
AM_CONDITIONAL(BUNDLED_CJSON, test $with_cjson = bundled)
dnl AX_SUBMODULE(cjson,build|bundled|system,build)
dnl AM_CONDITIONAL(BUILD_CJSON, test $with_cjson = build)
AC_SUBST(CJSON_CFLAGS)
AC_SUBST(CJSON_LIBS)
case "$with_cjson" in
bundled)
	CJSON_CFLAGS="$CJSON_CFLAGS -I\$(top_srcdir)"
	CJSON_CFLAGS="$CJSON_CFLAGS"
	;;
build)
	echo "Debug: with_cjson_builddir = $with_cjson_builddir"
    if test -n "$with_cjson_builddir"; then
        CJSON_BUILDDIR=`cd $with_cjson_builddir && pwd`
    else
        CJSON_BUILDDIR=`pwd`/cjson  # Assuming the cjson directory is in the current build directory
    fi
    echo "Debug: CJSON_BUILDDIR = $CJSON_BUILDDIR"
	# CJSON_BUILDDIR=`echo @abs_builddir@ | $with_cjson_builddir/config.status --file=-`
	ppcg_configure_args="$ppcg_configure_args --with-cjson-builddir=$CJSON_BUILDDIR"
	CJSON_CFLAGS="-I$CJSON_BUILDDIR"
	CJSON_CFLAGS="$CJSON_CFLAGS"
	CJSON_LIBS="$CJSON_BUILDDIR/libcJSON.la"
	;;
system)
	PKG_CHECK_MODULES([CJSON], [cjson])
	;;
esac
dnl ============ cJSON (cjson) ==============


AC_SUBST(POLYBENCH_DIR)
AC_SUBST(extra_tests)
AC_ARG_WITH([polybench],
	[AS_HELP_STRING([--with-polybench=DIR], [PolyBench location])],
	[
	if test -f "$with_polybench/utilities/benchmark_list"; then
		POLYBENCH_DIR=$with_polybench
		extra_tests="$extra_tests polybench_test.sh"
	fi
	])

AX_DETECT_GIT_HEAD

AC_CONFIG_FILES(Makefile)
AC_CONFIG_FILES([polybench_test.sh], [chmod +x polybench_test.sh])
AC_CONFIG_FILES([opencl_test.sh], [chmod +x opencl_test.sh])
if test $with_isl = bundled; then
	AC_CONFIG_SUBDIRS(isl)
fi
if test $with_pet = bundled; then
	AC_CONFIG_SUBDIRS(pet)
fi
if test $with_osl = bundled; then
	AC_CONFIG_SUBDIRS(osl)
fi
if test $with_cjson = bundled; then
	AC_CONFIG_SUBDIRS(cjson)
fi
AC_CONFIG_COMMANDS_POST([
	dnl pass on arguments to subdir configures, but don't
	dnl add them to config.status
	ac_configure_args="$ac_configure_args $ppcg_configure_args"
])
AC_OUTPUT
