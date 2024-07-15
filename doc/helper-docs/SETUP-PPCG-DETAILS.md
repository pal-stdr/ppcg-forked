# PPCG

## OVERVIEW

- Please see [https://repo.or.cz/ppcg.git](https://repo.or.cz/ppcg.git).

- **This forked copy is from the commit `90e2162`** which was published on April 2, 2023.

## LICENSE

ppcg is available under the MIT LICENSE. Please see the file [`LICENSE`](LICENSE) in the top-level directory for more details. And all modifications and additions made in this forked copy is under [`LICENSE_ADDITIONAL`](LICENSE_ADDITIONAL).


## 1. PREREQUISITES

- Ubuntu 20.04LTS is tested.

- Following Ubuntu packages are required `build-essential`, `automake`, `autoconf`, `libtool`,`libtool-bin`, `pkg-config`, `libgmp3-dev`, `libyaml-dev`


- LLVM/Clang is needed for the `pet` submodule. **For this forked copy, `Clang 16.0.6` & `Clang 9.0.0` are tested successfully.**

- **DONOT WORK w/ THE `master` BRANCH.**

- For a **QUICKSTART**, go to [doc/helper-docs/SUPERFAST-PLAY-WITH-PPCG.md](SUPERFAST-PLAY-WITH-PPCG.md). **THAT DOCUMENT WILL TELL YOU THE `SUMMARIZED` PROCESS OF PLAYING WITH PPCG.**


### 1.1. Installing Dev dependencies

**Idea:**
- General build tools `build-essential` (contains [multiple packages](https://packages.ubuntu.com/focal/build-essential) `g++`, `gcc`, `make`, `libc6-dev`, `dpkg-dev`)
- Automatic build tools including `autoconf`, `automake`, and `libtool`.
- `libgmp3-dev` that is required by `isl` lib.


**What + How to install:**
- General dev dependencies:
```sh
sudo apt-get install -y build-essential
```

- PPCG specific dependencies:
```sh
sudo apt-get install automake autoconf libtool libtool-bin pkg-config libgmp3-dev libyaml-dev
```



### 1.2. Handling `LLVM/Clang` dependency

- **`Clang` should be built (not recommended w/ `apt-get install`)**. Because we consider that you might have other `Clang` versions in your machine.

- As prerequisite to build clang/llvm, you need to have [`cmake`](https://cmake.org/download/) & [`ninja`](https://github.com/ninja-build/ninja/releases) installed.

- We will be passing path of `Clang` using the `--with-clang-prefix=$CLANG_BUILD_PATH` in ppcg's `configure` command.

- Make sure of that, the `Clang` lib path is added to your `LD_LIBRARY_PATH` after your build the `Clang`.

- **Clone `Clang 16.0.6` `git clone -b release/16.x --depth 1 https://github.com/llvm/llvm-project.git llvm-16-src-build`**

- **Build Clang with `clang` + `clang++` (faster)**. Clone the `llvm-16.0.6`, then use following

```sh
mkdir -p build installation
cd build/
echo $PWD
cmake   \
    -G Ninja    \
    -S ../llvm  \
    -B .    \
    -DCMAKE_BUILD_TYPE=Release      \
    -DCMAKE_INSTALL_PREFIX=../installation  \
    -DLLVM_ENABLE_ASSERTIONS=ON     \
    -DLLVM_ENABLE_PROJECTS="mlir;clang;lldb;lld" \
    -DLLVM_INSTALL_UTILS=ON     \
    -DLLVM_ENABLE_LLD=ON    \
    -DCMAKE_C_COMPILER=clang    \
    -DCMAKE_CXX_COMPILER=clang++    \
    -DLLVM_PARALLEL_LINK_JOBS=1     \
    -DLLVM_TARGETS_TO_BUILD="Native"

cmake --build . --target check-mlir
ninja install
```

- **Build Clang with `gcc` + `g++` (slower)**.
```sh
mkdir -p build installation
cd build/

echo $PWD

cmake   \
    -G Ninja    \
    -S ../llvm  \
    -B .    \
    -DCMAKE_BUILD_TYPE=Release      \
    -DCMAKE_INSTALL_PREFIX=../installation  \
    -DLLVM_ENABLE_ASSERTIONS=ON     \
    -DLLVM_ENABLE_PROJECTS="mlir;clang;lldb;lld" \
    -DLLVM_INSTALL_UTILS=ON     \
    -DLLVM_ENABLE_LLD=OFF    \
    -DCMAKE_C_COMPILER=gcc    \
    -DCMAKE_CXX_COMPILER=g++    \
    -DLLVM_PARALLEL_LINK_JOBS=0     \
    -DLLVM_TARGETS_TO_BUILD="Native"

cmake --build . --target check-mlir
ninja install
```



- **If `Clang 16` is configured in your `~/.bashrc` or `~/.profile` like following**

```sh
export LLVM_FOLDER_NAME="llvm-16-src-build"
export YOUR_LLVM_PROJECT_CLONE_PATH="/abs/path/to/$LLVM_FOLDER_NAME"
export LLVM_PROJECT_ROOT=$YOUR_LLVM_PROJECT_CLONE_PATH
export LLVM_INSTALLATION_ROOT=$LLVM_PROJECT_ROOT/installation

export LLVM_CONFIG="$LLVM_INSTALLATION_ROOT/bin/llvm-config"
export LLVM_AND_CLANG_BIN_PATH="$LLVM_INSTALLATION_ROOT/bin"
export LLVM_AND_CLANG_LIB_PATH="$LLVM_INSTALLATION_ROOT/lib"
export LLVM_AND_CLANG_INCLUDE_PATH="$LLVM_INSTALLATION_ROOT/include"
export LD_LIBRARY_PATH=$LLVM_AND_CLANG_LIB_PATH${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
export PATH=$LLVM_AND_CLANG_BIN_PATH${PATH:+:${PATH}}
```

- **If you want to use other `Clang` (e.g. `llvm 9.0.0`) for PPCG, even you already have another `Clang` (e.g. `llvm 16.0.6`) configured in your `~/.bashrc` or `~/.profile`**
Assume you have already `llvm 16.0.6` build & configured in `~/.profile`. Now you want use another `llvm` version (e.g. `llvm 9.0.0` setup in ) for `pet` in PPCG.
Then push the following snippet in your `~/.profile`. If you donot do this, when you run `./installation/bin/polycc input_code.c`, you will get error like `error while loading shared libraries: libclang-cpp.so.16git: cannot open shared object file: No such file or directory`

```sh
# Already defined config for llvm 16.0.6
export LLVM_FOLDER_NAME="llvm-16-src-build"
#.....
#....

# ADD THE FOLLOWINGs for llvm 9.0.0
LLVM_FOR_PET_INSTALLATION_ROOT=/abs/path/to/your/llvm-9-src-build/installation
LLVM_FOR_PET_LIB_PATH=$LLVM_FOR_PET_INSTALLATION_ROOT/lib
export LD_LIBRARY_PATH=$LLVM_FOR_PET_LIB_PATH${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```



## 2. Installing PPCG

### 2.1. `clone` PPCG and `checkout` the branch `how-to-setup-ppcg`

- **Donot use `--recursive`**.

```sh
git clone https://github.com/pal-stdr/ppcg-forked.git ppcg-with-llvm-16
```

- Checkout the branch `how-to-setup-ppcg`
- **Donot work w/ the `master` branch.**

```sh
git checkout how-to-setup-ppcg
```

### 2.2. Now load all the `submodules` (i.e. `pet`, `isl`, `imath`)

Better do it with the `get_submodules.sh`

```sh
./get_submodules.sh
```

If you want to handle them manually, following commands will be useful (Optional)

```sh
# For loading other libs (isl, pet) nested inside ppcg
git submodule update --init

# Then load "imath" submodule for isl
cd isl
git submodule init imath
git submodule update imath
```


### 2.3. Run the `autogen.sh` to generate `configure` script for each of the submodule

```sh
./autogen.sh
```



### 2.4. Collect your `--with-clang-prefix=` path for PPCG

Considering the first example `Clang` setup in `~/.profile`, let's assume, the path is `/path/to/your/llvm-16-src-build/installation` or `/path/to/your/llvm-16-src-build/build`. At `/path/to/your/llvm-16-src-build/installation` dir, you should see similar to following folder structure

```sh
├── installation
│   ├── bin
│   ├── examples
│   ├── include
│   ├── lib
│   ├── libexec
│   └── share
```



### 2.5. Prepare the following `shell` script for installing PPCG

- We assume, you have chosen the forked copy for cloning. The following `shell` can be found here [`build-ppcg-with-llvm.sh`](../../build-ppcg-with-llvm.sh)

- Please run `build-ppcg-with-llvm.sh` from the root of PPCG.

**How this shell works?**
1. It checks if you want to do `configure + make` or only `make`. This options are handy if you donot change your respective `configure.ac` and `Makefile.am` from different libs.
2. While `make` runs, it builds in separate `build/` dir in the ppcg root. Keeps the code clean. You can change the dir name/path.
3. `make install` ensures you have the final build assets in separate `installation/` dir w.r.t ppcg root pointed by `--prefix` path in `configure` command. You can change the dir name/path.
4. `pet` lib inside ppcg expects `Clang`. The `build` or `prefix` path of `Clang` should be passed in `LLVM_FOR_PET_INSTALLATION_ROOT` shell var in the script. **SUPER MANDATORY**.

```sh
#!/bin/bash

# IF YOU WANT TO BUILD ONLY, SET IT TO 0
# IF YOU WANT TO CONFIGURE + BUILD, THEN SET IT TO 1
WANT_TO_CONFIGURE_AND_BUILD=1


# DONOT CHANGE IT.
# If you set "WANT_TO_CONFIGURE_AND_BUILD" to "1", by default "WANT_TO_BUILD_ONLY" will be set to "1"
WANT_TO_BUILD_ONLY=$([ $WANT_TO_CONFIGURE_AND_BUILD -eq 0 ] && echo 1 || echo 0)




# Setup the Clang dependency ENV vars for pet (MANDATORY)
# "LLVM_FOR_PET_INSTALLATION_ROOT" set this to LLVM 16 build or installation path
LLVM_FOR_PET_INSTALLATION_ROOT=/path/to/your/llvm-16-src-build/installation

# If you already have another Clang version in your machine, and you are using another "clang" version, you need to keep this part.
LLVM_FOR_PET_LIB_PATH=$LLVM_FOR_PET_INSTALLATION_ROOT/lib
export LD_LIBRARY_PATH=$LLVM_FOR_PET_LIB_PATH${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}




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
'
```

### 2.6. Update the `build-ppcg-with-llvm.sh` with proper `WANT_TO_CONFIGURE_AND_BUILD=[0|1]` settings

**IMPORTANT:**
- **FOR THE `VERY FIRST TIME`, YOU HAVE TO RUN IT WITH `WANT_TO_CONFIGURE_AND_BUILD=1`. Means, it will gen `Makefile` by reading `configure` files from each submodules. And then run the actual build process (i.e. compilation).**

```sh
# One time
chmod +x build-ppcg-with-llvm.sh

# Then run (w/ WANT_TO_CONFIGURE_AND_BUILD=1)
./build-ppcg-with-llvm.sh
```



### 2.7. Once you configured, you can set `WANT_TO_CONFIGURE_AND_BUILD=0` just to start play with code 🤠

Assume, you already have configured + generated the build settings (i.e. `Makefile`) in step **2.1.**. So now you can start play with code, and just compile again and again with `WANT_TO_CONFIGURE_AND_BUILD=0` settings. 😇

```sh
# run (w/ WANT_TO_CONFIGURE_AND_BUILD=0)
# Just change PPCG code and Run the script again and again only to compile
./build-ppcg-with-llvm.sh
```

### 2.8. If you want to cleanup all the autogenerated config files by the `./config` command (Optional)

- [`cleanup.sh`](../../cleanup.sh) will remove all the `./config` command generated files + folders from the project root & submodules. (e.g. `autoconf/`, `autom4te.cache/`, `m4/libtool.m4`, etc.). That means, you donot have to do a `git clone` again for a clean build.

```sh
./cleanup.sh
```

### 2.9. If you want to automate the whole process (Optional, `cleanup old config => gen new configs => configure => build`)**

[`automate.sh`](../../automate.sh) good for reconfiguring the build setup. is good for reconfiguring the build setup.
```sh
./automate.sh

# Inside the "automate.sh"
# echo "Cleaning up old automake configs\n"
# ./cleanup.sh

# echo "Now running core autogen.h\n"
# ./autogen.sh

# echo "Now running core ./build-ppcg-with-llvm.sh\n"
# ./build-ppcg-with-llvm.sh
```


## 3. How to use `PPCG`

Though the `--prefix=` is set to `ppcg-forked/installation`, so the bins can be found in `./installation/bin/` dir

### 3.1. Using `ppcg` bin (The idea)

- Usage format `ppcg --target=cuda [c|cuda|opencl] <input.c> -o <output.c>`. Example `./installation/bin/ppcg tests/matmul.c -o test/transformed_matmul.c`

### 3.2. Using `ppcg` bin (w/ `--target=cuda`)

- It will always dump the generated files in project-root dir. We can't control the dumping with `-o dir/`

```sh
./installation/bin/ppcg --target=cuda tests/matmul.c

# returns
matmul_host.cu
matmul_kernel.cu
matmul_kernel.hu
```

- you can remove them using following command
```sh
rm *_host.* *_kernel.*
```


### 3.3. Using `ppcg` bin (w/ `--target=opencl`)

- It will always dump the generated files in project-root dir. We can't control the dumping with `-o dir/`

```sh
./installation/bin/ppcg --target=opencl tests/matmul.c

# returns
matmul_host.c
matmul_kernel.cl
```

- you can remove them using following command
```sh
rm *_host.* *_kernel.*
```


### 3.4. Using `ppcg` bin (w/ `--target=c`)

- It can dump the generated file in project-root dir. Typical generated `cpu` code ends up with `.ppcg.c` extension.
- We can also control the dumping with `-o dir/` 

```sh
./installation/bin/ppcg --target=c tests/matmul.c
# returns
matmul.ppcg.c

./installation/bin/ppcg --target=c tests/matmul.c -o tests/matmul_cpu_version.c
# returns
tests/matmul_cpu_version.c
```

- you can remove the autogenerated file using following command
```sh
rm *.ppcg.*
```



### 3.5. Some of the `flags` for `ppcg`

- For details check [ChangeLog](../../ChangeLog)

```sh
version: 0.09.1
date: Sun Apr  2 02:17:15 PM CEST 2023
changes:
	- support recent versions of clang
---
version: 0.09
date: Sat 02 Jul 2022 04:11:56 PM CEST
changes:
	- try and shift bands to the origin before tiling
	- try and remove strides in bands before tiling
	- avoid mapping some nested non-permutable bands to the device
---
version: 0.08.3
date: Wed Nov 13 11:39:01 CET 2019
changes:
	- support recent versions of clang
	- fix OpenMP support when contraction is enabled
---
version: 0.08.1
date: Mon Jul 30 23:05:04 CEST 2018
changes:
	- move some functionality to isl
---
version: 0.07
date: Tue Feb  7 17:23:22 CET 2017
changes:
	- support hybrid tiling
---
version: 0.06
date: Fri May  6 12:08:50 CEST 2016
changes:
	- use PPCG specific macro names in generated code
	- complete transition to schedule trees
	- maximize coincidence by default
	- map arrays with constant index expressions to private memory
	- optionally group chains of statements
---
version: 0.05
date: Fri Jan 15 09:30:23 CET 2016
changes:
	- fix live-out computation
	- optionally compute schedule for C target
	- optionally perform tiling for C target
	- create single kernel for non-permutable subtree
---
version: 0.04
date: Wed Jun 17 10:52:58 CEST 2015
changes:
	- use schedule trees
	- fix live-range reordering
	- improve generation of synchronization
	- exploit independences during dependence analysis
```

- Available `flags`

```sh
Usage: ppcg [OPTION...] input

  -o <filename>               output filename (c and opencl targets)

 debugging options
      --dump-schedule-constraints
                              dump schedule constraints [default: no]
      --dump-schedule         dump isl computed schedule [default: no]
      --dump-final-schedule   dump PPCG computed schedule [default: no]
      --dump-sizes            dump effectively used per kernel tile, grid
                              and block sizes [default: no]
  -v, --verbose               [default: no]

 ppcg options
      --no-group-chains       group chains of interdependent statements
                              that are executed consecutively in the
                              original schedule before scheduling
                              [default: yes]
      --no-reschedule         replace original schedule by isl computed
                              schedule [default: yes]
      --no-scale-tile-loops   [default: yes]
      --no-wrap               [default: yes]
      --no-shared-memory      use shared memory in kernel code [default: yes]
      --no-private-memory     use private memory in kernel code [default: yes]
      --ctx=<context>         Constraints on parameters
      --assume-non-negative-parameters
                              assume all parameters are non-negative)
                              [default: no]
      --tile                  perform tiling (C target) [default: no]
  -S, --tile-size=<size>      [default: 32]
      --isolate-full-tiles    isolate full tiles from partial tiles
                              (hybrid tiling) [default: no]
      --sizes=<sizes>         Per kernel tile, grid and block sizes
      --max-shared-memory=<size>
                              maximal amount of shared memory [default: 8192]
      --openmp                Generate OpenMP macros (only for C target)
                              [default: no]
      --target=c|cuda|opencl  the target to generate code for [default: cuda]
      --no-linearize-device-arrays
                              linearize all device arrays, even those of
                              fixed size [default: yes]
      --no-allow-gnu-extensions
                              allow the use of GNU extensions in generated
                              code [default: yes]
      --no-live-range-reordering
                              allow successive live ranges on the same
                              memory element to be reordered [default: yes]
      --hybrid                apply hybrid tiling whenever a suitable
                              input pattern is found (GPU targets)
                              [default: no]
      --unroll-copy-shared    unroll code for copying to/from shared memory
                              [default: no]
      --unroll-gpu-tile       unroll code inside tile on GPU targets
                              [default: no]
      --save-schedule=<file>  save isl computed schedule to <file>
      --load-schedule=<file>  load schedule from <file>, using it instead
                              of an isl computed schedule

 isl options
      --isl-context=gbr|lexmin
                              how to handle the pip context tableau
                              [default: gbr]
      --isl-gbr=never|once|always
                              how often to use generalized basis reduction
                              [default: always]
      --isl-closure=isl|box   closure operation to use [default: isl]
      --isl-gbr-only-first    only perform basis reduction in first
                              direction [default: no]
      --isl-bound=bernstein|range
                              algorithm to use for computing bounds
                              [default: bernstein]
      --isl-on-error=warn|continue|abort
                              how to react if an error is detected
                              [default: warn]
      --isl-bernstein-recurse=none|factors|intervals|full
                              [default: factors]
      --no-isl-bernstein-triangulate
                              triangulate domains during Bernstein
                              expansion [default: yes]
      --no-isl-pip-symmetry   detect simple symmetries in PIP input
                              [default: yes]
      --isl-convex-hull=wrap|fm
                              convex hull algorithm to use [default: wrap]
      --no-isl-coalesce-bounded-wrapping
                              bound wrapping during coalescing [default: yes]
      --isl-coalesce-preserve-locals
                              preserve local variables during coalescing
                              [default: no]
      --isl-schedule-max-coefficient=<limit>
                              Only consider schedules where the
                              coefficients of the variable and parameter
                              dimensions do not exceed <limit>. A value of
                              -1 allows arbitrary coefficients. [default: -1]
      --isl-schedule-max-constant-term=<limit>
                              Only consider schedules where the
                              coefficients of the constant dimension do
                              not exceed <limit>. A value of -1 allows
                              arbitrary coefficients. [default: -1]
      --no-isl-schedule-parametric
                              construct possibly parametric schedules
                              [default: yes]
      --no-isl-schedule-outer-coincidence
                              try to construct schedules where the outer
                              member of each band satisfies the
                              coincidence constraints [default: yes]
      --no-isl-schedule-maximize-band-depth
                              maximize the number of scheduling dimensions
                              in a band [default: yes]
      --no-isl-schedule-maximize-coincidence
                              maximize the number of coincident dimensions
                              in a band [default: yes]
      --no-isl-schedule-split-scaled
                              split non-tilable bands with scaled schedules
                              [default: yes]
      --no-isl-schedule-treat-coalescing
                              try and prevent or adjust schedules that
                              perform loop coalescing [default: yes]
      --no-isl-schedule-separate-components
                              separate components in dependence graph
                              [default: yes]
      --isl-schedule-whole-component
                              try and compute schedule for entire
                              component first [default: no]
      --isl-schedule-algorithm=isl|feautrier
                              scheduling algorithm to use [default: isl]
      --no-isl-schedule-carry-self-first
                              try and carry self-dependences first
                              [default: yes]
      --isl-schedule-serialize-sccs
                              serialize strongly connected components in
                              dependence graph [default: no]
      --no-isl-tile-scale-tile-loops
                              scale tile loops [default: yes]
      --no-isl-tile-shift-point-loops
                              shift point loops to start at zero
                              [default: yes]
      --isl-ast-iterator-type=<type>
                              type used for iterators during printing of
                              AST [default: int]
      --isl-ast-always-print-block
                              print for and if bodies as a block
                              regardless of the number of statements in
                              the body [default: no]
      --no-isl-ast-print-outermost-block
                              print outermost block node as a block
                              [default: yes]
      --no-isl-ast-print-macro-once
                              only print macro definitions once [default: yes]
      --no-isl-ast-build-atomic-upper-bound
                              generate atomic upper bounds [default: yes]
      --no-isl-ast-build-prefer-pdiv
                              prefer pdiv operation over fdiv [default: yes]
      --no-isl-ast-build-detect-min-max
                              detect min/max expressions [default: yes]
      --no-isl-ast-build-exploit-nested-bounds
                              simplify conditions based on bounds of
                              nested for loops [default: yes]
      --isl-ast-build-group-coscheduled
                              keep coscheduled domain elements together
                              [default: no]
      --isl-ast-build-separation-bounds=explicit|implicit
                              bounds to use during separation
                              [default: explicit]
      --no-isl-ast-build-scale-strides
                              allow iterators of strided loops to be
                              scaled down [default: yes]
      --no-isl-ast-build-allow-else
                              generate if statements with else branches
                              [default: yes]
      --no-isl-ast-build-allow-or
                              generate if conditions with disjunctions
                              [default: yes]
      --isl-print-stats       print statistics for every isl_ctx [default: no]
      --isl-max-operations=ulong
                              default number of maximal operations per
                              isl_ctx

 pet options
      --pet-autodetect        [default: no]
      --no-pet-detect-conditional-assignment
                              [default: yes]
      --no-pet-encapsulate-dynamic-control
                              encapsulate all dynamic control in macro
                              statements [default: yes]
      --no-pet-pencil         support pencil builtins and pragmas
                              [default: yes]
      --pet-signed-overflow=avoid|ignore
                              how to handle signed overflows [default: avoid]
  -I, --pet-include-path=<path>
  -D <macro[=defn]>
```