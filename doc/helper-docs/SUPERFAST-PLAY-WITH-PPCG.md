# How to start playing with PPCG (SUMMARY) 😇

This PPCG is a forked from [https://repo.or.cz/ppcg.git](https://repo.or.cz/ppcg.git) `0.09.1` version (commit `90e21627`). 

## Prerequisites


- **ALL THE DETAILS ARE EXPLAINED in great length HERE [doc/helper-docs/SETUP-PPCG-DETAILS.md](SETUP-PPCG-DETAILS.md)**
```sh
sudo apt-get install build-essential automake autoconf libtool libtool-bin pkg-config libgmp3-dev libyaml-dev
```
- For setting up `clang/llvm`, follow this **1.2. Handling `LLVM/Clang` dependency** section. PPCG version `PPCG 0.09.1` (commit `90e21627`) tested & works for `llvm-9`, `llvm-16`.
- **DONOT WORK w/ THE `master` BRANCH.**


# Setting Up PPCG

## 1. Preparing the working repo (ONE TIME SETUP, cloning stuffs)

```sh
# Donot use `--recursive` w/ `git clone`
git clone https://github.com/pal-stdr/ppcg-forked.git ppcg-forked
cd ppcg-forked/

# or any branch you like except master
git checkout how-to-setup-ppcg
```


## 2. Now load all the `submodules` (i.e. `pet`, `isl`, `imath`)

```sh
./get_submodules.sh

# For loading other libs (isl, pet) nested inside ppcg
git submodule update --init

# Then load "imath" submodule for isl
cd isl
git submodule init imath
git submodule update imath
```

## 3. prepare `build-ppcg-with-llvm.sh` with proper `clang` path

- We need the `LLVM_FOR_PET_INSTALLATION_ROOT=/path/to/your/llvm-16-src-build/installation` path.
- Check the **1.2. Handling `LLVM/Clang` dependency** section from [doc/helper-docs/SETUP-PPCG-DETAILS.md](SETUP-PPCG-DETAILS.md) to know how to build + use `LLVM/Clang`.
- At `/path/to/your/llvm-16-src-build/installation` dir, you should see similar to following folder structure

```sh
├── installation
       ├── bin
       ├── examples
       ├── include
       ├── lib
       ├── libexec
       └── share
```



## 4. Run `autogen.sh` to generate `configure` files for all `submodules` and `ppcg` lib itself

```sh
./autogen.sh
```

## 5. Update the `build-ppcg-with-llvm.sh` with proper `WANT_TO_CONFIGURE_AND_BUILD=[0|1]` settings

### 5.1. FOR THE `VERY FIRST TIME`

- **IMPORTANT: YOU HAVE TO RUN IT WITH `WANT_TO_CONFIGURE_AND_BUILD=1`. Means, it will gen `Makefile` by reading `configure` files from each submodules. And then run the actual build process (i.e. compilation).**

```sh
# One time
chmod +x build-ppcg-with-llvm.sh

# Then run (w/ WANT_TO_CONFIGURE_AND_BUILD=1)
./build-ppcg-with-llvm.sh
```

### 5.2. Once you configured, you can set `WANT_TO_CONFIGURE_AND_BUILD=0` just to start play with code

Assume, you already have configured + generated the build settings (i.e. `Makefile`) in step **5.1.**. So now you can start play with code, and just compile again and again with `WANT_TO_CONFIGURE_AND_BUILD=0` settings. 😇

```sh
# run (w/ WANT_TO_CONFIGURE_AND_BUILD=0)
./build-ppcg-with-llvm.sh
```

### 5.3. If you want to cleanup all the autogenerated config files by the `./config` command (Optional)

- [`cleanup.sh`](../../cleanup.sh) will remove all the `./config` command generated files + folders from the project root & submodules. (e.g. `autoconf/`, `autom4te.cache/`, `m4/libtool.m4`, etc.). That means, you donot have to do a `git clone` again for a clean build.

```sh
./cleanup.sh
```

### 5.4. If you want to automate the whole process (Optional, `cleanup old config => gen new configs => configure => build`)**

[`automate.sh`](../../automate.sh) good for reconfiguring the build setup.
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

## 6. If you want to do the whole process manually without [`build-ppcg-with-llvm.sh`](../../build-ppcg-with-llvm.sh) script

```sh
./get_submodules.sh

./autogen.sh

# "installation/ will be prefix path"
mkdir -p build/ installation/

cd build

../configure --prefix=/abs/path/to/installation --with-clang-prefix=/path/to/your/llvm-16-src-build/installation --enable-static --with-clang=system --cache-file=/dev/null --srcdir=../

make -j$(nproc)

make install
```




## 7. Play with PPCG 🤠

- **I assume, you already configured + build PPCG once w/ `WANT_TO_CONFIGURE_AND_BUILD=1`.**
- **So now set it to `WANT_TO_CONFIGURE_AND_BUILD=0`. This will make sure that you only compile PPCG after changing the actual code each time. 😇**

```sh
# WANT_TO_CONFIGURE_AND_BUILD=0
# Just change PPCG codes and Run the script again and again only to compile
./build-ppcg-with-llvm.sh
```


## 8. How to use `PPCG`

Though the `--prefix=` is set to `ppcg-forked/installation`, so the bins can be found in `./installation/bin/` dir

### 8.1. Using `ppcg` bin (The idea)

- Usage format `ppcg --target=cuda [c|cuda|opencl] <input.c> -o <output.c>`. Example `./installation/bin/ppcg test/matmul.c -o test/transformed_matmul.c`

### 8.2. Using `ppcg` bin (w/ `--target=cuda`)

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


### 8.3. Using `ppcg` bin (w/ `--target=opencl`)

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


### 8.4. Using `ppcg` bin (w/ `--target=c`)

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


### 8.5. `ppcg` [ChangeLog](../../ChangeLog)

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

### 9.6. Some of the `flags` for `ppcg`

- Available `Optimization` flags

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