/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#pragma once
#include "Produs.h"
#include "Burger.h"
#include "Bautura.h"
#include "Desert.h"

#include <set>
#include <memory>
#include <iostream>
#include <format>

class Comanda {
private:
  static int inline id_counter = 0;
  int id{};
  std::set<std::shared_ptr<Produs>> produse;

public:
  explicit Comanda(const std::set<std::shared_ptr<Produs>> &produse)
    : id(id_counter++),
      produse(produse) {
  }

  friend std::istream &operator>>(std::istream& in, Comanda& comanda_) {
    int temp_count(0);
    std::cout << std::format("Citirea comenzii ID #{}\n", comanda_.id);
    std::cout << "Cate produse are comanda?"; std::cin >> temp_count;
    std::cout << std::format("Se citesc {} produse\n", temp_count);
    for (int i = 0; i < temp_count; ++i) {
      int obj_type = 0;
      std::cout << std::format("Produsul {} este de tipul? [1 - Bautura, 2 - Desert, 3 - Burger]", i);
      std::cin >> obj_type;
      if (obj_type == 1) {
        Bautura temp_b({}); std::cin >> temp_b;
        comanda_.produse.insert(std::make_shared<Bautura>(temp_b));
      } else if (obj_type == 2) {
        Desert temp_d({}); std::cin >> temp_d;
        comanda_.produse.insert(std::make_shared<Desert>(temp_d));
      } else if (obj_type == 3) {
        Burger temp_bgr({}); std::cin >> temp_bgr;
        comanda_.produse.insert(std::make_shared<Burger>(temp_bgr));
      } else {
        std::cout << "Tip nedefinit" << std::endl;
      }
    }
    return in;
  }

  int getId() const {
    return id;
  }

  // Nu am implementat
  float computeTotalEnergy();

  ~Comanda() = default;
};
