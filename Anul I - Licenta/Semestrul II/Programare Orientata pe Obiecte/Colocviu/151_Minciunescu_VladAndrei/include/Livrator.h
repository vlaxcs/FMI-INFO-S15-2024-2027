/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#pragma once
#include "Angajat.h"

class Livrator : public Angajat {
public:
    explicit Livrator(const std::optional<float> &energy_points_)
        : Angajat(energy_points_) {
    }

    void useEnergy() override;

    ~Livrator() override = default;
};
