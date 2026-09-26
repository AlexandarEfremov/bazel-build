#include <iostream>
#include "srcs/add/addition.hpp"
#include "srcs/sub/subtraction.hpp"
#include "srcs/multi/multiplication.hpp"
#include "srcs/div/division.hpp"

int main() {
    int num_one, num_two;
    char op;

    std::cout << "Enter two integer numbers: ";
    std::cin >> num_one >> num_two;

    std::cout << "Enter an operation (+ - / *): ";
    std::cin >> op;

    switch (op) {
    case '+':
        std::cout << num_one << " + " << num_two << " = " << add(num_one, num_two) << std::endl;
        break;
    case '-':
        std::cout << num_one << " - " << num_two << " = " << sub(num_one, num_two) << std::endl;
        break;
    case '*':
        std::cout << num_one << " * " << num_two << " = " << multi(num_one, num_two) << std::endl;
        break;
    case '/':
        std::cout << num_one << " / " << num_two << " = " << division(num_one, num_two) << std::endl;
        break;
    default:
        std::cout << "You didn't enter a valid operation" << std::endl;
        break;
    }

    return 0;
}