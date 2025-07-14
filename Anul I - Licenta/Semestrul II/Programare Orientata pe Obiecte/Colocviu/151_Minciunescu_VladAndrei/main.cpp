/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */

#include <iostream>
#include "Produs.h"
#include "QV.h"

int main() {
    QV& app = QV::getInstance();

    // 0. Adaugarea angajatilor
    app.addEmployee(TipAngajat::Livratori, 100);
    app.addEmployee(TipAngajat::Bucatari, 125);
    app.addEmployee(TipAngajat::Bucatari, 100);
    app.addEmployee(TipAngajat::Casieri, 100);

    // 1. Afisarea numarului de angajati pentru fiecare tip in parte
    app.showEmployeeCount(TipAngajat::Bucatari);
    app.showEmployeeCount(TipAngajat::Casieri);
    app.showEmployeeCount(TipAngajat::Livratori);

    // 2. Simularea unui ciclu
    app.simultateCycle();

    // 3. Optimizez cu heap si useEnergy() n-am apucat, le am declarate virtual pe toate
    // 4. Am Priority Queue / Heap

    return 0;
}