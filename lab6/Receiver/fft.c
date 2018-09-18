#include "stm32l4xx_hal.h"
#include "stm32l476g_discovery.h"

#include "ece486.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "arm_math.h"
#include "arm_const_structs.h"
#include "fft.h"

FFT_T *init_fft(fft_size N) {

  // Allocate space for an FFT parameter structure
  FFT_T *fft;
  fft = (FFT_T *)malloc(sizeof(FFT_T));

  // Save the correct CMSIS FFT structure
  switch(N) {
    case FFT_SIZE_16:
      fft->cfft = &arm_cfft_sR_f32_len16;
      fft->N = 16;
      break;
    case FFT_SIZE_32:
      fft->cfft = &arm_cfft_sR_f32_len32;
      fft->N = 32;
      break;
    case FFT_SIZE_64:
      fft->cfft = &arm_cfft_sR_f32_len64;
      fft->N = 64;
      break;
    case FFT_SIZE_128:
      fft->cfft = &arm_cfft_sR_f32_len128;
      fft->N = 128;
      break;
    case FFT_SIZE_256:
      fft->cfft = &arm_cfft_sR_f32_len256;
      fft->N = 256;
      break;
    case FFT_SIZE_512:
      fft->cfft = &arm_cfft_sR_f32_len512;
      fft->N = 512;
      break;
    case FFT_SIZE_1024:
      fft->cfft = &arm_cfft_sR_f32_len1024;
      fft->N = 1024;
      break;
    case FFT_SIZE_2048:
      fft->cfft = &arm_cfft_sR_f32_len2048;
      fft->N = 2048;
      break;
    case FFT_SIZE_4096:
      fft->cfft = &arm_cfft_sR_f32_len4096;
      fft->N = 4096;
      break;
  }

  return fft;
};

void calc_fft(FFT_T *fft, float *input_cpx, float *output) {

  // Perform an FFT on the complex input
  arm_cfft_f32(fft->cfft, input_cpx, 0, 1);

  // Take the complex magnitude
  arm_cmplx_mag_f32(input_cpx, output, fft->N);

  // The magnitude will be A/2 * N times larger than the actual amplitude
  // This needs to be rectified
  int i = 0;
  for (i = 0; i < fft->N; i++) {
    output[i] /= (fft->N / 2);
  }

  return;
};

void destroy_fft(FFT_T *fft) {
  free(fft);
  return;
};
