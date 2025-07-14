/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#pragma once
#include "Produs.h"
#include "types/TipServire.h"
#include <iostream>

class Desert : public Produs {
private:
  ServiceType tip;

public:
  Desert(const std::string &name_, float quantity_, const ServiceType& tip)
    : Produs(name_, quantity_),
      tip(tip) {
  }

  Desert() = default;

  friend std::istream &operator>>(std::istream& in, Desert& desert) {
    std::cout << "Tip de servire? [0 - Felie | 1 - Cupa | 2 - Portie]";
    int temp_type;
    std::cin >> temp_type;
    switch (temp_type) {
      case 0: desert.tip = ServiceType::Slice; break;
      case 1: desert.tip = ServiceType::Cup; break;
      case 2: desert.tip = ServiceType::Portie; break;
      default: std::cout << "Tip invalid\n"; break;
    }
    return in;
  }

  float computeEnergy() override;

  ~Desert() override = default;
};
