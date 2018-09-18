

/*!
 * @file ece486_fir.c
 * 
 * @brief Implementation of FIR filter using fixed-length input sample blocks
 * 
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 * 
 * @date Feb 26, 2018
 * 
 * The following the definition of 3 functions: init_fir(), calc_fir(), and destroy_fir().
 * init_fir() returns a pointer to an FIR_T struct, and takes a pointer to a float array
 * of coefficients, the number of those coefficients, and the blocksize of data.
 * calc_fir() takes an input FIR_T object , and pointers to input data and an output 
 * array. The calculated data after going through the filter will be stored in the
 * output data.
 * destroy_fir() takes an FIR_T input, and frees all the data it had previously allocated
 * in memory.
 *
 * 
 */
#include "ece486_fir.h"
#include <stdlib.h>
#include <string.h>

/*
 * @brief FIR filter initialization
 * 
 *  @returns pointer to an initialized structure of type #FIR_T which may
 * be used to calculate the requested filter outputs.
 * 
 * @param[in] fir_coefs Pointer to filter coefficient aray
 * @param[in] n_coef, Total number of filter coefficients
 * @paramp[in] blocksize Block size for input sample blocks
 */
FIR_T *init_fir(float *fir_coefs, int n_coef, int blocksize)
{

  // Allocated memory for the FIR filter structure
  FIR_T *filter;
  filter = (FIR_T *)malloc(sizeof(FIR_T));

  // Store parameters
  filter->M = blocksize;

  // We'll need to store at most M-1 values between input blocks
  filter->previous = (float *)calloc(blocksize - 1, sizeof(float));

  // Make space for an store all n h[n] coefs. If the blocksize is greater than
  // the number of h coefs we receive, we'll need to pad the coefs out with 0's
  if (blocksize > n_coef) {
    filter->h_coefs = (float *)malloc(sizeof(float) * blocksize);
    memcpy(filter->h_coefs, fir_coefs, (n_coef * sizeof(float)));
    memset(&filter->h_coefs[n_coef], 0, (blocksize - n_coef) * sizeof(float));
    filter->n_coefs = blocksize;
  } else {
    filter->h_coefs = (float *)malloc(sizeof(float) * n_coef);
    memcpy(filter->h_coefs, fir_coefs, (n_coef * sizeof(float)));
    filter->n_coefs = n_coef;
  }

  return filter;
};



/*
 * @brief Calculate a block of output samples from an input block sample
 * 
 *  @returns On return, y[i] contains the calculated output samples.
 * (The contents of the structure @a *s are also modified to keep track of the filter state.)
 * 
 * 
 * @param[in,out] s Pointer to previously initialized FIR filter structure,
 * as provided by init_fir() (and possibly modified by previous calls to
 * calc_fir() )
 * @param[in] x pointer to the input sample array
 * @paramp[out] Pointer to an array for storage of output samples
 */
void calc_fir(FIR_T *s, float *x, float *y)
{
  int i = 0;      // Loop index
  int j = 0;      // Loop index
  float sum = 0;  // Sum of the convolution

  // Preform the convolution. Iterate through all of the input block, summing
  // backwards against the coefficients of h[n]. use values from the previous
  // block when the index of x is negative (before the start of the block)
  for (i = 0; i < s->M; i++) {
    sum = 0;
    for (j = 0; j < s->M; j++) {
      if ((i - j) < 0) {
        sum += s->h_coefs[j] * s->previous[s->M + (i - j) - 1];
      } else {
        sum += s->h_coefs[j] * x[i - j];
      }
    }
    y[i] = sum;
  }

  // Save M-1 values from the input
  for (i = 1; i < s->M; i++) {
    s->previous[i - 1] = x[i];
  }

  return;
};

/*
 * @brief Release memory associated with an #FIR_T
 * 
 *  @returns On return, y[i] contains the calculated output samples.
 * 
 * @paramp[in] Pointer to previously initialized FIR filter structure,
 *	       provided by init_fir().
 */
void destroy_fir(FIR_T *s)
{
  // Free all allocated memory
  free(s->previous);
  free(s->h_coefs);
  free(s);

  return;
}
