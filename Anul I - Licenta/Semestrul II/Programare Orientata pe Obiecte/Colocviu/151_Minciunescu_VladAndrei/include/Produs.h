/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#pragma once
#include <string>

class Produs {
protected:
    std::string name;
    float quantity;

public:
    Produs() : name(""), quantity(0) {};

    Produs(const std::string& name_, const float quantity_)
        : name(name_), quantity(quantity_) {

    }

    virtual float computeEnergy() = 0;

    virtual ~Produs() = default;
};
