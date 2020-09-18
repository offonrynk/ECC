#ifndef CBIT_H
#define CBIT_H

class cbit {
public:
  enum VALUE { ZERO = 0, ONE = 1 };

  cbit(VALUE nVal = ZERO);
  ~cbit() = default;
  void Set();
  void Clear();
  unsigned Get();
  void Print();

  /**
   * Overloaded Operators for Assignment, XOR and Assignment, XOR, AND and
   * Conditional Checking
   */
  cbit &operator=(unsigned d)
  {
    m_nValue = (d == 0) ? VALUE::ZERO : VALUE::ONE;
    return *this;
  }

  cbit &operator^=(const cbit &r)
  {
    m_nValue = (m_nValue == r.m_nValue) ? VALUE::ZERO : VALUE::ONE;
    return *this;
  }

  friend cbit operator^(cbit l, const cbit &r) {
    return (l.m_nValue == r.m_nValue) ? cbit(VALUE::ZERO) : cbit(VALUE::ONE);
  }

  friend cbit
  operator&(cbit l, const cbit &r)
  {
    return ((l.m_nValue == 1) && (r.m_nValue == 1)) ? cbit(VALUE::ONE)
                                                    : cbit(VALUE::ZERO);
  }

  inline bool operator==(const cbit::VALUE &r)
  {
    return m_nValue == r;
  }

protected:
  VALUE m_nValue;
};

#endif
