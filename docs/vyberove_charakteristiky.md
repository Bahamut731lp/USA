# Výběrové charakteristiky
Při vyvozování závěrů chceme pracovat na celé populaci - to znamená na všech zástupcích s nějakou vlastností. Může se jednat o všechny dívky, všechny chlapce, všechny starce, všechny cyklisty, atd. Bohužel ale není běžné mít k dispozici vzorky z celé populace, a tak musíme závěry vyvozovat z menších částí populace, tzv. __výběrů__, které nám poté pomáhají lépe odhadnout informace o celé populaci.

Pokud pracujeme s informacemi o celé populaci, říkáme jim __populační charakteristiky__, obdobně pro vlastnosti výběrů se zavedl pojem __výběrové charakteristiky__. Populační charakteristiky jsou konstantní a nemění se - páč se nemění ani samotná populace. U výběru už tomu ale tak není, každý výběr může mít trochu jiné charakteristiky.

Podobnou myšlenku lze aplikovat i na pravděpodobnost, kdy u každého jevu známe jeho pravděpodobnost a je neměnná. Naopak můžeme pracovat s naměřenými daty, kde se pravděpodobnost úspěchu snažíme zjistit z naměřených dat.

_Tabulka níže porovnává charakteristiky pro pravděpodobnost a pro statistiku (naměřená data)_

|Pravděpodobnost|Statistika|
|:--:|:--:|
|Střední hodnota|Výběrový průměr|
|Rozptyl|Výběrový rozptyl|
|Směrodatná odchylka|Výběrová směrodatná odchylka|
|Pravděpodobnost jevu|Relativní četnost jevu|
|Medián|Výběrový medián|


## Výběrové charakteristiky

### Příklad 3
> [!example] Vygenerujte 10000 čísel z normálního rozdělení s parametry mi = 5, sigma^2 = 4 a vyneste je do grafu ve formě histogramu o 100 sloupcích. Do druhého obdobného grafu vyneste vygenerovaných 10000 čísel z normálního rozdělení s parametry mi = -5, sigma^2 = 4

```matlab
histogram(normrnd(5, 2, [1,10000]), 1000)
histogram(normrnd(-5, 2, [1,10000]), 1000)
```

### Příklad 4
> [!example] Náhodná veličina A má E(X)=5 a D(X)=4, náhodná veličina B má E(X)=3 a D(X)=6, náhodná veličina C má E(X)=2 a D(X)=8. (Jsou nezávislé.) Vypočtěte střední hodnotu a rozptyl výsledné náhodné veličiny X, která je dána vzorcem X=A+B+C a Y=A+B-C.

```matlab
E_X = 5 + 3 + 2
D_X = 4 + 6 + 8

E_Y = 5 + 3 - 2
D_Y = 4 + 6 - 8
```

### Příklad 5
> [!example] Dokažte následující tvrzení. Vynásobením naměřených dat se střední hodnotou E(X) a rozptylem D(X) konstantou c, kde c>0, bude střední hodnota naměřených dat rovna cE(X) a rozptyl c2D(X). Zkuste ověřit na datech.

> [!todo] To víš že jo, Pepiku.

### Příklad 6
> [!example] Náhodná veličina A má E(X)=5 a D(X)=4, náhodná veličina B má E(X)=0 a D(X)=16. Vypočtěte střední hodnotu a rozptyl výsledné náhodné veličiny X, která je dána vzorcem X=A+3*B.

```matlab
E_X = 5 + 0
% Tbh nevim, proč ta trojka musí být na druhou
% Jediný, co mě napadá, je to, že rozptyl jako takovej je na druhou,
% takže nestačí 3*sigma^2, ale musíš to mít celý na druhou... i guess
D_X = 4 + (3^2)*16
```

