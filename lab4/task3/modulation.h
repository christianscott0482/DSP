/*!
 * @file modulation.h
 *
 * @ brief Various modulation schemes for arbitrary bit sequences on the STM DAC
 *
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date April 1st, 2018
 *
 * @defgroup Modulation interface requirements/function.
 *	@{
 * Implementation of OOK, ASK, BPSK, and QPSK modulation schemes for the STM board. Modulation occurs using mixers from ece486_IQ_mixer.
 * Functions here initialize input buffers to a set of mixers containing the carrier frequency.
 *
 */

 #ifndef MODULATION_H
 #define MODULATION_H

 /*
  * Paramter Structure Definitions
  */

 /*!
  * @brief MOD_TYPE_T Defines the type of modulation scheme which should be initialized
  */
typedef enum mod_type {
  OOK,
  ASK,
  BPSK,
  QPSK
} MOD_TYPE_T;

/*!
 * @brief MOD_T Modulation scheme data structure. Contains intermediary information for modulation.
 */
typedef struct mod_data {
  float *cos_buf;   //!< Buffer to input into the cosine mixer
  float *sin_buf;   //!< Buffer to input into the sine mixer
  int buf_size;     //!< Size of the input buffers
  int cur_index;    //!< Current index of modulation into the sine/cosine buffers
} MOD_T;

/*
 * Function Prototypes
 */

/*!
 * @brief Initialize a MOD_T modulator. The MOD_T structure must be allocated
 * by the caller, and once initialized can be passed to the calc_mod function
 * for modulation.
 *
 * @returns Nothing
 */
void init_mod(
  MOD_T *mod,       //!< [in,out] Modulation data structure. Allocated by the caller
  MOD_TYPE_T type,  //!< [in] Type of modulation, OOK, AAK, BPSK, or QPSK
  float A,          //!< [in] Amplitude of the carrier signal
  float Fs,         //!< [in] Sampling frequency of the modulator
  float bitrate,    //!< [in] Bitrate to transfer data
  char *bit_buf,    //!< [in] Buffer of binary data to send
  int N             //!< [in] Number of bits in bit_buf
);

/*!
 * @brief Extracts blocksize chunks of the sine/cosine buffers of the modulation
 * objects in a periodic fashion. These buffers should be passed to IQ_MIXER_T objects
 * set to the carrier frequency to complete the modulation. The real signal should
 * be extracted from the mixed cosine buffer, and the imaginary signal should be
 * extracted from the mixed sine buffer.
 *
 * @returns Nothing
 */
void calc_mod(
  MOD_T *mod,     //!< [in, out] Modulation data structure. Modified during calculation
  float *cos_buf, //!< [in, out] User allocated buffer for cosine mixer input data.
  float *sin_buf, //!< [in, out] User allocated buffer for sine mixer input data
  int M           //!< [in] Blocksize
);

/*!
 * @brief Frees all memory previously allocated by a MOD_T object
 *
 * @returns Nothing
 */
void destroy_mod(
  MOD_T *mod
);

#endif
