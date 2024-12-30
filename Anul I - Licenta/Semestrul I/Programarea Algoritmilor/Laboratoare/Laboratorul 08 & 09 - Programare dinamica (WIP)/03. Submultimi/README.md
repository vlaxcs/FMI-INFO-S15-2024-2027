03. Problema [NumarDeSubmultimi](https://www.pbinfo.ro/probleme/3213/numardesubmultimi)

## Stare
- d[i] - Numărul de submulțimi formate din elemente de la 1 la i

## Stare initiala: 
- d[1] = 1 - Submulțimea {1}
- d[2] = 2 - Submulțimile {1}, {2}

## Relatie de recurenta: 
- d[i] = d[i - 1] + d[i - 2] + 1

- d[i - 1] (Nu îl adăugam pe i submultimile anterioare)
- d[i - 2] (În adăugăm la orice submulțime anterioară, dar nu învecinată)
- 1 (Îl adăugăm în submulțimea formată doar din elementul i)

```
#include <algorithm>
#define MOD 777013
int main()
{
	int n; scanf("%d", &n); int* d = (int*)malloc(n * sizeof(int));
	d[1] = 1; d[2] = 2;
	
	for (int i = 3; i <= n; ++i)
		d[i] = (d[i - 1] + d[i - 2] + 1) % MOD;
	
	printf("%d", d[n]);
	return 0;
}
```