## Centrální limitní věta
Centrální limitní věta nám říká, že za určitých podmínek lze součet náhodných veličin \(\sum_{i=1}^{n}{X_i}\), nebo výběrový průměr \(\bar{X}\) jako
$$\large
\begin{aligned}
    \sum_{i=1}^{n}{X_i} &\sim N\left(n\cdot\mu_x, n\cdot\sigma^2\right) \\
    \bar{X} &\sim N\left(\mu_x, \frac{\sigma^2}{n}\right)
\end{aligned}
$$

Obvykle se za dostatečně velké označují výběry o rozsahu 30 a větší

### Příklad 7
> [!example] Máte vygenerováno 1000 náhodných čísel z rovnoměrného rozdělení <0,1>. Určete pravděpodobnost, že průměr všech vygenerovaných čísel bude vyšší než 0.520.

```matlab
E_X = (0 + 1) / 2 % Střední hodnota
D_X = (0 - 1)^2 / 12 % Rozptyl
n = 1000 % počet

% N(E_X, D_X * 1 / n)
normcdf(1 - 0.52, E_X, sqrt(D_X * 1 / n))
```

### Příklad 8
> [!example] Životnost komponenty má exponenciální rozdělení se střední hodnotou 5 let. Určete pravděpodobnost, že 100 náhodně vybraných komponent bude mít v průměru životnost nižší než 4 roky.

Zjištujeme __průměrnou životnost__, použijeme tedy vzoreček pro výběrový průměr.

```matlab
E_X = 5 % = 1 / lambda 
D_X = 5^2 % = 1 / lambda^2
n = 100

prumer = normcdf(4, E_X, sqrt(D_X / n))
```

> [!bug] Tady má Pepik blbost, I guess
> V zadání se píše, že má být životnost v průměru nižší než 4 roky, ale výpočet i výsledek odpovídá spíš situaci, kdy bude nižší nebo rovný 4 rokům. V dalším příkladě je třeba možno, aby byla váha 6000 kg, protože jí nesmí překročit, ale může být stejná...

### Příklad 9
> [!example] Zatížení letadla s 64 místy nemá překročit 6000 kg. Jaká je pravděpodobnost, že při plném obsazení bude tato hodnota překročena, má-li hmotnost cestujícího střední hodnotu 90 kg a směrodatnou odchylku 10 kg.

__Sčítáme váhu cestujících__, použijeme tedy vzorec pro součet náhodných veličin.

```matlab
E_X = 90
D_X = 10^2
n = 64

1 - normcdf(6000, n * E_X, sqrt(n * D_X))
```

### Příklad 10
> [!example] Počet chyb na jedné straně textu má střední hodnotu 3 a rozptyl 4. Jaká je pravděpodobnost, že na 400 stranách bude méně než 1000 chyb.

__Sčítáme počet chyb__, použijeme tedy vzorec pro součet náhodných veličin.

```matlab
E_X = 3
D_X = 4
n = 400

normcdf(1000, n * E_X, sqrt(n * D_X))
```

### Příklad 11
> [!example] Stokrát hodíme šestistěnnou kostkou. Jaká je pravděpodobnost, že součet hodů bude mezi 320 a 380.

__Sčítáme hodnoty hodů__, použijeme tedy vzorec pro součet náhodných veličin.

> [!warning] Pozor na výpočet rozptylu
> Kdybyste vypočítali rozptyl přes `var([1 2 3 4 5 6])`, vrátí vám to jiný výsledek, než vlastně chceme. Je to kvůli tomu, že funkce `var(x)` počítá výběrový rozptyl, to znamená rozptyl neznáme náhodné veličiny, u které neznáme populační střední hodnotu. V případě hodu kostkou ale tuto střední hodnotu známe a je konstantní - jedná se o \(3.5\). Tato hodnota se nikdy nezmení, protože se nám ani nezmění populace jevů.
>
> Výběrový rozptyl by ve jmenovateli měl \(n - 1\), protože se ztrácí stupeň volnosti odhadem střední hodnoty. Tím, že střední hodnotu tady ale neodhadujeme, není potřeba odečítat jeden stupeň volnosti.

