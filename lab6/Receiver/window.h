/*!
 * @file window.h
 * 
 * @ brief A header file defining several windowing function implomentations.
 * 
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 * @author Hunter Smith
 *
 * @date April 28, 2018
 *
 */

#ifndef WINDOW_H
#define WINDOW_H

/*!
 * @brief Initializes an array of windowing elements and storing the elements of the
 *	  array in memory for later use by refrencing the returned stack pointer.
 *
 * @returns Pointer to an initialized windowing array.
 */

float *init_window_blackman_harris(
		float N,						//!< [in] Size of the calculated window function.
		int blocksize					//!< [in] Number of samples in each output block.
);

/*!
 * @brief Initializes an array of windowing elements and storing the elements of the
 *	  array in memory for later use by refrencing the returned stack pointer.
 *
 * @returns Pointer to an initialized windowing array.
 */

float *init_window_hamming(
		float N,						//!< [in] Size of the calculated window function.
		int blocksize					//!< [in] Number of samples in each output block.
);


#endif
