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
