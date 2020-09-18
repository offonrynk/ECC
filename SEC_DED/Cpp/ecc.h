#ifndef ECC_H
#define ECC_H

#include "cbit.h"
#include "cword.h"

namespace ecc {
unsigned Calcnumofparitybits(unsigned m); /** where m = data bits**/

void ExtendWord(cword &v);

void CalculateCheckbits(cword &v, cword &p);
void InsertCheckbits(cword &v, cword p);
void ExtractCheckbits(cword v, cword &p);

void CalculateParityBit(cword v, cbit &p);
void InsertParityBit(cword &v, cbit p);
void ExtractParityBit(cword v, cbit &p);
}

#endif // ECC_H
