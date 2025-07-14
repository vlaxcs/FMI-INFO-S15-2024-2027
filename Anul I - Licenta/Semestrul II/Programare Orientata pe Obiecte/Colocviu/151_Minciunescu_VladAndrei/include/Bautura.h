/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#pragma once
#include "Produs.h"
#include <iostream>

class Bautura : public Produs{
private:
  bool bottle;

public:
  Bautura(const std::string &name_, float quantity_, bool bottle)
    : Produs(name_, quantity_),
      bottle(bottle) {
  }

  Bautura() = default;

  friend std::istream &operator>>(std::istream& in, Bautura& bautura) {
      std::cout << "Sticla? [1 - Da | 0 - Nu]";
      in >> bautura.bottle;
      return in;
  }

  float computeEnergy() override;

  ~Bautura() override = default;
};
