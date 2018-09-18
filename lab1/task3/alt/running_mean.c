/*!
 * @file
 *
 * @brief This file contains definitions for the functions used by the running mean system
 *
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date Feb 10, 2018
 *
 * This file contains the definitions of all of the running mean filter functions.
 * The init_running_mean functions simply allocates and populates the system's calc_data
 * structure (which will be used in successive calc_running_mean calls) with user
 * passed parameters.
 *
 * The calc_running_mean function iterates through the values of
 * the input block it is passed, at each element forming a sum by iterating backwards
 * and suming a number of elements equal to the mean range. For early input values,
 * input values from previous calc_running_mean calls are retrieved from the calc_data
 * structure. At the end of the function, a number of values equal to the mean range
 * are stored in the calc_data previous input buffer, overwriting any old values.
 *
 * The end_running_mean function simply deallocates any memory held by the calc_data
 * structure. The process_running_mean function allows arbitrarily large data-sets to be
 * operated on by chucking them into blocks and passing them through successive calls
 * to calc_running_mean. All output blocks are consolidated into a single output buffer
 * of the same size as the input buffer
 */

#include <stdlib.h>
#include <string.h>
#include "running_mean.h"

struct calc_data *init_running_mean(int M, int blocksize)
{

	// Allocate space for the calc_data structure
	struct calc_data *s = (struct calc_data *) malloc(sizeof(struct calc_data));

	// Populate the calc_data structure
	// Exactly M-1 Previous values need to be stored, for the worst-case scenario
	// where calc_running_mean is operating on the first input value in a block
	// and needs M-1 more to form a running mean of range M
	s->previous = (float *) calloc(M-1, sizeof(float));
	s->blocksize = blocksize;
	s->M = M;
	s->output = NULL;

	return s;
}

void calc_running_mean(float *x, float *y, struct calc_data *s)
{
	// Loop indices
	int i = 0;
	int j = 0;

	// Buffer for output block. Needs to be accessible after this function returns.
	//float *y = (float *)calloc(s->blocksize, sizeof(float));
	memset(y, 0, s->blocksize);

	// Begin with the sum of the previous M values, prior to the current input
	float sum = 0;
	for (i = 0; i < s->M; i++) {
		sum += s->previous[i];
	}

	// Iterate through every value of the input buffer. At each new element,
	// subract the oldest element from the sum before adding the newest one.
	for (i = 0; i  < s->blocksize; i++) {

		// If there are not enough previous values in x, some from the saved vector
		// in s must be used.
		if (i < s->M){

			// Remove the oldest value from the sum
			sum -= s->previous[i];

			// Add the newest value
			sum += x[i];

		} else {
			sum -= x[i - s->M];	// Remove the oldest element
			sum += x[i];				// Add the newest element
		}

		// Compute the running mean and assign it to the appropriate y value
		y[i] = sum / s->M;
	}

	// Save the last M values of this input buffer to s for use in the next call
	// to calc_running_mean
	if (s->blocksize < s->M) {
		for (i = s->M - 1; j >= (s->blocksize); i--) {
			s->previous[i - s->blocksize] = s->previous[i];
		}
		for (i = 0; i < s->blocksize; i++) {
			s->previous[s->M - s->blocksize + 1] = x[i];
		}
	} else {
		for (i = s->blocksize - 1; i >= (s->blocksize - s->M); i--){
			s->previous[i - s->blocksize + s->M] = x[i];
		}
	}

	// Save the newly allocated output buffer pointer to the intermediary structure, as
	// a safeguard against memory leak. Free the old one, if present
	if (s->output != NULL) {
		free(s->output);
	}
	s->output = y;

	//return y;
}

void end_running_mean(struct calc_data *s){

	// Free the previous data buffer
	free(s->previous);

	// Free the entire structure
	free(s);

	// Free the last output buffer
	free(s->output);

	return;
}
/*
void process_running_mean(float *x, float *y, int size, int blocksize, int M) {

	// Loop index
	int i = 0;

	// Initialization
	struct calc_data *s = init_running_mean(M,blocksize);
	float *data_block;

	// Process the data block by block, up to (but not including) the last block
	for (i = 0; i < size - blocksize; i += blocksize){
		data_block = calc_running_mean(&x[i], s);
		memcpy(&y[i], data_block, blocksize*sizeof(float));
	}

	// If there is not exactly one block's worth of input values remaining, we'll need to
	// create a temporary input buffer of exactly one block with the extra values filled out with zeros
	float *temp_x = (float *)calloc(blocksize, sizeof(float));
	memcpy(temp_x, &x[i], (size - i) * sizeof(float));
	data_block = calc_running_mean(temp_x, s);
	memcpy(&y[i], data_block, (size - i) * sizeof(float));
	free(temp_x);

	// Terminate the running mean system
	end_running_mean(s);
	return;
};*/