```matlab
% Průměr
E_X = mean([1 2 3 4 5 6]) 
% Rozptyl
D_X = sum(([1 2 3 4 5 6] - 3.5).^2) / 6
n = 100

% V druhém normcdf nedáváme 320, protože ji po odečtení furt chceme mít v intervalu
% Kdyby tam bylo 320, tak vyloučíme pravděpodobnost, že součet bude právě 320
normcdf(380.5, n * E_X, sqrt(n * D_X)) - normcdf(319.5, n * E_X, sqrt(n * D_X))
```

### Příklad 12
> [!example] 600 krát hodíme kostkou. Pomocí binomického rozdělení, Poissonova rozdělení a centrální limitní věty určete, jaká je pravděpodobnost, že šestka padne 105 a vícekrát.

> [!help] Odkud se berou parametry do CLV
>Centrální limitní věta ve své podstatě říká, že součet nezávislých a identicky rozdělených náhodných veličin s konečnou střední hodnotou a rozptylem se přibližuje k normálnímu rozdělení, jakmile je počet těchto veličin dostatečně velký. Jinak řečeno, rozdělení se s dostatečně velkým počtem pokusů hodně podobá normálnímu. A to platí i pro binomické rozdělení. Když bychom tedy vykreslili binomické rozdělení a normální rozdělení se stejnými parametry, tak budou při 600ti hodech vypadat prakticky stejně - proto můžem použít i stejné parametry.

```matlab
n = 600
p = 1/6

1 - binocdf(104.5, n, p)
1 - poisscdf(104.5, n * p)

% Střední hodnota binomického rozdělení
E_X = n * p
% Rozptyl binomického rozdělení
D_X = n * p * (1 - p)
% Pravděpodobnost dle CLV
1 - normcdf(104.5, E_X, sqrt(D_X))
```

### Příklad 13
> [!example] V osudí je 16 bílých a 14 černých koulí. Jaká je pravděpodobnost, že při 150 tazích jedné koule (s vracením) vytáhneme bílou právě 77x.
> a) Řešte pomocí binomického rozdělení.
> b) Řešte pomocí Poissonova rozdělení.
> c) Řešte pomocí centrální limitní věty.

>[!bug] Tady Pepikovi něco nesedí?
> V řešení má napsaný, že nelze použít `normpdf`, protože pravděpodobnost, že bude přesně 77 je nulová a protože se jedná o přechod z diskrétního na spojité rozdělení. Já si ale dovolim oponovat, možná tomu tak v teorii je, ale v praxi tam normálně `normpdf` dát jde a dává to rozumný výsledek.

```matlab
n = 150
p = 16/30

binopdf(77, n, p)
poisspdf(77, n * p)

E_X = n * p
D_X = n * p * (1 - p)

normpdf(77, E_X, sqrt(D_X))
```

## Rozdíl výběrových průměrů
### Příklad 14
> [!example] Průměrný plat v České republice je 27 000 Kč se směrodatnou odchylkou 8000 Kč. Průměrné náklady na bydlení jsou 7000 Kč se směrodatnou odchylkou 2000 Kč. Vypočtěte pravděpodobnost, že člověku zůstane alespoň 25000 Kč, jestliže z platu odečteme náklady na bydlení.

```matlab
E = 27000 - 7000
D = 8000^2 + 2000^2

1 - normcdf(25000, E, sqrt(D))
```

### Příklad 15
> [!example] V roce 2015 a 2016 probíhal průzkum ohledně měsíčních výdajů za pivo. Zjistěte pravděpodobnost, že v roce 2016 dávají lidé za pivo více než v roce 2015.

```matlab
x2015=[587,124,651,1212,1074,523,273,800,485,961,1683,2411]
x2016=[121,524,2612,847,1310,1521,951,1000,521,12,190,263,321,587,953]

E = mean(x2016) - mean(x2015)
D = (var(x2015) / length(x2015)) + (var(x2016)/length(x2016))

% Nulu používáme, protože nám normcdf řekne, jestli rozdíl výběrových průměrů byl nula či míň
1 - normcdf(0, E, sqrt(D))
```

