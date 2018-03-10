#include "cbit.h"
#include <iostream>

using namespace std;

cbit::cbit(VALUE nVal)
{
    m_nValue = nVal;
}

void cbit::Set(){
    VALUE nVal = ONE;
}

void cbit::Clear(){
    VALUE nVal = ZERO;
}

unsigned cbit::Get(){
    if(m_nValue == ONE){
			return 1;
    }
    else
			return 0;
}

void cbit::Print()
{

	if (m_nValue == ZERO)
	{
		cout <<"0";
	}
	else
	{
		cout << "1";
	}
}

cbit& cbit::operator=(unsigned d)
	{
		if (d == 0 )
		{
			m_nValue = ZERO;
		}
		else
		{
			m_nValue = ONE;
		}
		return *this;
	}

cbit& cbit::operator^=(const cbit& r)
	{
		if (m_nValue == r.m_nValue)
		{
			m_nValue = ZERO;
		}
		else
		{
			m_nValue = ONE;
		}
		return *this;
	}
