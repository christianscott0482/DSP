#include "ece486_IQ_mixer.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

int main(void){
	float data_in[1024];
	float mixer_r[1024];
	float mixer_i[1024];
	int n[1024];
	int fs = 50e+3;
	FILE *fp;
	char file_out[100];
	int i = 0;

	// Create Mixer structure
	IQ_MIXER_T *mixer = init_IQ_mixer((12e+3*(3.14159)*2)/50e+3);

	// Create time value
	for(i = 0; i < 1024; i++)
		n[i] = i;

	// Create input 12kHz sinusoid signal
	for (i = 0; i < 1024; i++){
		data_in[i] = sin((2 * 3.14159 * n[i] * 12e+3) / fs);
	}

	// Calculate output data
	//for (i = 0; i < 1024; i++){
		calc_IQ_mixer(mixer, data_in, mixer_r, mixer_i, 1024);	
	//}
	// Destroy allocated data
	destroy_IQ_mixer(mixer);

	// Print data to a .csv file
	sprintf(file_out, "task1_test_r.csv");
	fp = fopen(file_out, "w");
	if (fp == NULL){
		printf("Error: failed to open CSV file\n");
		return 0;
	}
	for (i = 0; i < 1024; i++){
		fprintf(fp, "%f,", mixer_r[i]); 
	}
	fclose(fp);

	sprintf(file_out, "task1_test_i.csv");
	fp = fopen(file_out, "w");
	if (fp == NULL){
		printf("Error: failed to open CSV file\n");
		return 0;
	}
	for (i = 0; i < 1024; i++){
		fprintf(fp, "%f,", mixer_i[i]); 
	}
	fclose(fp);

	return 0;
}
