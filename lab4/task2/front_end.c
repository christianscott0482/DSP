/*
 * @file front_end.c
 * @brief Lab 4 receiver front end implementation.
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date Mar 25, 2018
 */

#include "stm32l4xx_hal.h"
#include "stm32l476g_discovery.h"

#include "ece486.h"
#include "ece486_biquad.h"
#include "ece486_IQ_mixer.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

extern FlagStatus KeyPressed;   // Use to detect button presses

int main(void)
{
  int nsamp;
  float *input, *output_real, *output_imag;

  static float biquad_coefs[] = {
    1,	1.8316,	1,	-1.7181,	0.76535
  };

  /*
   * Set up ADCs, DACs, GPIO, Clocks, DMAs, and Timer
   *
   * If your discovery board has been modified to support the external
   * HSE reference, use the (better quality crystal controlled) HSE
   * configuration.  If not, you can use the MSI reference, and things
   * should still work -- but your clocks will drift over time.
   *
   * The MSI (Medium speed internal) reference is the on-chip RC oscillator
   */
  initialize_ece486(FS_50K, MONO_IN, STEREO_OUT, MSI_INTERNAL_RC);


  /*
   * Allocate Required Memory
   */
  nsamp = getblocksize();

  input = (float *)malloc(sizeof(float)*nsamp);
  output_real = (float *)malloc(sizeof(float)*nsamp);
  output_imag = (float *)malloc(sizeof(float)*nsamp);

  if (input==NULL || output_real==NULL || output_imag==NULL) {
    flagerror(MEMORY_ALLOCATION_ERROR);
    while(1);
  }

  /*
   * Filter/mixer initialization
   */
   IQ_MIXER_T *mixer = init_IQ_mixer((12e+3*(3.14159)*2)/50e+3);
   BIQUAD_T *lowpass_real = init_biquad(1, 0.11631, biquad_coefs, nsamp);
   BIQUAD_T *lowpass_imag = init_biquad(1, 0.11631, biquad_coefs, nsamp);


  while(1){
    /*
     * Ask for a block of ADC samples to be put into the working buffer
     *   getblock() will wait here until the input buffer is filled...  On return
     *   we work on the new data buffer... then return here to wait for
     *   the next block
     */
    getblock(input);

    /*
     * signal processing code to calculate the required output buffers
     */
     
    DIGITAL_IO_SET(); 	// Use a scope on PD0 to measure execution time

    calc_IQ_mixer(mixer, input, output_real, output_imag, nsamp);   // Mix the input signal down to a low freq band
    calc_biquad(lowpass_real, output_real, output_real);            // Filter real portion
    calc_biquad(lowpass_imag, output_imag, output_imag);            // Filter imaginary portion

    DIGITAL_IO_RESET();	// (falling edge....  done processing data )

    /*
     * pass the processed working buffer back for DAC output
     */
    putblockstereo(output_real,output_imag);

  }
  destroy_biquad(lowpass_real);
  destroy_biquad(lowpass_imag);
  destroy_IQ_mixer(mixer);

}