### Příklad 16
> [!example] Odvoďte vzorec pro rozdíl výběrových průměrů:

> [!todo] Ne :)

## Relativní četnost

### Příklad 17
> [!example] Zeptali jsme se 1000 respondentů na oblibu místního cholerického politika. Obdrželi jsme kladný výsledek od 168 respondentů. Místní cholerický politik však říká, že jeho obliba je 55 procent. Určete pravděpodobnost, že jeho tvrzení je pravdivé a jeho obliba je 55%.

```matlab
n = 1000
p = 168 / 1000 % 0.168

pi = 0.55
normcdf(p - pi/sqrt(pi * (1 - pi) / n), 0, 1)
```

Místní politik lže.

### Příklad 18
> [!example] Zeptali jsme se 1000 respondentů na určitý výrok. 60 % řeklo, že s ním souhlasí. Určete pravděpodobnost, že po zeptání celé společnosti bude výsledek minimálně: 45%, 50%, 55%, 59 %, 60 %, 61 %, 65 %, 70 %. 
> - Porovnejte výsledky mezi sebou. Lze vidět, že výsledné pravděpodobnosti 45 % i 70 % jsou velmi málo pravděpodobné.  

```matlab
n = 1000
pi = 0.6

p = 0.45;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.5;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.55;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.59;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.60;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.61;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.65;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.70;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)
```

### Příklad 19
> [!example] Jak se změní výsledky z příkladu 18, jestliže se zeptáme pouze 100 lidí?

Pravděpodobnosti se zvednou napříč odhady.

```matlab
n = 100
pi = 0.6

p = 0.45;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.5;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.55;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.59;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.60;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.61;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.65;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)

p = 0.70;
1 - normcdf((p-pi)/sqrt(pi *(1-pi)/n), 0, 1)
```

### Příklad 20
> [!example] V roce 2015 jsme se zeptali 250 respondentů na určitý názor – 62 odpovědělo souhlasně. Obdobně v roce 2016 jsme se zeptali 340 respondentů na stejnou otázku – 141 odpovědělo souhlas. Zjistěte pravděpodobnost, že rozdíl výběrových četností roků 2016 a 2015 je kladný.

```matlab
n_1 = 250
n_2 = 340

pi_1 = 62/n_1
pi_2 = 141/n_2

E = pi_2 - pi_1
D = pi_1 * (1 - pi_1) / n_1 + pi_2 * (1 - pi_2) / n_2

1 - normcdf(0, E, sqrt(D))
```

### Příklad 21
> [!example] Řešte příklad 20 s následující úpravou:
> - Určete pravděpodobnost, že se zvýšila podpora tohoto názoru minimálně o 10 %.

```matlab
n_1 = 250
n_2 = 340

pi_1 = 62/n_1
pi_2 = 141/n_2

E = pi_2 - pi_1
D = pi_1 * (1 - pi_1) / n_1 + pi_2 * (1 - pi_2) / n_2

1 - normcdf(0.1, E, sqrt(D))
```

## Chí-Kvadrát rozdělení
### Příklad 22
> [!example] Zjistěte 5 a 95% kvantil chí kvadrát rozdělení s 10 stupni volnosti

```matlab
chi2inv(0.05, 10)
chi2inv(0.95, 10)
```

### Příklad 23
> [!example] Vykreslete graf hustoty pravděpodobnosti pro chí kvadrát rozdělení s 2, 4 a 6 stupni volnosti.

> [!todo] :)

### Příklad 24
> [!example] Mějme data z \(\chi^2\) rozdělení s 12 stupni volnosti. Určete pravděpodobnost \(P(X>20)\). 
```matlab
1 - chi2cdf(20, 12)
```