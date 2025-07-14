/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#pragma once
#include "Angajat.h"

class Casier : public Angajat{
public:
    explicit Casier(const std::optional<float> &energy_points_)
        : Angajat(energy_points_) {
    }

    void useEnergy() override;

    ~Casier() override = default;
};
