/*!
 * @file ece485_IQ_mixer.h
 * 
 * @ brief In Phase and Quadrature multiplication of input
 * discrete signal and complex signal. 
 * 
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date March 25, 2018
 *
 * @defgroup ece486_IQ_mixer Function Interface Requirements ffor ECE 486 Lab 2 complex signal multiplication.
 *	@{
 * Implementation of functions to create an In Phase and Quadrature signals from multiplying a series of input data with a complex signal. The real and imaginary portions of the output of the multiplication(w[n]) are calculated seperately. The real portion is calculated using cos(w0n) and the imaginary is calculated with sin(w0n).
 * A mixer structure is initialized with init_IQ_mixer(), which allocates data, creates a structure, and starts the difference equation generation of cosine and sine waves.
 *
 *
 */

#ifndef ECE486_IQ_MIXER_H
#define ECE486_IQ_MIXER_H

/*
 * Paramter Structure Definitions
 */

/*!
 * @brief IQ_MIXER structure contains information for calculating the cosine and sine values
 */
typedef struct mixer_data {
	float sr; //!< Real part of complex signal (input). 
	float si; //!< Imaginary part of complex signal (input).
	float cosc; //!< Cosine constant. Generated once in the initialization function to iterate values of cosine for calculations.
	float sinc; //!< Sine constant. Generated once in the initialization function to iterate values of sine for calculations.
} IQ_MIXER_T;

/*
 * Function Prototypes
 */

/*!
 * @brief Initialize an IQ_MIXER_T by using the math.h libraries to create cosc and sinc based on the input w0 value. 
 * These will be used to create new sr and si values for each sample calculated. 
 *sr and si always start at one. 
 *
 * @returns pointer to an initialized structure of type #IQ_MIXER_T
 */
IQ_MIXER_T *init_IQ_mixer(
	float w0	//!< [in] specified frequncy in radians
	);

/*!
 * @brief Calculates the multiplication of an input signal x[n] and a complex signal s that results in two signals, a real signal and an imaginary signal. 
 *
 * The easiest way to deal with real and imaginary parts of the complex signal is to separate them and calculate them accordingly. 
 * The complex signal represented by e^(-j2(pi)f0n). 
 * This can be transformed into cos(w0n) + jsin(w0)n. 
 * Two seperate multiplactions of signals then can be made, leaving two output signals that and real and imaginary. 
 * The "standard" or "easy" method of finding values of sine and cosine using math.h are too taxing and slow to use here.
 * Instead, for every sample calculated, S is updated every sample by multiplying by values of cos(w0) and sin(w0) calculated in init_IQ_mixer(). 
 * The calculations can be shown here:
 * @verbatim
 *	sr' = sr*cos(w0) - si*sin(w0)
 *	si' = si*cos(w0) + sr*sin(w0)
 * @endverbatim
 *

 * \note Many continued calculations can lead to minor errors, so every call of calc_IQ_mixer() must make sure that s = sr + si is equal to 1.
 */

void calc_IQ_mixer(
	IQ_MIXER_T *mixer,	//< [in,out] IQ_MIXER structure, created by init_IQ_mixer() 
	float *in_samples,	//< [in] input signal buffer of blocksize specified by blocksize 
	float *out_re,		//< [out] Output buffer of In Phase (real) data to come out of signal multiplication 
	float *out_im,		//< [out] Output buffer Quadrature (imaginary) data to come out of signal multiplication 
	int blocksize
);

/*!
 * @brief Release memory associated with an IQ_MIXER
 */
void destroy_IQ_mixer(
	IQ_MIXER_T *mixer	//< [in] Pointer to previously initialized IQ_MIXER structure
);
/*! @} end of ece486_IQ_mixer group. */
#endif
