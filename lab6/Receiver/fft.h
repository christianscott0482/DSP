/*!
 * @file fft.h
 *
 * @ brief FFT functions for use with the Doppler Receiver.
 *
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 * @author Hunter Smith
 *
 * @date April 28, 2018
 *
 * @defgroup fft.h Function Interface Requirements for ECE 486 Lab 6 fft function.
 *	@{
 * FFT functions for the Doppler Receiver. Makes use of the Complex FFT functions
 * from the CMSIS library to calculate the FFT of a complex input
 */
#ifndef FFT_H
#define FFT_H

#include "stm32l4xx_hal.h"
#include "stm32l476g_discovery.h"

/*!
 * @brief fft_size enumeration of valid FFT sizes, for use with the CMSIS library
 * Valid sizes range from 16 to 4096 in powers of 2.
 */
typedef enum fft_size {
  FFT_SIZE_16   = 16,
  FFT_SIZE_32   = 32,
  FFT_SIZE_64   = 64,
  FFT_SIZE_128  = 128,
  FFT_SIZE_256  = 256,
  FFT_SIZE_512  = 512,
  FFT_SIZE_1024 = 1024,
  FFT_SIZE_2048 = 2048,
  FFT_SIZE_4096 = 4096
} fft_size;

/*!
 * @brief FFT_T structure contains data pertinent to the CFFT routine from the
 * CMSIS library
 */
typedef struct fft_instance {
  const arm_cfft_instance_f32 *cfft;  //!< Pointer to a predefined CMSIS CFFT structure
  int N;                              //!< Size of the FFT
} FFT_T;

/*!
 * @brief Initialization function for the CFFT routines.
 *
 * @returns Pointer to an initialized structure of type #FFT_T
 */
FFT_T *init_fft(
  fft_size N     //!< [in] FFT size. Valid options are members of the fft_size enumeration
);

/*!
 * @brief Calculation function for the CFFT routines. Allocation of the input and
 * output buffers is the caller's responsibility.
 *
 * @returns The magnitude of the FFT is placed in the output buffer after
 * each call.
 */
void calc_fft(
  FFT_T *fft,       //!< [in] Pointer to an FFT_T structure to perform the FFT
  float *input_cpx, //!< [in] Input buffer of complex samples. Must have size N*2, from init_fft()
  float *output     //!< [out] Output buffer of FFT magnitudes.
);

/*!
 * @brief Cleanup function for the FFT routines. Frees memory used by the
 * FFT structure.
 */
void destroy_fft(
  FFT_T *fft
);

#endif
