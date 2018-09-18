/*!
 * @file modulation.c
 *
 * @brief Modulation implementation for Lab 4
 *
 * @author ECE486 Lab Group 8
 * @author Christian Auspland
 * @author Matthew Blanchard
 * @author Ben Grooms
 *
 * @date April 1st, 2018
 *
 * Source file for the ECE486 Lab 4 modulation implementation. For details, see
 * modulation.h
 */

#include <stdlib.h>
#include "ece486_IQ_mixer.h"
#include "modulation.h"

void init_mod(MOD_T *mod, MOD_TYPE_T type, float A, float Fs, float bitrate, char *bit_buf, int N)
{

  // Allocate space for the input buffer, needs to be enough for Fs / bitrate * N bit
  // seconds of transmission
  mod->buf_size = (int)((Fs / bitrate) * N);
  mod->cos_buf  = (float *)malloc(sizeof(float) * mod->buf_size);
  mod->sin_buf  = (float *)malloc(sizeof(float) * mod->buf_size);

  int i = 0;

  switch (type) {

    // OOK sends a signal of amplitude A for '1' and nothing for '0'
    case OOK:
      for (i = 0; i < mod->buf_size; i++) {
        int bit_index = i / (mod->buf_size / N);
        bit_index = (bit_index >= N) ? (N - 1) : bit_index;
        char cur_bit = bit_buf[bit_index];
        mod->cos_buf[i] = (cur_bit == 1) ? A : 0;
        mod->sin_buf[i] = 0;
      }
      break;

    // ASK sends a signal of amplitude A for '1' and A/2 for '0'
    case ASK:
      for (i = 0; i < mod->buf_size; i++) {
        int bit_index = i / (mod->buf_size / N);
        bit_index = (bit_index >= N) ? (N - 1) : bit_index;
        char cur_bit = bit_buf[bit_index];
        mod->cos_buf[i] = (cur_bit == 1) ? A : A/2;
        mod->sin_buf[i] = 0;
      }
      break;

    // BPSK sends a signal of amplitude A for '1' and -A for '0' (180 degree PS)
    case BPSK:
      for (i = 0; i < mod->buf_size; i++) {
        int bit_index = i / (mod->buf_size / N);
        bit_index = (bit_index >= N) ? (N - 1) : bit_index;
        char cur_bit = bit_buf[bit_index];
        mod->cos_buf[i] = (cur_bit == 1) ? A : -A;
        mod->sin_buf[i] = 0;
      }
      break;

    // QPSK is a special case. Instead of assigning amplitudes to
    case QPSK:
      for (i = 0; i < mod->buf_size; i++) {
        int bit_index = i / (mod->buf_size / N);
        bit_index = (bit_index >= N) ? (N - 1) : bit_index;
        bit_index -= bit_index % 2;
        char cos_bit = bit_buf[bit_index];
        char sin_bit = bit_buf[bit_index + 1];
        mod->cos_buf[i] = (cos_bit == 1) ?  A : -A;
        mod->sin_buf[i] = (sin_bit == 1) ? -A :  A;
      }
      break;
  }

  // Start at index 0 in the signal buffer
  mod->cur_index = 0;

  return;
}

void calc_mod(MOD_T *mod, float *cos_buf, float *sin_buf, int M)
{
  int i = 0;
  for (i = 0; i < M; i++) {
    cos_buf[i] = mod->cos_buf[mod->cur_index];
    sin_buf[i] = mod->sin_buf[mod->cur_index];
    mod->cur_index++;
    mod->cur_index = mod->cur_index % mod->buf_size;
  }
  return;
}

void destroy_mod(MOD_T *mod)
{
  free(mod->cos_buf);
  free(mod->sin_buf);
  return;
}
