/*!
 * @file
 *
 * @brief This file contains a program to run various data sets through the running mean system
 *
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date Feb 10, 2018
 *
 * This file contains a program to run various data sets through the running
 * mean system. The program will output CSV files with input/output data,
 * named after the waveforms they represent.
 */

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "running_mean.h"

#define PI 3.14159265

void process_data(float *in, float *out, int size, int M, int blocksize, char *name);

int main(void) {

	int i = 0;		// Loop index

	// Input/output buffers
	float input[500];
	float output[500];
	memset(input, 0, 500 * sizeof(float));
	memset(output, 0, 500 * sizeof(float));

	// The first data set is a simple ramp function, running from 0 - 499 in steps
	// of 1.
	for (i  = 0; i < 500; i++){
		input[i] = i;
	}

	process_data(input, output, 500, 10, 50, "ramp");

	// The second data set is a sinusoid of 25 samples/cycle
	for(i = 0; i < 500; i++) {
		input[i] = sin(2.0 * PI / 25.0 * i);
	}

	process_data(input, output, 500, 10, 50, "sine_25");

	// The second data set is a sinusoid of 50 samples/cycle
	for(i = 0; i < 500; i++) {
		input[i] = sin(2.0 * PI / 50.0 * i);
	}

	process_data(input, output, 500, 10, 50, "sine_50");

	// The second data set is a sinusoid of 75 samples/cycle
	for(i = 0; i < 500; i++) {
		input[i] = sin(2.0 * PI / 75.0 * i);
	}

	process_data(input, output, 500, 10, 50, "sine_75");

	// The second data set is a sinusoid of 100 samples/cycle
	for(i = 0; i < 500; i++) {
		input[i] = sin(2.0 * PI / 100.0 * i);
	}

	process_data(input, output, 500, 10, 50, "sine_100");

	return 0;
}

/*!
 * @brief Pass an arbitrarily sized data set through the running mean filter and output as a .csv file
 *
 * This functions runs a data set of arbitrary size through the process_running_mean
 * function. In the process, it also creates .csv files for the input and output
 * data sets, named input_x.csv and output_x.csv, where x is a passed string
 * representing the name of the data set. This is useful for testing data sets
 * against the running mean system and getting output which can be imported to
 * MATLAB for analysis
 *
 * @param[in]			in				Pointer to a buffer of input data values
 * @param[in,out] out				Pointer to a buffer in which the output data values should
 *													be stored. Any prexisiting values in this buffer will be destroyed
 * @param[in]			size			The number of elements in both the input and output buffers
 *													(x and y respectively)
 * @param[in]			M					The range of previous samples the running mean should include
 * @param[in]			blocksize	The desired block size into which the input data should be
 *													chunked during computation
 * @param[in]			name			String representing the name of the data set
 * @returns				Once this function returns, the output buffer "out" will contain
 *								the output data values after filtering. Data at each index
 *								of the buffer corresponds to the input data at the same index
 *								in the input buffer "in". Two CSV files, named input_x.csv and
 *								output_x.csv will also be produced, containing the input and output
 *								values repsectively in CSV format.
 */
void process_data(float *in, float *out, int size, int M, int blocksize, char *name)
{

	int i = 0;		// Loop index
	FILE * fp;		// File pointer

	// Assemble file names
	char file_in[100];
	char file_out[100];
	sprintf(file_in, "data/input_%s.csv", name);
	sprintf(file_out, "data/output_%s.csv", name);

	// Open the input csv file
	fp = fopen(file_in, "w");
	if (fp == NULL) {
		printf("Error: failed to open CSV file\n");
		return;
	}

	// Fill the input csv file
	for(i = 0; i < size - 1; i++){
		fprintf(fp, "%f,", in[i]);
	}
	fprintf(fp, "%f", in[i]);
	fclose(fp);

	// Process the samples
	process_running_mean(in, out, size, blocksize, M);

	// Open the output csv file
	fp = fopen(file_out, "w");
	if (fp == NULL) {
		printf("Error: failed to open CSV file\n");
		return;
	}

	// Fill the output csv file
	for(i = 0; i < size - 1; i++){
		fprintf(fp, "%f,", out[i]);
	}
	fprintf(fp, "%f", out[i]);
	fclose(fp);

	return;
}
