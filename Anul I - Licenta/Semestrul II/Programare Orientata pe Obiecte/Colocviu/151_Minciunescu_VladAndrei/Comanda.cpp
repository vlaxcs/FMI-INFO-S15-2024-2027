/* Minciunescu Vlad - 151
CLion MinGW | See CMakeLists.txt
Livia Magureanu */


#include "Comanda.h"

// Nu am implementat
float Comanda::computeTotalEnergy(){
	float total_energy(0);
	for (const auto& produs : this->produse){
 		total_energy += produs->computeEnergy();
	}

    return total_energy;
};