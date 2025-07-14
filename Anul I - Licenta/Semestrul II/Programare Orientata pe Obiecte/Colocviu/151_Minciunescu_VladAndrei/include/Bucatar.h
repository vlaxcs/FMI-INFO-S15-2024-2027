/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#pragma once
#include "Angajat.h"

class Bucatar : public Angajat{
public:
    explicit Bucatar(const std::optional<float> &energy_points_)
        : Angajat(energy_points_) {
    }

    void useEnergy() override;

    ~Bucatar() override = default;
};
