/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */

#include "QV.h"
#include "Livrator.h"
#include "Bucatar.h"
#include "Casier.h"
#include <iostream>
#include <format>
#include <unordered_map>

void QV::showEmployeeCount(const TipAngajat &tip_angajat) {
    std::unordered_map<TipAngajat, std::string> tipuri = {
        { TipAngajat::Bucatari, "Bucatar" },
        {TipAngajat::Casieri, "Casier"},
        {TipAngajat::Livratori, "Livrator"}
    };

    int count(0);

    for (const auto& [id, angajat] : angajati) {
        if (const auto lvr = std::dynamic_pointer_cast<Livrator>(angajat)
            && tip_angajat==TipAngajat::Livratori) {
            count++;
        } else if (const auto buc = std::dynamic_pointer_cast<Bucatar>(angajat)
            && tip_angajat==TipAngajat::Bucatari) {
            count++;
        } else if (const auto cas = std::dynamic_pointer_cast<Casier>(angajat)
            && tip_angajat==TipAngajat::Casieri) {
            count++;
        }
    }

    std::cout << std::format("> Angajati cu meseria de {}: {}\n", tipuri[tip_angajat], count);
}

void QV::simultateCycle() {
    bool answer;
    std::cout << "Adaugare comanda? (1/0)";
    std::cin >> answer;
    while (answer == 1) {
         Comanda temp({});
         std::cin >> temp;
         comenzi[temp.getId()] = std::make_shared<Comanda>(temp);

        // Nu am apucat să implementez
        comenzi_prioritare.emplace(temp.computeTotalEnergy(), comenzi[temp.getId()]);


        std::cout << std::format("Comanda #{} a fost inregistrata. Consum de energie necesar: {}", temp.getId(), temp.computeTotalEnergy()) << std::endl;
        std::cout << comenzi.size() << " comenzi inregistrate" << std::endl;


        std::cout << "Adaugare comanda? (1/0)";
        std::cin >> answer;
    }
}

void QV::addEmployee(const TipAngajat& tip_angajat, const float energy_points_) {
    if (tip_angajat == TipAngajat::Bucatari) {
        Bucatar temp(energy_points_);
        angajati[temp.getId()] = std::make_shared<Bucatar>(temp);
    } else if (tip_angajat == TipAngajat::Casieri) {
        Casier temp(energy_points_);
        angajati[temp.getId()] = std::make_shared<Casier>(temp);
    } else if (tip_angajat == TipAngajat::Livratori) {
        Livrator temp(energy_points_);
        angajati[temp.getId()] = std::make_shared<Livrator>(temp);
    } else {
        std::cerr << "Unknown employee type";
    }
}
