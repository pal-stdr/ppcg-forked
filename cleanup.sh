# Clean up root dir
echo "Cleaning up project-root/"
rm -Rf autoconf/ autom4te.cache/ build/ installation/
rm m4/libtool.m4 m4/lt~obsolete.m4 m4/ltoptions.m4 m4/ltsugar.m4 m4/ltversion.m4
rm configure aclocal.m4 Makefile.in
# rm compile config.guess config.sub depcomp install-sh ltmain.sh missing


# Clean up isl
echo "Cleaning up isl/"
rm -Rf isl/autom4te.cache/
rm isl/m4/libtool.m4 isl/m4/lt~obsolete.m4 isl/m4/ltoptions.m4 isl/m4/ltsugar.m4 isl/m4/ltversion.m4
rm isl/aclocal.m4 isl/compile isl/config.guess isl/config.sub isl/configure isl/depcomp isl/install-sh isl/ltmain.sh isl/Makefile.in isl/missing isl/py-compile isl/test-driver

# Cleanup pet
echo "Cleaning up pet/"
rm -Rf pet/autom4te.cache/ pet/build-aux/
rm pet/m4/libtool.m4 pet/m4/lt~obsolete.m4 pet/m4/ltoptions.m4 pet/m4/ltsugar.m4 pet/m4/ltversion.m4
rm pet/aclocal.m4 pet/configure pet/Makefile.in


# # Cleanup osl
# echo "Cleaning up osl/"
# rm -Rf osl/autoconf/ osl/autom4te.cache/
# rm osl/m4/libtool.m4 osl/m4/lt~obsolete.m4 osl/m4/ltoptions.m4 osl/m4/ltsugar.m4 osl/m4/ltversion.m4
# rm osl/aclocal.m4 osl/configure osl/Makefile.in


# # Clean up cJSON
# echo "Cleaning up cjson/"
# rm -Rf cjson/autom4te.cache/ cjson/autoconf/
# rm cjson/m4/libtool.m4 cjson/m4/lt~obsolete.m4 cjson/m4/ltoptions.m4 cjson/m4/ltsugar.m4 cjson/m4/ltversion.m4
# rm cjson/aclocal.m4 cjson/configure cjson/Makefile.in


# # Clean up rueda
# echo "Cleaning up rueda/"
# rm rueda/Makefile.in