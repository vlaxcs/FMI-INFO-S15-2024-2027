/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#include "Burger.h"

float Burger::computeEnergy() {
    return this->quantity * 0.25 * recipe_list.size();
}
