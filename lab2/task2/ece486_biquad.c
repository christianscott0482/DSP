/*!
 * @file ece486_biquad.c
 *
 * @brief IIR filter using cascaded second order biquadratic filters.
 *
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date Feb 25, 2018
 *
 * Source file for the ECE486 Lab 2 IIR filter biquad implementation. For more
 * information on how to use this, see ece486_biquad.h.
 */
#include "ece486_biquad.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

BIQUAD_T *init_biquad(int sections, float g, float *biquad_coefs, int blocksize)
{
  // Allocate space for a BIQUAD parameter structure
  BIQUAD_T *filter;
  filter = (BIQUAD_T *)malloc(sizeof(BIQUAD_T));

  // Save parameters
  filter->G = g;
  filter->M = blocksize;
  filter->sections = sections;

  // We need to store one previous value of v1 and v2 for each filter section
  filter->v1 = (float *)calloc(sections, sizeof(float));
  filter->v2 = (float *)calloc(sections, sizeof(float));

  // Copy over the coefficients. For each section there should be 5 coefficients
  filter->coefs = (float *)malloc(5 * sections * sizeof(float));
  memcpy(filter->coefs, biquad_coefs, 5 * sections * sizeof(float));

  return filter;
}

void calc_biquad(BIQUAD_T *s, float *x, float *y)
{
  int i = 0;          // Loop index
  int j = 0;          // Loop index
  float v1_prev = 0;  // Previous value of v_1
  float v2_prev = 0;  // Previous value of v_2
  float x_cur = 0;    // Buffer to save the current value of x, before it
                      // is overwritten

  // Begin with the gain stage
  for (i = 0; i < s->M; i++) {
    y[i] = x[i] * s->G;
  }

  // Iterate through each filter
  for (i = 0; i < s->sections; i++) {

    // For the first element, previous intermediary values from the filter
    // structure s will need to be used
    x_cur   = y[0];
    y[0]    = s->v1[i] + (s->coefs[i*5+0] * x_cur);
    v1_prev = s->v2[i] - (s->coefs[i*5+3] * y[0]) + (s->coefs[i*5+1] * x_cur);
    v2_prev = (s->coefs[i*5+2] * x_cur) - (s->coefs[i*5+4] * y[0]);

    // Iterate through each element
    for (j = 1; j < s->M; j++) {
      x_cur   = y[j];
      y[j]    = v1_prev + (s->coefs[i*5+0] * x_cur);
      v1_prev = v2_prev - (s->coefs[i*5+3] * y[j]) + (s->coefs[i*5+1] * x_cur);
      v2_prev = (s->coefs[i*5+2] * x_cur) - (s->coefs[i*5+4] * y[j]);
    }

    // Save the last intermediary values for use in future calls to this function
    s->v1[i] = v1_prev;
    s->v2[i] = v2_prev;
  }

  return;
}

void destroy_biquad(BIQUAD_T *s)
{
  // Free previously allocated memory
  free(s->v1);
  free(s->v2);
  free(s->coefs);
  free(s);

  return;
}
