/*!
 * @file ece486_biquad.h
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
 * @defgroup ece486_biquad Function Interface Requirements for ECE 486 Lab 2 IIR Filters
 *   @{
 *
 * Implementation of IIR filters using cascaded biquadratic second order filters.
 * Filters can operate on arbitrarily long input datasets by dividing them into
 * fixed size blocks.
 *
 * Filters are initialized by a single call to init_biquad(), which allocates
 * and initializes a filter descriptor structure of type BIQUAD_T
 *
 * @code
 *    #include "ece486_biquad.h"
 *    ...
 *    BIQUAD_T  *filt;
 *    ...
 *    // Define a coefficient vector coefs of size 5*N, where n is the number of
 *    // second order sections in the IIR filter. Select a gain G and a blocksize
 *    // M. Be sure to allocate blocks of memory of size M to hold input/output
 *    // buffers (x, y)
 *    ...
 *    filt = init_biquad(N,G,coefs,M);
 * @endcode
 *
 * Once a filter descriptor is initialized, repeated calls to calc_biquad()
 * provide the filter outputs, where the input samples are provided in fixed
 * length blocks of "blocksize" samples at a time.
 *
 * @code
 *    while( ...input sample blocks are available...) {
 *       // fill the vector x[i] with the next "blocksize" samples from the input sequence.
 *       calc_biquad(filt, x, y);
 *       // do something with the filter output samples y[i].
 *    }
 * @endcode
 *
 * When processing completes, destroy_biquad() should be called to release
 * any allocated memory.
 *
 * @code
 *    destroy_biquad(filt);
 * @endcode
 *
 * @note
 * All input and output vectors (x[i] and y[i]) must be allocated by the caller.
 *
 * @note
 * The input and output arrays MAY point to the same location, in which case the
 * input sequence x[i] is replaced by the output
 * sequence y[i] in the calls to calc_fir().
 *
 */

#ifndef ECE486_BIQUAD_H
#define ECE486_BIQUAD_H

/*
 * Parameter Structure Definitions
 */

/*!
 * @brief BIQUAD filter structure containing coefficients and filter state info
 */
typedef struct biquad_data {
  float *coefs; //!< Vector of filter coefficients for each biquad section. There should be exactly sections * 5 of these.
  float G;      //!< Filter gain factor, applied before any of the biquad stages
  int M;        //!< Data blocksize. Data blocks of this size should be passed to the calculation routine
  float *v1;    //!< Vector of saved intermediary values (v1) for each section of the filter.
  float *v2;    //!< Vector of saved intermediary values (v2) for each section of the filter.
  int sections; //!< Number of sections of biquadratic filters in the full IIR filter. Should equal IIR filter order / 2
} BIQUAD_T;

/*
 * Function Prototypes
 */

/*!
 * @brief BIQUAD IIR filter initialization
 *
 * Call init_biquad() to create and initialize a BIQUAD IIR filter structure.  The
 * input array @a biquad_coefs[i] should contain the coefficients of each biquadratic
 * filter section, in the form [b_10, b_11, b_12, a_11, a_12, b_20, ...], where
 * the number of coefficients is exactly sections * 5.
 *
 * @returns pointer to an initialized structure of type #BIQUAD_T which may
 * be used to calculate the requested filter outputs.
 */
BIQUAD_T *init_biquad(
  int sections,         //!< [in] Number of biquad sections
  float g,              //!< [in] Filter gain factor
  float *biquad_coefs,  //!< [in] Array of biquad section coefficients
  int blocksize         //!< [in] Data block size
);

/*!
 * @brief Calculate a block of output samples of an IIR filter from an input sample block
 *
 * Calling calc_biquad() repeatedly generates the filter output for an arbitrary sequence
 * of input samples.  The IIR filter output samples y(n) for a single biquad
 * section with coefficients {b_10, b_11, b_12, a_11, a_12} are given by:
 * @verbatim
 *    y[n]  = v1[n-1] + (b_10 * x[n])
 *    v1[n] = v2[n-1] - (a_11 * y[n]) + (b_11 * x[n])
 *    v2[n] = (b_12 * x[n]) - (a_12 * y[n])
 * @endverbatim
 * The final output of the IIR filter is obtained by cascading results of each
 * section as the input to the following section.
 * For each call, an input block of samples @a x[i] with length "blocksize" (as specified
 * in init_biquad() ) is processed to generate the corresponding output samples
 * in the output vector @a y[i]. In subsequent calls to calc_biquad(), the
 * new input blocks @a x[i] are assumed to follow the input blocks provided in
 * the previous calls to calc_biquad().  As a result, very long input sequences
 * may be processed by breaking the sequence into many fixed-length blocks of
 * "blocksize" samples.
 *
 * Memory required to store the output vector @a y[i] must be allocated by the
 * caller.
 *
 * \note
 *   @a x and @a y CAN point to the same location.  In this case, the filter output
 *   samples will replace the input sample array.
 *
 * @returns On return, y[i] contains the calculated output samples.
 *  (The contents of the structure @a *s are also modified to keep track of the filter state.)
 *
 * @sa init_biquad()
 */
void calc_biquad(
  BIQUAD_T *s,   //!< [in,out] BIQUAD filter structure, created by init_biquad()
  float *x,      //!< [in] Input buffer of blocksize defined in s
  float *y       //!< [out] Output buffer of blocksize defined in s
);

/*!
 * @brief Release memory associated with an #BIQUAD_T
 */
void destroy_biquad(
  BIQUAD_T *s   //!< Pointer to previous initialized (by init_biquad()) biquad filter structure
);

/*! @} end of ece486_biquad group. */
#endif
