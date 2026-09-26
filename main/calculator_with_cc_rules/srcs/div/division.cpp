#include <iostream>
#include "division.hpp"

double division(int num_one, int num_two) {
    if (num_two == 0) {
        std::cout << "Cannot divide by 0" << std::endl;
        exit(1);
    } else {
        return (double) num_one / num_two;
    }
}
