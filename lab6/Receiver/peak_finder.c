#include "peak_finder.h"

int find_peak(float *fft_input, float Fs, int fft_N)
{
  int i = 0;                  // Loop index
  float noise_floor = 0.1;  // Noise floor
  int peak_i = 0;

  // The area of interest is up to 2kHz, anything beyond the index corresponding
  // to that can be safely ignored
  int max_i = (2e+3 * fft_N) / Fs;

	//return index of sample where peak is located
	for(i = 0; i < max_i; i++){
    if(fft_input[i] > noise_floor) {
      peak_i = i;
    }
	}

	return peak_i;
}
