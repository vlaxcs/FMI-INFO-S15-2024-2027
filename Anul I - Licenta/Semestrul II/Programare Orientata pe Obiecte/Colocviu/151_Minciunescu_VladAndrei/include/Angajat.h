/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#pragma once
#include <optional>

class Angajat {
protected:
  static int inline id_counter = 0;
  int id;
  float energy_points;

public:
  explicit Angajat(const std::optional<float> energy_points_)
    : id(id_counter++), energy_points((energy_points_.has_value() ? energy_points_ : 100).value()) {
  }

  int getId() const;

  virtual void useEnergy() = 0;

  virtual ~Angajat() = default;
};
