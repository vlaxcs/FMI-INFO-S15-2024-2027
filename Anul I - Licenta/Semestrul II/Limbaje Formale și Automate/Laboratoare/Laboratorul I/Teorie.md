# Automat finit
## 5 tuplu: M = (Q, sigma, delta, qa, F)
- Q - mulțimea stărilor <=> Q = {q1, q2}
- Sigma - mulțimea simbolurilor utilizate de limbaj (alfabet)
 ..

# Automat care computează
Fie M = (Q, sigma, delta, qa, F (translate)) și un string w = w1w2...wn, atunci:
|w| = n
{w1, w2, ..., wn (indici)} inclus sau egal cu Sigma (translate!) ::)

Definim faptul că M acceptă w dacă există o mulțime R inclusă sau egală cu Q (translate),
R inlcusă sau egală în Q,
R = {r0, r1, ..., rn}
R trebuie să îndeplinească simultan condițiile:
- r0 = q0
- rn aparține lui F
- d(r1, wi + 1) = ri + 1

... de la Vlad