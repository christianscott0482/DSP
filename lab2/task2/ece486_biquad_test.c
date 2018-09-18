#include "ece486_biquad.h"
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

#define PI 3.1415926535

int main(int argc, char *argv[])
{
  int i = 0;
  FILE * fp;
  char file_out[100];

  // Test Case #1: 6th order buttersworth filter, cutoff @ 1kHz
  // Input: 2kHz sine wave
  float coefs_1[15] = {
    6.155351847311430e-08, 1.231070369462286e-07, 6.155351847311430e-08, -1.760880357199149, 0.776074924387786,
    1, 2, 1, -1.815341082704569, 0.831005589346758,
    1, 2, 1, -1.918091481867240, 0.934642617653399
  };
  BIQUAD_T *filter_1 = init_biquad(3, 1, coefs_1, 50);

  // Fill input buffer
  float x_1[100];
  for (i = 0; i < 100; i++) {
    x_1[i] = sin(2 * PI * 2000 * i / 48000);
  }

  // Run through the filter block by block
  float y_1[100];
  for (i = 0; i < 100; i+=50) {
    calc_biquad(filter_1, &x_1[i], &y_1[i]);
  }

  // Destroy the filter
  destroy_biquad(filter_1);

  // Print the results in CSV format
  sprintf(file_out, "matlab/output_6.csv");
  	fp = fopen(file_out, "w");
  	if (fp == NULL){
  		printf("Error: failed to open CSV file\n");
  		return 0;
  	}
  	for (i = 0; i < 99; i++){
  		fprintf(fp, "%f,", y_1[i]);
  	}
  	fprintf(fp, "%f", y_1[i]);
  	fclose(fp);

  // Test Case #2: 8th order buttersworth filter, cutoff @ 5kHz
  // Input: 5kHz sine wave
  float coefs_2[25] = {
    2.384348875473535e-06, 4.768697750947070e-06, 2.384348875473535e-06, -0.990907269678935, 0.249011278272522,
    1, 2, 1, -1.028718864655045, 0.296671750669644,
    1, 2, 1, -1.109228792618423, 0.398152293921440,
    1, 2, 1, -1.243138205954774, 0.566941415408202,
    1, 2, 1, -1.448741216801277, 0.826098338817674
  };
  BIQUAD_T *filter_2 = init_biquad(5, 1, coefs_2, 50);

  // Fill input buffer
  float x_2[100];
  for (i = 0; i < 100; i++) {
    x_2[i] = sin(2 * PI * 5000 * i / 48000);
  }

  // Run through the filter block by block
  float y_2[100];
  for (i = 0; i < 100; i+=50) {
    calc_biquad(filter_2, &x_2[i], &y_2[i]);
  }

  // Destroy the filter
  destroy_biquad(filter_2);

  // Print the results in CSV format
  sprintf(file_out, "matlab/output_10.csv");
  	fp = fopen(file_out, "w");
  	if (fp == NULL){
  		printf("Error: failed to open CSV file\n");
  		return 0;
  	}
  	for (i = 0; i < 99; i++){
  		fprintf(fp, "%f,", y_2[i]);
  	}
  	fprintf(fp, "%f", y_2[i]);
  	fclose(fp);

  return 0;
}
