#include <time.h>
#include "ecc.h"
#include <iostream>
#include <stdio.h>
#include <stdlib.h>

int main()
{
  srand(time(NULL));

  unsigned data = 4;
  cword p(ecc::Calcnumofparitybits(data)), v(data);

  /**Initializing the codeword**/
  for (unsigned a = 0; a < 16; a++) {
    v = a;
    v.Rotate();

    ecc::ExtendWord(v); /** extend to 8 bits **/
    std::cout << a << "\t";

    p = 0;
    ecc::CalculateCheckbits(v, p);
    ecc::InsertCheckbits(v, p);
    ecc::CalculateParityBit(v, p[3]);
    ecc::InsertParityBit(v, p[3]);

    v.Print();

    v.Resize(data);
  }

  std::cout << "\n";

  for (unsigned x = 0; x < 100; x++) {
    for (unsigned y = 0; y < 100; y++) {
      /** To get a random number between 0 to 15**/

      unsigned a = rand() % 16;

      v.Resize(data);
      v = a;
      v.Rotate();

      ecc::ExtendWord(v);

      p = 0;
      ecc::CalculateCheckbits(v, p);
      ecc::InsertCheckbits(v, p);
      ecc::CalculateParityBit(v, p[3]);
      ecc::InsertParityBit(v, p[3]);
      std::cout << "Encoded data is:     ";
      v.Print();
      std::cout << "Data is: " << a << std::endl;

      /** Inserting an error(s)**/

      unsigned num = rand() % 3;
      unsigned pos = rand() % 8;
      if (num == 0) {
        v[pos] ^= cbit(cbit::ZERO);
      }
      else if (num == 1) {
        pos = rand() % 8;
        v[pos] ^= cbit(cbit::ONE);
      }
      else if (num == 2) {
        unsigned pos1 = rand() % 8;
        unsigned pos2 = rand() % 8;
        while (pos1 == pos2) {
          pos2 = rand() % 8;
        }
        v[pos1] ^= cbit(cbit::ONE);
        v[pos2] ^= cbit(cbit::ONE);
      }

      else {
        break;
      }

      /** Randomizing a Position for errors between bit 1 to 7 **/
      // v[pos] ^= cbit(cbit::ONE);
      std::cout << "Inserts error\n";
      std::cout << "Data(Code) word is now: ";
      v.Print();

      p = 0;
      ecc::CalculateCheckbits(v, p);
      ecc::CalculateParityBit(v, p[3]);

      /** Syndrome Calculation **/

      unsigned syndrome = 0;
      for (unsigned i = 0; i < p.GetLength() - 1; i++) {
        if (p[i] == cbit::ONE)
          syndrome += (1 << i);
      }

      if (p[3] == cbit::ZERO) {
        if (syndrome) {
          printf("Double error detected.\n");
          std::cout << "\n";
          break;
        }
        else {
          printf("No error detected.\n");
          std::cout << "\n";
          if (pos == 0)
            continue;
          else
            break;
        }
      }
      else {
        if (syndrome) {
          printf("Error detected in Position %d.\n", syndrome);
          printf("Bit %d was flipped to ", pos + 1);
          v[pos].Print();
          std::cout << "\n";

          v[pos] ^= cbit(cbit::ONE);
          std::cout << "Correct data is ";
          v.Print();
          std::cout << "\n";
          if (syndrome == pos + 1)
            continue;
          else
            break;
        }
        else {
          printf("Overall parity error detected.\n");
          printf("Bit %d was flipped to ", pos + 1);
          v[pos].Print();
          std::cout << "\n";

          v[pos] ^= cbit(cbit::ONE);
          std::cout << "Correct data is ";
          v.Print();
          std::cout << "\n";
          if (pos == 7 || pos == 3 || pos == 1 || pos == 0)
            continue;
          else
            break;
        }
      }
    }
  }

  return 0;
}
