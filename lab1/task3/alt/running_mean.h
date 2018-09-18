/*!
 * @file
 *
 * @brief This file contains declarations for the running mean filter's functions/data structures
 *
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date Feb 10, 2018
 *
 * running_mean.h contains data structure/function declaration necessary or helpful
 * to perform the running mean computations. The function init_running_mean begins
 * the process by populating an inter-calculation structure (calc_data) with a
 * data buffer, the blocksize, and the mean range. It also tracks the most recently
 * allocated memory block for the output blocks of the calc_running_mean function,
 * to prevent a memory leak.
 *
 * The calc_running_mean function performs the actual running mean computations
 * on given input data blocks, using the calc_data structure to access needed
 * data from the previous block computation and store new data. Finally, the
 * end_running_mean function frees up any memory that is still in use.
 *
 * process_running_mean is a quality-of-life function allows performs chunks
 * arbitrarily large data buffers and passes the chunks through successive
 * computations, allowing large data sets to be tested against the aforementioned
 * functions with less headache.
 */

#ifndef RUNNING_MEAN_H
#define RUNNING_MEAN_H

/*!
 * @brief This structure contains parameters/data which must be preserved between block computations
 */
struct calc_data {
	float *previous;	//!< Buffer of the last M in the most recent input block
	int blocksize; 		//!< The sample size of the data blocks
	int M;						//!< The range of recent samples to compute the running mean over
	float *output; 		//!< Pointer tracking the most recent output buffer. Free'd after
										//!< each block to prevent a memory leak.
};

/*!
 * @brief Initialize the running mean system
 *
 * This function will allocate the calc_data structure which needs to be preserved
 * across block calculations. The buffer of previous values is zero initialized.
 * This function should be called once, before any calls to calc_running_mean.
 *
 * @param[in] M					The range of recent samples to compute the running mean over
 * @param[in] blocksize The sample size of the data blocks
 *
 * @returns 						The function returns the fully allocated calc_data structure to be
 * 											used by successive calls to calc_running_mean.
 */
struct calc_data *init_running_mean(
	int M,					// The running mean range
	int blocksize 	// The data block size
);

/*!
 * @brief Perform running mean computations on a data block
 *
 * This function will perform running mean calculations on the
 * passed data block. It will use parameters from the passed
 * calc_data block to determine blocksize and mean range.
 * The input data block will be read over the entire blocksize,
 * and it is the caller's responsibility to ensure that data block
 * is valid over at least one block's worth of range. Any necessary
 * values which predate those in the data block will be retrieved from
 * the previous values buffer in the calc_data structure.
 *
 * Calling this function allocates memory for the output block, and frees the
 * memory allocated for the output block of the previous call to calc_running_mean.
 * It is the caller's responsibility to save or use output data from this function
 * before a subsequent call to calc_running_mean is completed.
 *
 * @param[in] x			Pointer to a block of input data
 * @param[in] s			Pointer to the calc_data structure for this running mean system
 *
 * @returns					The function returns a pointer to a fully populated output data
 *									block. Immediately prior to returning, it saves a pointer to this
 *									data block in the calc_data structure and frees the memory allocated
 *									during the last call of this function.
 */
void calc_running_mean(
	float *x,							// Pointer to the input data block
	float *y,
	struct calc_data *s 	// Pointer
);

/*!
 * @brief Clean up memory reserved by the running mean system
 *
 * This function cleans up any memory reserved by the running mean system.
 * The previous input value buffer stored by the calc_data structure is free'd,
 * along with the last remaining output block buffer created by the calc_running_mean
 * function. Finally, the calc_data structure itself is free'd.
 *
 * @param[in] s		Pointer to the calc_data structure for the running mean system
 *								which is being terminated
 *
 * @returns 			After this function returns, all memory allocated by the running
 *							  mean system has been free'd
 */
void end_running_mean(
	struct calc_data *s		// Pointer to the system's calc_data structure
);

/*!
 * @brief Pass an arbitrarily large data-set through the running mean system
 *
 * This function initializes a running mean filter with the given parameters,
 * then passes the input data buffer through successive calls to the calc_running_mean
 * function until the entire buffer has been filtered. Output data is stored in the given
 * output buffer. It is the responsibility of the caller to ensure that the input and
 * output buffers both have size equaling the size passed to this function.
 *
 * @param[in]			x					Pointer to a buffer of input data values
 * @param[in,out] y					Pointer to a buffer in which the output data values should
 *													be stored. Any prexisiting values in this buffer will be destroyed
 * @param[in]			size			The number of elements in both the input and output buffers
 *													(x and y respectively)
 * @param[in]			blocksize	The desired block size into which the input data should be
 *													chunked during computation
 * @param[in]			M					The range of previous samples the running mean should include
 *
 * @returns				Once this function returns, the output buffer y will contain
 *								the output data values after filtering. Data at each index
 *								of the buffer corresponds to the input data at the same index
 *								in the input buffer x.
 */
/*
void process_running_mean(
	float *x,	// Input buffer
	float *y,	// Output buffer
	int size,	// Size of buffers
	int blocksize,	// Blocksize
	int M						// Running mean size
);
*/

#endif
