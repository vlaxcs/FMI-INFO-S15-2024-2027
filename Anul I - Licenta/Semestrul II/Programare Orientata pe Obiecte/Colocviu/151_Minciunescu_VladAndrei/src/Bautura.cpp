/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#include "Bautura.h"

float Bautura::computeEnergy() {
    return this->bottle ? 25 : 0.25 * this->quantity;
}