# Řešení zkoušek

## Zkouška z 22.6.2023

### Příklad 1
> [!quote] Sledovali jsme věk dožití otce a jeho nejstaršího syna. Otestujte na hladině významnosti 5%, zda došlo k prodloužení života syna alespoň o 2 roky.
> Otec: `[71,72,74,76,77,78,71,72,73,75,77,64,49,52,63,65,68,71,72,75,84,81,79,76,73,75,79,82]`
>
> Syn: `[72,74,77,69,78,82,84,78,79,79,77,68,59,72,81,68,69,73,76,78,86,87,88,91,83,87,88,93]`
>
> Uveďte hypotézy, postup, výsledky a závěr z výpočtů.

Naším cílem je vypočítat, zda došlo k prodloužení života syna. To znamená, že pokud syn žije déle, bude mít vyšší **střední hodnotu/medián** věku dožití. Jestli počítáme střední hodnotu nebo medián rozhodneme na základě toho, jestli mohou být data z normálního rozdělení, nebo pokud z něho určitě nejsou.

- V případě, že z normálního rozdělení být mohou, použijeme testy střední hodnoty
- V případě, že alespoň jeden nemůže být z normálního rozdělení, testujeme medián.

Pro ověření, zda jsou data z normálního rozdělení, používáme `lillietest`.

$$
\begin{aligned}
h_0&: \text{Vektory jsou z norm. rozdeleni} \\
h_a&: \text{Alespon jeden z vektoru nemuže být z norm. rozdeleni}
\end{aligned}
$$

```matlab
[h_otec, p_otec] = lillietest(otec, "Alpha", 0.05, "Distr","norm");
[h_syn, p_syn] = lillietest(syn, "Alpha", 0.05, "Distr","norm");
```

```
h_otec = 1
p_otec = 0.0011

Warning: P is greater than the largest tabulated value, returning 0.5. 

h_syn = 0
p_syn = 0.5000

```

Jak můžeme vidět z výsledků, pro vektor `otec` vyšla `p-value` menší než hladina významnosti (`0.05`), tudíž zamítáme hypotézu \(h_0\), že jsou oba vektory z normálního rozdělení a budeme pracovat s mediány.

Pokud potřebujeme porovnat dva mediány, používáme *Mann-Whitneyův test mediánů*, neboli `ranksum` test. Ten také požaduje, aby výběry měly stejné rozptyly. Provedeme tedy intervalový odhad roztypů výběrů s normálním rozdělením, neboli `vartest2` test.

$$
\begin{aligned}
h_0&: \sigma_{\text{otec}}^2  = \sigma_{\text{syn}}^2 \\
h_a&: \sigma_{\text{otec}}^2  \not= \sigma_{\text{syn}}^2
\end{aligned}
$$

```matlab
[h,p] = vartest2(otec,syn,0.05,'both')
```

```
h = 0
p = 0.9630
```

Jak můžeme vidět, oba vektory (výběry) mají na hladině významnosti 5% stejné rozptyly. S tímto ověřeným předpokladem můžeme přejít k `ranksum` testu.

```matlab
[p_ranksum,h_ranksum,stats] = ranksum(otec,syn - 2,"alpha",0.05, "method","exact", "tail","left")
```

```
p_ranksum = 0.0460
h_ranksum = logical 1
stats = 
  struct with fields:
    ranksum: 695
```