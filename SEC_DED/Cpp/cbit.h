#ifndef CBIT_H
#define CBIT_H


class cbit
{
    public:
        enum VALUE {ZERO = 0,ONE = 1};
        cbit(VALUE nVal = ZERO);
        void Set();
        void Clear();
        unsigned Get();
		void Print();

/***************************************************************************
* Overloaded Operators for Assignment, XOR and Assignment, XOR, AND and
  Conditional Checking
***************************************************************************/
    cbit& operator=(unsigned d);
    cbit& operator^=(const cbit& r);

	friend cbit operator^(cbit l, const cbit& r)
	{
		if (l.m_nValue == r.m_nValue)
		{
			return cbit(ZERO);
		}
		else
		{
			return cbit(ONE);
		}
	}

	friend cbit operator&(cbit l, const cbit& r)
	{
		if ((l.m_nValue == 1) && (r.m_nValue==1))
		{
			return cbit(ONE);
		}
		else
		{
			return cbit(ZERO);
		}
	}

	inline bool operator==(const cbit::VALUE& r)
	{
		return m_nValue == r;
	}

    protected:
        VALUE m_nValue;

};

#endif
