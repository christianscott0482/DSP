/*
 *
 * @file filter.c
 * @brief functionality to define a filter for our doppler radar reciever.
 *	Modularized for convenience of the entire lab group.
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 * @author Hunter Smith
 *
 * @date Apr 21, 2018
 */


#include "ece486.h"
#include "filter.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "arm_math.h"

arm_biquad_cascade_df2T_instance_f32 make_filter()
{

	float gain1 = 0.13746;;
	float gain2 = 0.0047927;
	float *coeffs = (float *)malloc(sizeof(float)*10);

	arm_biquad_cascade_df2T_instance_f32 S;

	coeffs[0] = 1*gain1;
	coeffs[1] = 0.37539*gain1;
	coeffs[2] = 1*gain1;
	coeffs[3] = 1.7845;
	coeffs[4] = -0.80569;

	coeffs[5] = 1*gain2;
	coeffs[6] = -1.1807*gain2;
	coeffs[7] = 1*gain2;
	coeffs[8] = 1.8555;
	coeffs[9] = -0.91957;

	float *state = (float *)calloc(4, sizeof(float));

	arm_biquad_cascade_df2T_init_f32(&S, 2, coeffs, state);

	return S;
}
