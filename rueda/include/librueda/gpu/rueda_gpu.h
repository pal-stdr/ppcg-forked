/* Copyright (C) 2024 pallab
 *
 * This software is available under the MIT license. Please see LICENSE_ADDITIONAL in the
 * top-level directory for details.
 *
 * This file is part of librueda.
 * functions are defined in lib/gpu/rueda_gpu.c
 *
 */
#ifndef RUEDA_GPU_H
#define RUEDA_GPU_H


#include <isl/ctx.h>
#include <stdbool.h>
#include <stdint.h>
#include <rueda_gpu_options.h>



#if defined(__cplusplus)
extern "C" {
#endif

void rueda_gpu_schedule(void);
void rueda_gpu_transform(void);


#if defined(__cplusplus)
}
#endif

#endif // RUEDA_GPU_H