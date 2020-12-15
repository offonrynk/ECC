#include "ecc.h"
#include "cbit.h"
#include "cword.h"
#include <iostream>

using namespace std;

unsigned ecc::Calcnumofparitybits(unsigned m)
{
  unsigned nParityBits = 0;
  while (m > ((1 << nParityBits) - nParityBits - 1)) {
    ++nParityBits;
  }

  return nParityBits + 1; /** 1 added for parity bit**/
}

void ecc::ExtendWord(cword &v)
{
  unsigned end = v.GetLength() + ecc::Calcnumofparitybits(v.GetLength());

  unsigned i = 1;
  while (i < end) {
    v.Insert(i - 1, cbit());
    i <<= 1;
  }

  v.Append(cbit()); /**Append one bit for the parity**/
}

void ecc::CalculateCheckbits(cword &v, cword &p)
{
  unsigned i = 1, l = 0;
  unsigned len = v.GetLength() - 1;

  while (i < len) {
    for (unsigned j = (i - 1); j < len; j += (i << 1)) {
      for (unsigned k = 0; k < (i); k++) {
        if (j + k >= len)
          break;
        p[l] ^= v[j + k];
      }
    }
    l++;
    i <<= 1;
  }
}

void ecc::InsertCheckbits(cword &v, cword p)
{
  unsigned i = 1, j = 0;
  while (i <= v.GetLength() - 1) {
    v[i - 1] = p[j++];
    i <<= 1;
  }
}

void ecc::ExtractCheckbits(cword v, cword &p)
{
  unsigned i = 1, j = 0;
  while (i <= v.GetLength() - 1) {
    p[j++] = v[i - 1];
    i <<= 1;
  }
}

/********************************************************
*   Function which calculates the overall parity
*   A simple XOR of all the bits
********************************************************/
void ecc::CalculateParityBit(cword v, cbit &p)
{
  p = cbit::ZERO;
  for (unsigned i = 0; i < v.GetLength(); i++) {
    p ^= v[i];
  }
}

/*****************************************************************
*   Function to insert the parity bit into the extended data word
*****************************************************************/
void ecc::InsertParityBit(cword &v, cbit p)
{
  v[v.GetLength() - 1] = p;
}

/*******************************************************************
*   Function to extract the parity bit out of an extended data word
*****************************************************************/
void ecc::ExtractParityBit(cword v, cbit &p)
{
  p = v[v.GetLength() - 1];
}
