#ifndef CWORD_H
#define CWORD_H

#include "cbit.h"
#include <deque> // to enable bits to be taken and added to/from both/either
                 // the front end or/and back end of a word

using std::deque;

class cword {
protected:
  unsigned m_nBitlength; // have a specific bit length of range m-n
  deque<cbit> m_word;    // have a word where with deque, you can add/take bits
                         // from both ends

public:
  cword(unsigned nBitlength); // word of a specific length
  // clang-format off
  cbit* GetAt(unsigned nBitposition); // ptr to cbit class to get the bit position.

  void Set(unsigned data);
  void Rotate();
  void Print();
  void Append(cbit b);
  void Resize(unsigned nsize);

  bool Insert(unsigned npos, cbit b);
  bool Delete(unsigned npos);
  unsigned GetLength() const;

  /**
   * Overloaded Operators for Assignment, Postfix, and Right Shift
   */
  cword &operator=(unsigned d)
  {
    Set(d);
    return *this;
  }

  cbit &operator[](unsigned nPos)
  {
    return m_word.at(nPos);
  }

  friend cword operator>>(cword l, const unsigned &r)
  {
    for (unsigned i = 0; i < r; i++) {
      l.m_word.pop_front(); // Removes the first bit in the word
      l.m_word.push_back(
          cbit(cbit::VALUE::ZERO)); // Adds a new bit to end of a word.
    }
    return l;
  }
};

#endif
