#include <iostream>
#include <memory>

#include "mylib.h"

int main() {
  std::cout << "hello there\n";

  auto myobj = std::make_unique<Mylib>(10);

  std::cout << "my number is: " << myobj->mylibMethod() << std::endl;

  return 0;
}
