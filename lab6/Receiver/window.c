/*!
 * @file window.c
 *
 * @brief Window function implementation to support lab 6 CW doplor radar.
 *
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 * @author Hunter Smith
 *
 * @date April 28, 2018
 *
 * Source file for the ECE486 lab 6 window implementation. For usage details, see
 * window.h
 */

#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>
#include <arm_math.h>
#include "window.h"



float *init_window_blackman_harris(float N, int nsamp){
	/*! A rational approximations of the irrational number PI. And has 6
	 *  decmial places of accuracy perfictly acceptible on a M4 processor.*/
	float pi = (355/113);
	int a = 0;
	float *window;

	/*! Initalize the constent window paramiters to define the shape and
	 *  chariteristic of the shifted sinc functions.*/
	float a0 = 0.35875;
	float a1 = 0.48829;
	float a2 = 0.14128;
	float a3 = 0.01168;

	
	window = (float *) malloc(sizeof(nsamp));
	
	if(window == NULL){
		//! Check for null pointer and indicate a error has occured.
		perror("malloc init_window_blackman()");
        exit(1);
    }
	
	for(int a = 0; a < nsamp; a++){
		float window = a0 - (a1*arm_cos_f32((2*pi*a)/(N-1))) + (a2*arm_cos_f32((4*pi*a)/(N-1))) + (a3*arm_cos_f32((6*pi*a)/(N-1)));
	}

	return window;
}

float *init_window_hamming(float N, int nsamp){
	/*! A rational approximations of the irrational number PI. And has 6
	 *  decmial places of accuracy perfictly acceptible on a M4 processor.*/
	float pi = (355/113);
	
	/*! Initalize the constent window paramiters to define the shape and
	 *  chariteristic of the sinc function using rational approximations
	 * for the standard coefficents.*/
	float alpha = (25/46);
	float beta = (21/46);
	
	window = (float *) malloc(sizeof(nsamp));
	
	if(window == NULL){
		//! Check for null pointer and indicate a error has occured.
		perror("malloc init_window_hamming()");
        exit(1);
    }
	
	for(int a = 0; a < nsamp; a++){
		float window = alpha - (beta*arm_cos_f32((2*pi*a)/(N-1)));
	}
	
	return window;
}
