/* Copyright (C) 2024 pallab
 *
 * This software is available under the MIT license. Please see LICENSE_ADDITIONAL in the
 * top-level directory for details.
 *
 * This file is part of librueda.
 * functions are defined in lib/fpga/rueda_fpga.c
 *
 */
#ifndef RUEDA_FPGA_H
#define RUEDA_FPGA_H


#include <isl/ctx.h>
#include <stdbool.h>
#include <stdint.h>



#if defined(__cplusplus)
extern "C" {
#endif

void rueda_fpga_schedule();
void rueda_fpga_transform();


#if defined(__cplusplus)
}
#endif

#endif // RUEDA_FPGA_H