/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#include "../include/Casier.h"
#include <iostream>

void Casier::useEnergy() {
    if (this->energy_points - 25 >= 0) {
        this->energy_points -= 25;
    } else {
        std::cout << "Failed to take the task";
    }
}