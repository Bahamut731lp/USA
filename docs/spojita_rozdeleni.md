# 05 - Spojitá rozdělení pravděpodobnosti

## Rovnoměrné rozdělení
### Příklad 6
> [!example] Funkce náhodné číslo generuje data z rovnoměrného rozdělení s parametry a=0, b=1. Transformujte tato data tak, aby a=10 a b=15. Tj. byla rovnoměrně rozdělena mezi <10,15>.

```matlab
a = 10
b = 15
x = 0.5

y = (b - a) * x + a
```

### Příklad 7
> [!TODO] Dodělat

### Příklad 8
> [!TODO] Dodělat

### Příklad 9
> [!TODO] Dodělat

## Exponenciální rozdělení
### Příklad 10
> [!example] Uveďte příklady, kde data jsou z exponenciálního rozdělení.

> [!TODO] Dodělat

### Příklad 11
> [!example] Zkuste vysvětlit, co představuje intenzita náhodného jevu (u tohoto rozdělení je konstantní).

> [!TODO] Dodělat

### Příklad 12
> [!example] Doba do poruchy zařízení lze popsat exponenciálním rozdělením. Data o poruchách máte uvedeny v souboru P0512.mat. Vypočtěte parametry exponenciálního rozdělení a střední dobu do poruchy (střední hodnota rozdělení). 

```matlab
x = importdata("P0512.mat")
h = expfit(x)
lambda = 1 / h
```

### Příklad 13
> [!example] Doba do poruchy zařízení je popsána exponenciálním rozdělením, kde střední doba do poruchy E(T)=2000 h. Vygenerujte 10, 100 a 1000 dat z tohoto rozdělení a vypočtěte z dat střední hodnotu a rozptyl. Všimněte si, že pravděpodobně 1000 vstupních dat bude mít nejblíže k střední hodnotě 2000 h. Pro vektor 1000 dat vypočtěte medián. Všimněte si, že medián není roven střední hodnotě.

```matlab
% Vůbec nemám tušení, jestli je tohle dobře lol
for index = 1:3
    data = exprnd(2000, [1 10^index]);
    stredni = mean(data)
    rozptyl = var(data)
    med = median(data)
    disp("=====")
end
```

### Příklad 14
> [!example] Vypočtěte z hustoty pravděpodobnosti střední hodnotu, rozptyl, směrodatnou odchylku, šikmost a špičatost.

> [!TODO] Dodělat

### Příklad 15
> [!example] Doba opravy má exponenciální rozdělení. Určete střední dobu opravy, jestliže do 60 minut je opraveno 30 % výrobků

> [!TODO] Dodělat

### Příklad 16

> [!TODO] Dodělat

### Příklad 17
> [!example] Výrobek má střední dobu do poruchy 3 roky. Jaká je pravděpodobnost, že se porouchá v záruce, tj. v prvních dvou letech provozu.

```matlab
lambda = 1/3;
1 - exp(-lambda*2)
```

## Weibullovo rozdělení
### Příklad 18
