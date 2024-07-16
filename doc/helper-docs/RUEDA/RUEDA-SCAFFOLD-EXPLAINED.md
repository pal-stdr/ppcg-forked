# Overview
This document provides an overview of the project structure and describes the purpose and functionality of each file in the project. This project is written in C/C++ and follows a modular structure for better organization and maintainability.



# Current Scaffold `This doc will be updated with time`

```sh
├── include
│   ├── librueda # core librueda headers
│   │   ├── fpga
│   │   │   ├── rueda_fpga.h
│   │   │   └── rueda_fpga_options.h
│   │   ├── gpu
│   │   │   ├── rueda_gpu.h
│   │   │   └── rueda_gpu_options.h
│   │   └── rueda.hpp
│   └── utility.hpp
├── lib
│   ├── fpga
│   │   ├── rueda_fpga.c
│   │   └── rueda_fpga_options.c
│   ├── gpu
│   │   ├── rueda_gpu.c
│   │   ├── rueda_gpu_logger.cpp
│   │   ├── rueda_gpu_logger.hpp
│   │   └── rueda_gpu_options.c
│   ├── rueda.cpp
│   ├── rueda_options.c
│   └── rueda_options.h
├── main.cpp
├── Makefile.am
└── utility.cpp
```


# AFTER THIS, DONOT READ. THEY ARE TRASH

# Entry Point (`i.e. main.cpp`)
This is the entry point of the application. It handles all inputs and outputs. It utilizes the core API functions declared in `include/rueda.h` and implemented in `lib/` dir. It can also call other header files from libs.

## Recommended Practices

1. Handle all inputs & outputs through `main.cpp`.
2. Make the core API calls from `include/rueda.h`
3. Just for test/dev, you can make calls from `lib/*.{h,hpp}` files. But after you're done, don't forget to clean them.
4. Process/manage the options (i.e. options defined in `rueda/rueda_options.h`) from here.

## Not Recommended
1. DONOT DECLARE/DEFINE ANY CORE API FUNCTIONS IN HERE.
2. 


# `include/`

## `include/rueda.h`

This header file contains declarations of the core API functions. These functions are defined in the source files located in the `lib/` directory.

# `lib/`

## `rueda.cpp`
This file contains the implementation of the core API functions declared in `include/rueda.h`.


## `rueda_options.h`
- This header file contains the declarations of the functions implemented/defined in `lib/rueda_options.c`.
- **The GPU & FPGA schedule handling options should be defined here.**



# Where is what?

# [`rueda/main.cpp`](../../main.cpp) file

This is the entry point of the Rueda scheduler.


# The `rueda/lib/` dir






