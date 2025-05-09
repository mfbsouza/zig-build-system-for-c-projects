#include "mylib.h"

Mylib::Mylib(uintmax_t my_number) {
	this->my_number = my_number;
}

uintmax_t Mylib::mylibMethod() {
	return this->my_number;
}
