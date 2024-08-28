# rueda
#
# Copyright (C) Pallab 2024
#


# Define PACKAGE_NAME directly in Makefile.am ($(PACKAGE_NAME) Not used anywhere)
PACKAGE_NAME = rueda


# subdir-objects: With this option, Automake places object files into subdirectories corresponding to their source file's directory, which helps avoid filename clashes and keeps the build directory cleaner.
# foreign: Tells Automake not to require all GNU files (NEWS, README, AUTHORS, ChangeLog); this is useful for non-GNU projects.
AUTOMAKE_OPTIONS = subdir-objects foreign


MAINTAINERCLEANFILES = Makefile.in


# Check if the ISL is installed in the system, or built in the parent dir
if EXTERNAL_ISL
	# ISL_INCLUDE, ISL_LIBADD were already defined (coming from system)
else
	# ISL built in the parent dir
	ISL_INCLUDE = -I$(top_srcdir)/isl/include -I$(top_builddir)/isl/include
	ISL_LIBADD = $(top_builddir)/isl/libisl.la
endif




# ================= librueda.la ==================


# Define the compilation config for librueda.la library
# This is will be generated from rueda/lib folder only
lib_LTLIBRARIES = librueda.la


# -I include flags for C++ compiler (typically *.hpp files)
librueda_la_CXXFLAGS = $(OPT_FLAGS) $(DEBUG_FLAGS) \
		$(ISL_INCLUDE) \
		-I$(top_srcdir)/pet/include \
		-I../osl/include \
		-I$(top_srcdir)/osl/include \
		-I$(top_srcdir)/json/single_include \
		-I$(top_srcdir)/rueda/include \
		-I$(top_srcdir)/rueda/include/librueda \
		-I$(top_srcdir)/rueda/include/librueda/gpu \
		-I$(top_srcdir)/rueda/include/librueda/fpga \
		-I$(top_srcdir)/rueda/lib/gpu \
		-I$(top_srcdir)/rueda/lib/fpga \
		-I$(top_srcdir)/rueda/lib


# -I include flags for C compiler
# To avoid same name object from being created with/without libtool.
librueda_la_CFLAGS = \
        $(AM_CFLAGS) \
        $(librueda_la_CXXFLAGS)


# Source files for the library
librueda_la_SOURCES = \
		lib/fpga/rueda_fpga_options.c \
		lib/fpga/rueda_fpga.c \
		lib/gpu/rueda_gpu_logger.cpp \
		lib/gpu/rueda_gpu_options.c \
		lib/gpu/rueda_gpu.c \
		lib/rueda_options.c \
		lib/rueda.cpp



# Static linking flags for the library
librueda_la_LDFLAGS = -static


# Dependencies for the library
# libpet needs to come later after libisl so that the right isl is linked.
librueda_la_LIBADD = \
		$(ISL_LIBADD) \
		../pet/libpet.la \
		../osl/libosl.la \
		-lm


# # Create librueda.la target manually
# librueda:
# 	$(MAKE) $(MFLAGS) -C lib librueda.la




# ================= ruedabin ==================


# ruedabin is the bin that also add librueda.la
bin_PROGRAMS = ruedabin


ruedabin_SOURCES = \
		main.cpp \
		utility.cpp


# -I include flags for C++ compiler (typically *.hpp files)
# ruedabin will use the same CXXFLAGS of librueda
ruedabin_CXXFLAGS = $(librueda_la_CXXFLAGS)


# -I include flags for C compiler
# To avoid same name object from being created with/without libtool.
ruedabin_CFLAGS = \
		$(AM_CFLAGS) \
		$(ruedabin_CXXFLAGS)


ruedabin_LDFLAGS = -static


# libpet needs to come later after libisl so that the right isl is linked.
ruedabin_LDADD =  \
		$(ISL_LIBADD) \
		../pet/libpet.la \
		../osl/libosl.la \
		librueda.la \
		-lm



# ================= Dump final headers in your prefix/include path ==================

# Use following
# In "includedir", you can set the custom path for dumping header files with respect to prefix path
# # "rueda.h, ....h" goes to "prefix/include/rueda/" dir (a.k.a "includedir=")
includedir = $(prefix)/include/$(PACKAGE_NAME)


# Then tell the automake, which header files are to be dumped in "includedir" path
nobase_include_HEADERS = \
	include/utility.hpp \
	include/librueda/rueda.hpp \
	include/librueda/fpga/rueda_fpga.h \
	include/librueda/fpga/rueda_fpga_options.h \
	include/librueda/gpu/rueda_gpu.h \
	include/librueda/gpu/rueda_gpu_options.h


# This hook handles the dumping process in "--prefix=" path
# $(PACKAGE_NAME)=rueda
# $(libdir)=prefix/lib
# $(libdir)=prefix/lib
# "librueda.la" goes to "prefix/lib" and "prefix/lib/rueda/"
# And "ruedabin" goes to "prefix/bin"
install-data-local:
	@echo "Headers will be installed to: $(includedir)"
	@echo "Printing PACKAGE_NAME= $(PACKAGE_NAME) & libdir=$(libdir)"
	@test -z "$(DESTDIR)$(libdir)/$(PACKAGE_NAME)" || $(mkdir_p) "$(DESTDIR)$(libdir)/$(PACKAGE_NAME)"
	@cp librueda.la "$(DESTDIR)$(libdir)/"
	@cp librueda.la "$(DESTDIR)$(libdir)/$(PACKAGE_NAME)/"
	@cp ruedabin "$(DESTDIR)$(bindir)/"




