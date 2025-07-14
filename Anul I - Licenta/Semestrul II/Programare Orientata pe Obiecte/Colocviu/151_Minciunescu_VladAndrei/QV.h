/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#pragma once
#include "Angajat.h"
#include "Comanda.h"
#include "types/TipAngajat.h"

#include <unordered_map>
#include <memory>
#include <queue>

class QV {
private:
    std::unordered_map<int, std::shared_ptr<Angajat>> angajati;
    std::unordered_map<int, std::shared_ptr<Comanda>> comenzi;
    // fara greater<> ca vrem heap de max
    std::priority_queue<std::pair<float, std::shared_ptr<Comanda>>> comenzi_prioritare;

    QV() : angajati({}) {}

public:
    static QV &getInstance() {
        static QV instance;
        return instance;
    }

    QV(const QV&) = delete;
    QV &operator=(const QV&) = delete;

    void showEmployeeCount(const TipAngajat& tip_angajat);
    void addEmployee(const TipAngajat& tip_angajat, const float energy_points_);

    void simultateCycle();

    ~QV() = default;
};
