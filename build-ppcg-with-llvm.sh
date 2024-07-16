#!/bin/bash

# IF YOU WANT TO BUILD ONLY, SET IT TO 0
# IF YOU WANT TO CONFIGURE + BUILD, THEN SET IT TO 1
WANT_TO_CONFIGURE_AND_BUILD=1


# DONOT CHANGE IT.
# If you set "WANT_TO_CONFIGURE_AND_BUILD" to "1", by default "WANT_TO_BUILD_ONLY" will be set to "1"
WANT_TO_BUILD_ONLY=$([ $WANT_TO_CONFIGURE_AND_BUILD -eq 0 ] && echo 1 || echo 0)




# Setup the Clang dependency ENV vars for pet (MANDATORY)
# "LLVM_FOR_PET_INSTALLATION_ROOT" set this to LLVM 16 build or installation path
LLVM_FOR_PET_INSTALLATION_ROOT=/path/to/llvm-16-src-build/installation

# If you already have another Clang version in your machine, and you are using another "clang" version, you need to keep this part.
LLVM_FOR_PET_LIB_PATH=$LLVM_FOR_PET_INSTALLATION_ROOT/lib
export LD_LIBRARY_PATH="$LLVM_FOR_PET_LIB_PATH${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"




# Name of the folder where you want to build
# This keeps the PPCG src tree much clean
BUILD_DIR="build/"


# Name of the folder, Where you want to install the bins
# By default, this will be passed as "../configure --prefix=ppcg-forked/installation ...."
# Name of the dir relative to ppcg
INSTALLATION_DIR="installation/"



# PPCG Configure flags
# If you want to use cache, use "-C"
CONFIGURE_FLAGS="--enable-static"



# Set the absolute path for the ppcg's "./configure --prefix=$INSTALL_PREFIX" option
# You can change it if you want.
INSTALL_PREFIX=$PWD/$INSTALLATION_DIR


# The LLVM build location
# Change according to your Clang location. Should be absolute path
CLANG_INSTALL_PATH=$LLVM_FOR_PET_INSTALLATION_ROOT





# Handle the build dir
remove_build_dir() {
    if [ -d $BUILD_DIR ]; then
        echo "$BUILD_DIR exists. Deleting..."
        rm -R $BUILD_DIR
        echo "$BUILD_DIR Creating..."
        mkdir -p $BUILD_DIR
    else
        echo "$BUILD_DIR directory does not exist. Creating $BUILD_DIR .."
        mkdir -p $BUILD_DIR
    fi
}


# Handle the install dir
remove_install_dir() {
    if [ -d $INSTALL_PREFIX ]; then
        echo "$INSTALL_PREFIX exists. Deleting..."
        rm -R $INSTALL_PREFIX
        echo "$INSTALL_PREFIX Creating..."
        mkdir -p $INSTALL_PREFIX
    else
        echo "$INSTALL_PREFIX directory does not exist. Creating $INSTALL_PREFIX .."
        mkdir -p $INSTALL_PREFIX
    fi
}



if [ $WANT_TO_BUILD_ONLY -eq 1 ]; then
    echo "You have set 'WANT_TO_BUILD_ONLY' as TRUE."
    echo "$BUILD_DIR will not be deleted."
    echo "$INSTALL_PREFIX will be deleted and created again."
    remove_install_dir
    # Change to build/ dir
    cd $BUILD_DIR
    make -j$(nproc)
    make install
else
    echo "You have set 'WANT_TO_BUILD_ONLY' as FALSE."
    echo "$BUILD_DIR will be deleted and created again."
    echo "$INSTALL_PREFIX will also be deleted and created again."
    remove_build_dir
    remove_install_dir
    # Change to build/ dir
    cd $BUILD_DIR
    ../configure --prefix=$INSTALL_PREFIX --with-clang-prefix=$CLANG_INSTALL_PATH $CONFIGURE_FLAGS --with-clang=system --cache-file=/dev/null --srcdir=../
    make -j$(nproc)
    make install
fi


: '

https://repo.or.cz/ppcg.git

Sven Verdoolaege <sven.verdoolaege@gmail.com>
Date:   Sun Apr 2 14:20:19 2023 +0200
PPCG 0.09.1
90e216272f3a87da0810f97d0fd2c3d4bb6f7424 (HEAD -> master, tag: ppcg-0.09.1

Submodule 'isl' (git://repo.or.cz/isl.git) registered for path 'isl'
Submodule 'pet' (git://repo.or.cz/pet.git) registered for path 'pet'
Cloning into '/media/username/EXTERNAL/compiler-projects/all-ppcg-test/ppcg-v2/isl'...
Cloning into '/media/username/EXTERNAL/compiler-projects/all-ppcg-test/ppcg-v2/pet'...
Submodule path 'isl': checked out 'e58af07f91c94db81627fb801fa6f52c3a7201a8'
Submodule path 'pet': checked out '7901ada0392a1f428a473aadbf8311f7ef9669d9'
Submodule 'imath' (https://github.com/creachadair/imath.git) registered for path 'imath'
Cloning into '/media/username/EXTERNAL/compiler-projects/all-ppcg-test/ppcg-v2/isl/imath'...
Submodule path 'imath': checked out '48932bf246a758929e00bee4ef2c0e0dd91a81c2'




git clone git://repo.or.cz/ppcg.git ppcg-v2

mkdir -p build/ installation/

./get_submodules.sh

./autogen.sh


./configure --with-clang-prefix=/path/to/llvm-9-src-build/installation --prefix=$PWD/installation --with-clang=system --cache-file=/dev/null --srcdir=.


// For building from inside build dir
../configure --with-clang-prefix=/path/to/llvm-9-src-build/installation --prefix=../installation --with-clang=system --cache-file=/dev/null --srcdir=../


'

