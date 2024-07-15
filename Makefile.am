if BUNDLED_ISL
    MAYBE_ISL = isl
    ISL_LA = $(top_builddir)/isl/libisl.la
    LOCAL_ISL_LA = isl/libisl.la
endif
if BUNDLED_PET
    MAYBE_PET = pet
    PET_LA = $(top_builddir)/pet/libpet.la
endif


# Handle osl
MAYBE_OSL = osl
OSL_LA = $(top_builddir)/osl/libosl.la
LOCAL_OSL_LA = osl/libosl.la


# Handle cjson
MAYBE_CJSON = cjson
CJSON_LA = $(top_builddir)/cjson/libcJSON.la
LOCAL_CJSON_LA = cjson/libcJSON.la


SUBDIRS = $(MAYBE_ISL) $(MAYBE_PET) $(MAYBE_OSL) $(MAYBE_CJSON) .


FORCE:
isl/libisl.la: FORCE
	cd isl; $(MAKE) $(AM_MAKEFLAGS) libisl.la
pet/libpet.la: $(LOCAL_ISL_LA) FORCE
	cd pet; $(MAKE) $(AM_MAKEFLAGS) libpet.la


# osl setup
# For "BUNDLED_OSL". Comment this target if BUILD_OSL is used
$(LOCAL_OSL_LA):
	cd osl; $(MAKE) $(AM_MAKEFLAGS) libosl.la

# For "BUILD_OSL", no target definition is necessary



# cjson setup
# For "BUNDLED_CJSON". Comment this target if BUILD_CJSON is used
$(LOCAL_CJSON_LA):
	cd cjson; $(MAKE) $(AM_MAKEFLAGS) libcJSON.la

# For "BUILD_CJSON", no target definition is necessary

# Loggers
# $(info CJSON_LA = $(CJSON_LA))	// ./cjson/libcJSON.la
# $(info top_builddir = $(top_builddir))


ACLOCAL_AMFLAGS = -I m4

LIB_ISL = $(ISL_LA) @ISL_LIBS@
LIB_PET = $(PET_LA) @PET_LIBS@
LIB_OSL = $(OSL_LA) @OSL_LIBS@
LIB_CJSON = $(CJSON_LA) @CJSON_LIBS@

AM_CPPFLAGS = @ISL_CFLAGS@ @PET_CFLAGS@ @OSL_CFLAGS@ @CJSON_CFLAGS@
LDADD = $(LIB_PET) $(LIB_ISL) $(LIB_OSL) $(LIB_CJSON)

bin_PROGRAMS = ppcg
ppcg_SOURCES = \
	cpu.c \
	cpu.h \
	cuda.c \
	cuda.h \
	opencl.c \
	opencl.h \
	cuda_common.h \
	cuda_common.c \
	gpu.c \
	gpu.h \
	gpu_array_tile.c \
	gpu_array_tile.h \
	gpu_group.c \
	gpu_group.h \
	gpu_hybrid.c \
	gpu_hybrid.h \
	gpu_print.c \
	gpu_print.h \
	gpu_tree.c \
	gpu_tree.h \
	grouping.c \
	grouping.h \
	hybrid.c \
	hybrid.h \
	schedule.c \
	schedule.h \
	ppcg_options.c \
	ppcg_options.h \
	ppcg.c \
	ppcg.h \
	print.c \
	print.h \
	util.c \
	util.h \
	version.c

TESTS = @extra_tests@
EXTRA_TESTS = opencl_test.sh polybench_test.sh
TEST_EXTENSIONS = .sh

BUILT_SOURCES = gitversion.h

CLEANFILES = gitversion.h

EXTRA_DIST = \
	examples \
	ocl_utilities.c \
	ocl_utilities.h \
	tests

dist-hook:
	echo @GIT_HEAD_VERSION@ > $(distdir)/GIT_HEAD_ID

gitversion.h: @GIT_HEAD@
	$(AM_V_GEN)echo '#define GIT_HEAD_ID "'@GIT_HEAD_VERSION@'"' > $@
