#include <iostream>
#include <mylib.h>

int main() {
	std::cout << "hello there\n";

	Mylib* myobj = new Mylib(10);

	std::cout << "my number is: " << myobj->mylibMethod() << std::endl;

	delete myobj;

	return 0;
}
