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


SUBDIRS = $(MAYBE_ISL) $(MAYBE_PET) $(MAYBE_OSL) rueda .


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



ACLOCAL_AMFLAGS = -I m4

LIB_ISL = $(ISL_LA) @ISL_LIBS@
LIB_PET = $(PET_LA) @PET_LIBS@
LIB_OSL = $(OSL_LA) @OSL_LIBS@


AM_CPPFLAGS = @ISL_CFLAGS@ @PET_CFLAGS@ @OSL_CFLAGS@
LDADD = $(LIB_PET) $(LIB_ISL) $(LIB_OSL)


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








# ======= RUEDA lib + bin HANDLER ========


# Rueda bin + lib generator (ruedabin + librueda.la) target definitions
# The details of compilation configs are defined in "rueda/Makefile.am"
# Following is a recursive target calling chain.
# 1st, "PHONY: ruedabin" targed is called.
# 2nd, "ruedabin" from "PHONY: ruedabin" calls target "librueda".
# 3rd, "librueda" from "librueda: force" calls target "force".
# 4th, "force" target is defined as "true".
# 5th, so "librueda: force" becomes "librueda: true". So the "$(MAKE) $(MFLAGS) -C rueda/lib/ librueda.la" is executed. By reading only the "lib/" dir from "rueda/" dir, the "librueda.la" is built.
# 6th, "ruedabin: librueda" is satisfied as target build dependency. So "$(MAKE) $(MFLAGS) -C rueda/ ruedabin" is executed and "ruedabin" is built.
# until this point we have "librueda" & "ruedabin" is built.
# 7th, ".PHONY: binit" target is called.
# 8th, (Not used) "binit" target definition executed. copy the "build/rueda/ruedabin" to "installation/bin/ruedabin". Here "installation/" is the path set in the ppcg configure --prefix=/abs/path/to/installation. Also copy the "build/rueda/librueda" to "installation/lib/librueda"

# # Works, but no need to handle. In "rueda/Makefile.am"
# .PHONY: binit

# binit:
# 	cp -f rueda/ruedabin bin/
# 	cp -f rueda/librueda.la lib/



force:
	true

librueda: force
	$(MAKE) $(MFLAGS) -C rueda/lib/ librueda.la

ruedabin: librueda
	$(MAKE) $(MFLAGS) -C rueda/ ruedabin

PHONY: ruedabin


