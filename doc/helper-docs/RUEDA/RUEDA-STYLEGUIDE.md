# 1. Setting up header guard in `*.h` files

- **In Every `*.h` files, mandatory to follow the following structure.**

Let's discuss it considering `rueda/include/rueda.h` as an example 

```C

/* Copyright (C) 2024 Name
 *
 * This software is available under the MIT license. Please see LICENSE in the
 * top-level directory for details.
 *
 * This file is part of "libname".
 *
 */
#ifndef RUEDA_H
#define RUEDA_H


#include <isl/ctx.h>
#include <stdbool.h>
#include <stdint.h>

#if defined(__cplusplus)
extern "C" {
#endif

void rueda_schedule();
void rueda_transform();


#if defined(__cplusplus)
}
#endif

#endif // RUEDA_H
```

## 1.1. Header Guard

This prevents the header file from being included multiple times, which can cause redefinition errors.

```C
#ifndef RUEDA_H
#define RUEDA_H

#endif // RUEDA_H
```

## 1.2. `C++` Compatibility

```C
#if defined(__cplusplus)
extern "C" {
#endif

#if defined(__cplusplus)
}
#endif
```

### 1.2.1 `extern "C"`
is used to tell the C++ compiler to use C linkage for the enclosed declarations. This prevents C++ from mangling the function names, making the functions callable from C code or other languages that use C linkage.
### 1.2.2. `if defined(__cplusplus)`
checks if the code is being compiled with a C++ compiler. If so, the extern "C" block is enabled.
