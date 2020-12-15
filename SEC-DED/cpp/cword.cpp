#include "cword.h"
#include <iostream>

deque<cbit>::iterator iter;

cword::cword(unsigned nBitlength)
{
  m_nBitlength = nBitlength;
  m_word.resize(nBitlength);
}

cbit *cword::GetAt(unsigned nBitposition)
{
  if (nBitposition < m_nBitlength) {
    return &m_word.at(nBitposition);
  }
  return nullptr;
}

void cword::Set(unsigned data)
{

  if (m_nBitlength < sizeof(data)) {
    iter = m_word.begin();
    for (unsigned i = 0; i < m_nBitlength; ++i) {
      *iter++ = data & 1;
      data >>= 1;
    }
  }
  else {
    for (iter = m_word.begin(); iter != m_word.end(); ++iter) {
      *iter = data & 1;
      data >>= 1;
    }
  }
}

void cword::Rotate()
{
  deque<cbit> buffer = m_word;
  for (unsigned i = 0; i < m_nBitlength; i++) {
    m_word.at(m_nBitlength - i - 1) = buffer.at(i);
  }
}

void cword::Print()
{
  for (iter = m_word.begin(); iter != m_word.end(); iter++) {
    (*iter).Print();
  }
  std::cout << "\n";
}

void cword::Append(cbit b)
{
  m_word.push_back(b);
  ++m_nBitlength;
}

void cword::Resize(unsigned nsize)
{
  m_nBitlength = nsize;
  m_word.resize(nsize);
}

bool cword::Insert(unsigned npos, cbit b)
{
  if (npos >= m_nBitlength) {
    return false;
  }

  iter = m_word.begin() + npos;
  m_word.insert(iter, b);
  ++m_nBitlength;

  return true;
}

bool cword::Delete(unsigned npos)
{
  if (npos >= m_nBitlength) {
    return false;
  }

  iter = m_word.begin() + npos;
  m_word.erase(iter);
  ++m_nBitlength;

  return true;
}

unsigned cword::GetLength() const
{
  return m_nBitlength;
}
