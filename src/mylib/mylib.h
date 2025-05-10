#pragma once

#include <cstdint>

class Mylib {
private:
  uintmax_t my_number;

public:
  Mylib(uintmax_t my_number);
  uintmax_t mylibMethod();
};
