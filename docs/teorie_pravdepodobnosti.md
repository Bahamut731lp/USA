# Úvod do teorie pravděpodobnosti

## Klasická pravděpodobnost

### Příklad 3
> [!example] Dřevěnou kostku o straně 5cm natřeme na červeno a rozřezeme na krychle o hraně 1 cm. Určete pravděpodobnost, že vylosujete krychličku, která:
> - Nebude obarvena
> - Bude obarvena na jedné stěně
> - Bude obarvena na dvou stěnách
> - Bude obarvena na třech stěnách

Pokud kostku rozřežeme na krychle o hraně 1 cm, tak neobarvené budou právě ty, které nejsou venku. Tudíž to bude mini-krychle uvnitř o rozměrech 3x3x3.

```matlab
% Dělíme centimetry centimetrama
neobarvena = 3^3 / 125

% Připočteme vnitřní z venkovní strany
jedna = 3 * 2 * 3 * 3 / 125

dve = 4 * 3 * 3 / 125

tri = 2 * 4  / 125
```

### Příklad 4
> [!example] Máme 10 druhů minerálek. 6 je perlivých, zbývající neperlivé. Určete pravděpodobnost, že z náhodně vybraných 3 minerálek budou
> - Všechny perlivé.
> - Jedna perlivá, ostatní neperlivé.
> - Jaké jsou elementární jevy pokusu?
> - Dokažte výpočtem, že součet pravděpodobností přes všechny elementární jevy je roven 1.

```matlab
%% Všechny perlivé
nchoosek(6,3) / nchoosek(10,3)
% nebo
hygepdf(3, 10, 6, 3)


%% Jedna perlivá, ostatní neperlivé
nchoosek(6,1) * nchoosek(10-6, 3-1) / nchoosek(10,3)
% nebo
hygepdf(1, 10, 6, 3)
```

Elementární jevy pokusu jsou: 0 perlivých, 1 perlivá, 2 perlivé, 3 perlivé

### Příklad 5
> [!example] Ve hře štastných deset je v osudí 80 míčků, z nichž se losuje 20. Sázející vybere 10 čísel. Určete pravděpodobnost, že uhádně právě 0 až 10 čísel.

```matlab

for index = 0:10
    nchoosek(10, index) * nchoosek(80-10, 20 - index) / nchoosek(80, 20)
    % nebo
    hygepdf(index, 80, 10, 20)
end
```

### Příklad 6
> [!example] 20 studentů má být rozděleno na 4 stejně početné skupiny. Jaká je pravděpodobnost, že A a B budou ve stejné skupině?

```matlab
pocet_ve_skupine = 20/4;

sance_prvniho = 20/20 % Tenhle si může vybrat
sance_druhyho = (pocet_ve_skupine - 1) / 19
```

### Příklad 7
> [!example] Jaká je pravděpodobnost, že z náhodně poskládaných písmen A,A,B,C,D,E,E sestrojíte slovo ABECEDA?

```matlab
a = 2
b = 1
c = 1
d = 1
e = 2

moznosti = factorial(a + b + c + d + e) / ...
(factorial(a) * factorial(b) * factorial(c) * factorial(d) * factorial(e))
sance = 1 / moznosti
```

```diff
sance = 7.9365e-04
```

### Příklad 8
> [!example] Jaká je pravděpodobnost, že mezi 3 mariášovými kartami náhodně vytažených z balíčku bude právě 1 eso?

```matlab
hygepdf(1, 32, 4, 3)
```

### Příklad 9
Neexistuje :(

### Příklad 10
> [!example] Postupně vyndávám koule z urny, kde jsou 3 bílé, 5 černých a 4 červené koule. Jaká je pravděpodobnost, že červenou vytáhnu dříve než bílou? Koule nevracíme. 

Moc složitý.

## Geometrická pravděpodobnost

### Příklad 11
> [!example] Ve čtverci o délce hrany 3 cm je kružnice o poloměru 1 cm. Jaká je pravděpodobnost, že náhodně zvolený bod ze čtverce je zároveň uvnitř kružnice.

```matlab
pi * 1^2 / 3^2
```

### Příklad 12
> [!example] Dva lidé si dají schůzku mezi 12. a 13. hodinou. Příjdou v tomto čase zcela náhodně. Jaká je pravděpodobnost, že se potkají, přichází-li nezávisle a čeká-li jeden na druhého přesně 15 minut.