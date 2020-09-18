#include "cbit.h"
#include <iostream>

using namespace std;

cbit::cbit(VALUE nVal)
{
  m_nValue = nVal;
}

void cbit::Set()
{
  m_nValue = VALUE::ONE;
}

void cbit::Clear()
{
  m_nValue = VALUE::ZERO;
}

unsigned cbit::Get()
{
  return m_nValue;
}

void cbit::Print()
{
  std::cout << (m_nValue == ZERO) ? "0" : "1";
}
