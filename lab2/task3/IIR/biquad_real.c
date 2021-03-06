/*
 * @file biquad_real.c
 * @brief Test program to illustrate the real time use of the ECE 486 lab 2 task 2 IIR implementation
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date Feb 25, 2018
 */

#include "stm32l4xx_hal.h"
#include "stm32l476g_discovery.h"

#include "ece486.h"
#include "ece486_biquad.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

#define PI 3.14159265

extern FlagStatus KeyPressed;   // Use to detect button presses

int main(void)
{
  int nsamp;
  float *input, *output1;

  // 6th order buttersworth, cutoff @ 1kHz
  float coeff_6[15] = {
    6.15535184731143e-08, 1.23107036946229e-07, 6.15535184731143e-08, -1.76088035719915, 0.776074924387786,
    1, 2, 1, -1.81534108270457, 0.831005589346758,
    1, 2, 1, -1.91809148186724, 0.934642617653399
  };

  // 10th order butterswoth, cutoff @ 5kHz
  float coeff_10[25] = {
    2.38434887547354e-06, 4.76869775094707e-06, 2.38434887547354e-06, -0.990907269678935, 0.249011278272522,
    1, 2, 1, -1.02871886465505, 0.296671750669644,
    1, 2, 1, -1.10922879261842, 0.398152293921440,
    1, 2, 1, -1.24313820595477, 0.566941415408202,
    1, 2, 1, -1.44874121680128, 0.826098338817674
  };

  static float biquad_coefs[] = {
  9.2996906988e-02, -1.1388836447e-17, 9.2996906988e-02, -6.0876347892e-01, 9.7022500000e-01,
  6.7325033993e-01, -7.9145324182e-01, 6.7325033993e-01, 1.4562305899e+00, 8.1000000000e-01,
  2.4290319830e+00, 4.8580639660e+00, 2.4047416632e+00, -3.5000000000e-01, -4.2500000000e-01
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
   *
   * The HSE (High speed external) reference is an external clock, either
   * provided through the external connector, or (if your board is modified)
   * from the crystal reference source generated by the other processor
   * on the development board.
   */
  //initialize_ece486(FS_48K, MONO_IN, STEREO_OUT, MSI_INTERNAL_RC);
  initialize_ece486(FS_50K, MONO_IN, STEREO_OUT, MSI_INTERNAL_RC);
  //initialize(FS_48K, MONO_IN, MONO_OUT);


  /*
   * Allocate Required Memory
   */
  nsamp = getblocksize();

  input = (float *)malloc(sizeof(float)*nsamp);
  output1 = (float *)malloc(sizeof(float)*nsamp);

  if (input==NULL || output1==NULL) {
    flagerror(MEMORY_ALLOCATION_ERROR);
    while(1);
  }

  /*
   * Normally we avoid printf()... especially once we start actually
   * processing streaming samples.  This is here to illustrate the
   * use of printf for debugging programs.
   *
   * To see the printf output, connect to the ST-Link serial port.
   * Use: 115200 8N1
   */
  printf("Starting execution using %d samples per input block.\n",nsamp);

  /*
   * Infinite Loop to process the data stream, "nsamp" samples at a time
   */

  // Initialize 6 coeff filter
  BIQUAD_T *filter_6 = init_biquad(3, 2, coeff_6, nsamp);

  // Initialize 10 coeff filter
  BIQUAD_T *filter_10 = init_biquad(5, 2, coeff_10, nsamp);

  BIQUAD_T *filter_test = init_biquad(3, 5.7324562488e-01, biquad_coefs, nsamp);


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

    calc_biquad(filter_test, input, output1);
    //calc_biquad(filter_10, input, output1);

    DIGITAL_IO_RESET();	// (falling edge....  done processing data )

    /*
     * pass the processed working buffer back for DAC output
     */
    putblockstereo(output1,input);

    /*
    if (KeyPressed) {
	    printf("block size: %d\n",nsamp);
      KeyPressed = RESET;

     //BSP_LCD_GLASS_DisplayString( (uint8_t *)lcd_str);
    //  BSP_LED_Toggle(LED5);
    }
    */
  }
  destroy_biquad(filter_6);   // Release resources utilized by the filter
  destroy_biquad(filter_10);  // ^ ^
  destroy_biquad(filter_test);  // ^ ^

}
