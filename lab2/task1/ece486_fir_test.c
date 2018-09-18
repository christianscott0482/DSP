// This code was created for the purpose of testing the routines
// defined by ece486_fir.c and declared by ece486.h. This routines
// include init_fir(), calc_fir(), and destroy_fir()

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "ece486_fir.h"

#define PI 3.14159265

int main(void) {
	int i = 0;
	FILE * fp;
	char file_out[100];

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

	float coeff15[] = {
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


	/* 20 Coeff Test */
	// Fill input buffer (10kHz sine wave)
  float x_1[500];
  for (i = 0; i < 500; i++) {
    x_1[i] = sin(2 * PI * 10000 * i / 48000);
  }

  // Run through the filter block by block
	FIR_T *filter_1 = init_fir(coeff20, 20, 50);
  float y_1[500];
  for (i = 0; i < 500; i+=50) {
    calc_fir(filter_1, &x_1[i], &y_1[i]);
  }

  // Destroy the filter
  destroy_fir(filter_1);

	// Open output_20 and print csv file
	sprintf(file_out, "matlab/output_20.csv");
	fp = fopen(file_out, "w");
	if (fp == NULL){
		printf("Error: failed to open CSV file\n");
		return 0;
	}
	for (i = 0; i < 499; i++){
		fprintf(fp, "%f,", y_1[i]);
	}
	fprintf(fp, "%f", y_1[i]);
	fclose(fp);

	/* 15 Coeff Test */
	// Fill input buffer (2kHz sine wave)
	float x_2[500];
	for (i = 0; i < 500; i++) {
		x_2[i] = sin(2 * PI * 2000 * i / 48000);
	}

	// Run through the filter block by block
	FIR_T *filter_2 = init_fir(coeff15, 15, 50);
	float y_2[500];
	for (i = 0; i < 500; i+=50) {
		calc_fir(filter_2, &x_2[i], &y_2[i]);
	}

	// Destroy the filter
	destroy_fir(filter_2);

	// Open output_15 and print csv file
	sprintf(file_out, "matlab/output_15.csv");
	fp = fopen(file_out, "w");
	if (fp == NULL){
		printf("Error: failed to open CSV file\n");
		return 0;
	}
	for (i = 0; i < 499; i++){
		fprintf(fp, "%f,", y_2[i]);
	}
	fprintf(fp, "%f", y_2[i]);
	fclose(fp);

	/* 10 Coeff Test */
	// Fill input buffer (2kHz sine wave)
	float x_3[500];
	for (i = 0; i < 500; i++) {
		x_3[i] = sin(2 * PI * 2000 * i / 48000);
	}

	// Run through the filter block by block
	FIR_T *filter_3 = init_fir(coeff10, 10, 50);
	float y_3[500];
	for (i = 0; i < 500; i+=50) {
		calc_fir(filter_3, &x_3[i], &y_3[i]);
	}

	// Destroy the filter
	destroy_fir(filter_3);

	// Open output_15 and print csv file
	sprintf(file_out, "matlab/output_10.csv");
	fp = fopen(file_out, "w");
	if (fp == NULL){
		printf("Error: failed to open CSV file\n");
		return 0;
	}
	for (i = 0; i < 499; i++){
		fprintf(fp, "%f,", y_3[i]);
	}
	fprintf(fp, "%f", y_3[i]);
	fclose(fp);

	return 0;
}
