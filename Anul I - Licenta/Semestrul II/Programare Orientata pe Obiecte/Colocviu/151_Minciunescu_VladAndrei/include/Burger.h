/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#pragma once
#include "Produs.h"
#include "types/Ingredients.h"
#include <unordered_map>
#include <iostream>

class Burger : public Produs {
private:
    std::unordered_map<Ingredients, int> recipe_list;

public:
    Burger(const std::string &name_, float quantity_, const std::unordered_map<Ingredients, int> &recipe_list)
        : Produs(name_, quantity_),
          recipe_list(recipe_list) {
    }

    Burger() = default;

    friend std::istream &operator>>(std::istream& in, Burger& burger) {
        int value;
        std::cout << "Onion? Number / 0"; std::cin >> value;
        if (value) {
            burger.recipe_list[Ingredients::Onion] = value;
        }
        std::cout << "Tomato? Number / 0"; std::cin >> value;
        if (value) {
            burger.recipe_list[Ingredients::Tomato] = value;
        }
        std::cout << "Sauce? 1 / 0"; std::cin >> value;
        if (value) {
            burger.recipe_list[Ingredients::Sauce] = 1;
        }
        return in;
    }

    float computeEnergy() override;

    ~Burger() override = default;
};
