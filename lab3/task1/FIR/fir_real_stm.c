/*
 * @file fir_real_arm.c
 * @brief Test program to demonstrate the speed and effectiveness of the 
 *	STM CMSIS-DSP routines for fir filters.
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date March 19, 2018
 */

#include "stm32l4xx_hal.h"
#include "stm32l476g_discovery.h"

#include "ece486.h"
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "arm_math.h"

extern FlagStatus KeyPressed;   // Use to detect button presses

int main(void)
{
  int nsamp;
  float *input, *output1, *firState;

  arm_fir_instance_f32 S;

  float coeff20[] = {
    -0.000342336674618966,
    0.00286564903170280,
    0.00814944660613902,
    -0.0247347221329598,
    0.00424618882417406,
    -0.0132038890489654,
    0.0820397580099786,
    0.0420232223457450,
    -0.325440978720149,
    0.224931086080090,
    0.224931086080090,
    -0.325440978720149,
    0.0420232223457450,
    0.0820397580099786,
    -0.0132038890489654,
    0.00424618882417406,
    -0.0247347221329598,
    0.00814944660613902,
    0.00286564903170280,
    -0.000342336674618966
  };
  int size20 = 20;
  
  /*
  //float coeff15[] = {
    0.158529111462250,
    0.0380025517098423,
    0.0415045435805081,
    0.0444475095487278,
    0.0468494006221219,
    0.0486887019235402,
    0.0497850185651257,
    0.0502119263743821,
    0.0497850185651257,
    0.0486887019235402,
    0.0468494006221219,
    0.0444475095487278,
    0.0415045435805081,
    0.0380025517098423,
    0.158529111462250
  };
  int size15 = 15;
  */

  /*
  float coeff10[] = {
    -0.0300685057804816,
    -0.103285132848728,
    -0.0949710431098774,
    -0.205304646470360,
    -0.630341784719748,
    0.630341784719748,
    0.205304646470360,
    0.0949710431098774,
    0.103285132848728,
    0.0300685057804816
  };
  int size10 = 10;
  */
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
  initialize_ece486(FS_48K, MONO_IN, STEREO_OUT, MSI_INTERNAL_RC);
  //initialize_ece486(FS_50K, MONO_IN, STEREO_OUT, HSE_EXTERNAL_8MHz);
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

  // Create fir filter structure
  firState =  (float *)malloc(sizeof(float) * (nsamp+size20-1));
  arm_fir_init_f32(&S, size20, coeff20, firState, nsamp);

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

    // calculate filter output
    arm_fir_f32(&S, input, output1, nsamp);
    
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
}
