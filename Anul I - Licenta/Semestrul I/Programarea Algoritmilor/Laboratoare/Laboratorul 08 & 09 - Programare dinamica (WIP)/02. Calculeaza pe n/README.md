# Problema [Calculează pe n](https://www.pbinfo.ro/probleme/3672/calculeaza-pe-n)

## Stare
- d[i] - Numarul minim de operatii necesare pentru a ajunge la numarul i

## Stare inițială: 
- d[1] = 0 - Numarul 1 este la baza celorlalte operatii, nu poate fi calculat

## Relația de recurență: 
`d[i] = 1 + min(d[i - 1], d[i / 2], d[i / 3])`

## Soluție (bottom-up)
```
#include <algorithm>
using namespace std;
int main()
{
	int n; scanf("%d", &n);
	int* d = (int*)malloc((n + 1) * sizeof(int)); // d.resize(n + 1) cu vector<int> d;
	
	d[1] = 0;
	for (int i = 2; i <= n; ++i)
	{
		int minLastValue(d[i - 1]);
		if (i % 2 == 0) minLastValue = min(minLastValue, d[i / 2]);
		if (i % 3 == 0)	minLastValue = min(minLastValue, d[i / 3]);
		
		d[i] = 1 + minLastValue;
	}
	printf("%d", d[n]);
	return 0;
}
```