# ================= Future helper ==================


# # Debugging output
# $(info Debugger: )
# $(info Current directory: $(shell pwd))
# $(info top_builddir directory: $(top_builddir))
# $(info top_srcdir directory: $(top_srcdir))
# $(info srcdir directory: $(srcdir))
# $(info LIBRUEDA_CORE_API_CPPFILES_DIR_STRIPPED = $(LIBRUEDA_CORE_API_CPPFILES_DIR_STRIPPED))
# $(info LIBRUEDA_GPU_CFILES_DIR_STRIPPED = $(LIBRUEDA_GPU_CFILES_DIR_STRIPPED))
# $(info LIBRUEDA_GPU_CPPFILES_DIR_STRIPPED = $(LIBRUEDA_GPU_CPPFILES_DIR_STRIPPED))
# $(info RUEDABIN_CORE_CFILES_DIR_STRIPPED = $(RUEDABIN_CORE_CFILES_DIR_STRIPPED))
# $(info RUEDABIN_CORE_CPPFILES_DIR_STRIPPED = $(RUEDABIN_CORE_CPPFILES_DIR_STRIPPED))
# $(info ruedabin_SOURCES = $(ruedabin_SOURCES))


# Current directory: /abs/path/to/project-root/build/rueda
# top_builddir directory: ..
# top_srcdir directory: ../..
# srcdir directory: ../../rueda

# LIBRUEDA_CORE_API_CPPFILES = ../../rueda/lib/rueda.cpp
# LIBRUEDA_GPU_CFILES = ../../rueda/lib/gpu/rueda_gpu.c ../../rueda/lib/gpu/rueda_gpu_options.c
# LIBRUEDA_GPU_CPPFILES = ../../rueda/lib/gpu/rueda_gpu_logger.cpp
# RUEDABIN_CORE_CFILES = 
# RUEDABIN_CORE_CPPFILES = ../../rueda/utility.cpp ../../rueda/main.cpp
# ruedabin_SOURCES =  ../../rueda/utility.cpp ../../rueda/main.cpp


# Have to strip this to following


# LIBRUEDA_CORE_API_CPPFILES = lib/rueda.cpp
# LIBRUEDA_GPU_CFILES = lib/gpu/rueda_gpu.c lib/gpu/rueda_gpu_options.c
# LIBRUEDA_GPU_CPPFILES = lib/gpu/rueda_gpu_logger.cpp
# RUEDABIN_CORE_CFILES = 
# RUEDABIN_CORE_CPPFILES = utility.cpp main.cpp
# ruedabin_SOURCES =  utility.cpp main.cpp


# # configre.ac code dump
# # Find all .c and .cpp files in the source directories
# LIBRUEDA_GPU_CFILES=$(find "$srcdir/rueda/lib/gpu" -name '*.c')
# LIBRUEDA_GPU_CPPFILES=$(find "$srcdir/rueda/lib/gpu" -name '*.cpp')

# LIBRUEDA_FPGA_CFILES=$(find "$srcdir/rueda/lib/fpga" -name '*.c')
# LIBRUEDA_FPGA_CPPFILES=$(find "$srcdir/rueda/lib/fpga" -name '*.cpp')

# LIBRUEDA_CORE_API_CFILES=$(find "$srcdir/rueda/lib" -maxdepth 1 -name '*.c')
# LIBRUEDA_CORE_API_CPPFILES=$(find "$srcdir/rueda/lib" -maxdepth 1 -name '*.cpp')

# RUEDABIN_CORE_CFILES=$(find "$srcdir/rueda" -maxdepth 1 -name '*.c')
# RUEDABIN_CORE_CPPFILES=$(find "$srcdir/rueda" -maxdepth 1 -name '*.cpp')

# # Strip the prefix $srcdir/ from the file paths
# LIBRUEDA_GPU_CFILES_STRIPPED=$(echo "$LIBRUEDA_GPU_CFILES" | sed "s|^$srcdir/||")
# LIBRUEDA_GPU_CPPFILES_STRIPPED=$(echo "$LIBRUEDA_GPU_CPPFILES" | sed "s|^$srcdir/||")

# LIBRUEDA_FPGA_CFILES_STRIPPED=$(echo "$LIBRUEDA_FPGA_CFILES" | sed "s|^$srcdir/||")
# LIBRUEDA_FPGA_CPPFILES_STRIPPED=$(echo "$LIBRUEDA_FPGA_CPPFILES" | sed "s|^$srcdir/||")

# LIBRUEDA_CORE_API_CFILES_STRIPPED=$(echo "$LIBRUEDA_CORE_API_CFILES" | sed "s|^$srcdir/||")
# LIBRUEDA_CORE_API_CPPFILES_STRIPPED=$(echo "$LIBRUEDA_CORE_API_CPPFILES" | sed "s|^$srcdir/||")

# RUEDABIN_CORE_CFILES_DIR_STRIPPED=$(echo "$RUEDABIN_CORE_CFILES" | sed "s|^$srcdir/||")
# RUEDABIN_CORE_CPPFILES_DIR_STRIPPED=$(echo "$RUEDABIN_CORE_CPPFILES" | sed "s|^$srcdir/||")
