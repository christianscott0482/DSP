#ifndef FILTER_H
#define FILTER_H

#include "stm32l4xx_hal.h"
#include "stm32l476g_discovery.h"
#include "ece486.h"
#include "arm_math.h"

arm_biquad_cascade_df2T_instance_f32 make_filter();

#endif
