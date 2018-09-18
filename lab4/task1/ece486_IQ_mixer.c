/*!
 * @file ece486_IQ_mixer.c
 *
 * @brief Mixer implementation for Lab 4
 *
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date March 25, 2018
 *
 * Source file for the ECE486 Lab 4 mixer implementation. For usage details, see
 * ece486_IQ_mixer.h
 */
#include "ece486_IQ_mixer.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <math.h>

 IQ_MIXER_T *init_IQ_mixer(float w0)
 {
	// Allocate space for IQ_MIXER_T structure
	IQ_MIXER_T *mixer;	
	mixer = (IQ_MIXER_T *)malloc(sizeof(IQ_MIXER_T));

	// Create and store cosc and sinc parameters
	mixer->cosc = cos(w0);
	mixer->sinc = sin(w0);

	// Store sr and si
	mixer->sr = 1;
	mixer->si = 0;

	return mixer;
 }

 void calc_IQ_mixer(IQ_MIXER_T *mixer, float *in_samples, float *out_re, float *out_im, int blocksize)
 {
	 int i = 0;
	 float abs = 0;
	 float srp = 0;
	 float sip = 0;

	// Calculate real output
	for(i = 0; i < blocksize; i++){
		// Perform multiplication
		out_re[i] = in_samples[i] * mixer->sr;
		out_im[i] = in_samples[i] * mixer->si;

		// Calculate next value of s
		srp = (mixer->sr)*(mixer->cosc) - (mixer->si)*(mixer->sinc);
		sip = (mixer->si)*(mixer->cosc) + (mixer->sr)*(mixer->sinc);
		
		mixer->sr = srp;
		mixer->si = sip;
	}
	
	// Reset values of sr and si
	abs = (mixer->sr * mixer->sr) + (mixer->si * mixer->si);
	mixer->sr = (mixer->sr) / sqrt(abs);
	mixer->si = (mixer->si) / sqrt(abs);

	return;

 }

 void destroy_IQ_mixer(IQ_MIXER_T *mixer)
 {
	// Free previously allocated memory
	free(mixer);

	return;
 }
