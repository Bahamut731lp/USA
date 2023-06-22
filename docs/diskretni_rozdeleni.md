# 04 - Diskrétní rozdělení

## Alternativní rozdělení

### Příklad 1
> [!example] Vypočtěte z pravděpodobnostní funkce (P(X=1)=p; P(X=0)=1-p) střední hodnotu, směrodatnou odchylku, rozptyl, šikmost a špičatost.

Pravděpodobnostní funkce odpovídá pravděpodobnostní funkci alternativního rozdělení (tj. binomické rozdělení s parametrem \(n=1\))

|Vlastnost|Hodnota|
|:--:|:--:|
|Střední hodnota|\(p\)|
|Rozptyl|\(p\cdot(1-p)\)|
|Směrodatná odchylka|\(\sqrt{p\cdot(1-p)}\)|
|Šikmost|\(\sqrt{\frac{(1 - 2p)}{(p\cdot(1 - p))}}\)|
|Špičatost|\((3*p^2 - 3*p + 1)/(p*(1 - p))\)|

## Binomické rozdělení
### Příklad 2
> [!example] Jakým způsobem se odlišuje binomické rozdělení od alternativního?

- Alternativní rozdělení je binomické rozdělení s parametrem n = 1
- Jinak řečeno, jedná se o pravděpodobnost úspěchu v jednom pokusu

### Příklad 3
> [!example] Napište si vzorec pro pravděpodobnostní funkci Binomického rozdělení a uvědomte si význam jednotlivých členů

```matlab
nchoosek(n, k)*p^k*(1-p)^(n-k)
```

### Příklad 4
> [!example] Pětkrát hodíme mincí. Určete pravděpodobnost, že orel padne právě dvakrát. Určete pravděpodobnost, že padne alespoň 4.

```matlab
% Orel padne dvakrát z pěti pokusů
binopdf(2, 5, 1/2)

% Orel padne alespoň 4krát P(x >= 4)
binopdf(4, 5, 1/2) + binopdf(5, 5, 1/2)

% Taky to lze vypočítat jako pravděpodobnost,
% že v 5 pokusech padne jednou panna
binocdf(1, 5, 1/2)
```

### Příklad 5a
> [!example] Pravděpodobnost, že ve sportce uhádnu první cenu je 1/13983816. Vypočtěte pravděpodobnost, že když vsadím za rok 1000x, že vyhraji právě dvakrát první cenu

```matlab
binopdf(2,1000,1/13983816)
```

### Příklad 5b
> [!example] Zásilka obsahuje 80% kvalitních a 20% nekvalitních výrobků. Náhodně s vracením vybereme 5 výrobků. Určete pravděpodobnost, že:
> - Právě 3 budou kvalitní
> - Alespoň 3 budou kvalitní

```matlab
% Právě tři - P(X = 3)
binopdf(3, 5, 0.8)

% Alespoň tři - P(X >= 3) => 1 - P(X < 3) => 1 - P(X <= 2)
% Těch 2.5 je inženýrský přístup, aby tam matlab zahrnul i tu dvojku
% Jako ona by tam měla bejt tak jako tak, je to spíš pro lidi, co nedělaj v matlabu
binocdf(2.5, 5, 0.8)
```

### Příklad 6
> [!example] Pravděpodobnost narození děvčete je 0.49. Určete pravděpodobnost, že ve třídě mající 25 dětí bude (neuvažujte jednopohlavní třídy)
> - Právě 10 dívek
> - Alespoň 10 a více dívek
> - Více než 15 dívek
> - Kolik dívek bude ve třídě nejpravděpodobněji

```matlab
% Právě 10 dívek - P(x=10)
binopdf(10, 25, 0.49)

% Alespoň 10 a více dívek - P(X >= 10) => 1 - P(X < 9)
1 - binocdf(9, 25, 0.49)

% Více než 15 dívek - P(X > 15) => 1 - P(X <= 15)
1 - binocdf(15, 25, 0.49)

% Kolik dívek bude ve třídě nejpravděpodobněji
% Hodnotu ještě proženu funkcí floor(), protože
% nedává smysl mít desetiny dívky :)
floor(binostat(25, 0.49))
```

### Příklad 7
> [!example] Pravděpodobnost narození chlapce je 0.51. Určete minimální počet dětí, aby pravděpodobnost, že mezi nimi bude alespoň jeden chlapec, byla větší než 0.99

```matlab
% Geoinv vrátí počet neúspěšných pokusů
% Ta +1 tam je pro dopočtení toho úspěšného pokusu, aneb na kolikátým to actually bude kluk
geoinv(0.99, 0.51) + 1
% Pravděpodobně to nějak jde přes binomický, ale já neviem už
```

### Příklad 8
> [!example] Víme, že mezi výrobky je 10 % vadných. Určete pravděpodobnost, že u 20 náhodně vybraných výrobků bude:
> - Právě 0 vadných
> - Více než 5ks vadných

```matlab
% Právě 0 vadných kusů - P(X = 0)
binopdf(0, 20, 0.1)

% Více než 5 vadných kusů - P(X > 5) => 1 - P(X<=5)
1 - binocdf(5, 20, 0.1)
```

### Příklad 8a
> [!example] Mějme mariášové karty (32 karet, které obsahují 4 esa, 4 krále, 4 filky, ..., 4 sedmičky). Losujete karty z balíčku a vracíte je zpět. Určete pravděpodobnost, že z prvních 7 vylosovaných karet dostanete právě 4 esa nebo krále. A poslední osmá vylosovaná karta bude 7

Pravděpodobnosti jsou v součinu, protože potřebujeme trefit "obě" pravděpodobnosti - funguje to v podstatě jako logický součin.

```matlab
% Chceme 4 karty v 7 losech s tím, že správný los má šanci (4 + 4)/32
% Sedmičku můžeme vylosovat 4x - pro každou barvu jednou
binopdf(4, 7, 8/32) * binopdf(1, 1, 4/32)
```

## Hypergeometrické rozdělení 
### Příklad 9
> [!example] Jak se odlišuje hypergeometrické rozdělení od binomického. Jak byste rozdíl těchto rozdělení simulovali u pokusu, kde máte v krabici \(m\) černých a \(n\) bílých koulí.

- Hypergeometrické rozdělení vyjadřuje pravděpodobnost úspěchu v \(n)\ **závislých** pokusech, binomické rozdělení naopak v **nezávislých** pokusech
- Pokud bychom tahali z krabice koule a vždy je vraceli, simulovali bychom pravděpodobnost pomocí binomického rozdělení. Pokud bychom koule nevraceli, byla by pravděpodobnost simulována hypergeometrickým rozdělením

### Příklad 10
> [!example] Vypočtěte pravděpodobnost, že z 32 karetního balíčku při vylosování 3 karet právě 2 budou esa. Jak se změní pravděpodobnost, jestliže karty do balíčku vracíme a pokud je nevracíme.

```matlab
% Karty vracíme => pokusy jsou závislé a použijeme hypergeometrické rozdělení
hygepdf(2, 32, 4, 3)
```

### Příklad 11
> [!example] V loterii je v osudí 200 čísel, z nichž se losuje 30. Jaká je pravděpodobnost, že vybereme-li náhodně 10 čísel, bude z nich právě 5 vylosovaných. Řešte 
> - Pomocí hypergeometrického rozdělení,
> - Aproximací na binomického rozdělení,
> - Kolik čísel uhádneme nejpravděpodobněji.

```matlab
% Pomocí hypergeometrického rozdělení
hygepdf(5, 200, 30, 10)
% Aproximací na binomické rozdělení
% n_hyge = n_bin, p_bin = M_hyge / N_hyge
binopdf(5, 10, 30/200)
% Kolik jich bude nejpravděpodobněji => střední hodnota rozdělení
floor(hygestat(200, 30, 10))
```

### Příklad 12
> [!example] Vypočtěte pravděpodobnost, že při výběru 10 karet z 32 karetního balíčku bude právě 8 vyšších karet (spodek, filek, král nebo eso). Balíček obsahuje 4 spodky, 4 filky, 4 krále a 4 esa.
> - Řešte pomocí hypergeometrického rozdělení, za předpokladu, že karty nevracíte.
> - Řešte pomocí binomického rozdělení, za předpokladu, že karty vracíte.
> - Odůvodněte rozdíl mezi výše uvedenými výsledky.

```matlab
% Karty vracíme
hygepdf(8, 32, 16, 10)

% Karty nevracíme
binopdf(8, 10, 16/32)
```

### Příklad 12a
> [!example] V osudí je 10000 bílých a 7000 černých koulí. Losujete z nich 30 koulí. Jaká je pravděpodobnost, že vylosujete právě 22 bílých a 8 černých. Odůvodněte prakticky shodnost výsledků.

```matlab
NEVRACIME_BILE = hygepdf(22, 17000, 10000, 30)
NEVRACIME_CERNE = hygepdf(8, 17000, 7000, 30)

VRACIME_BILE = binopdf(22, 30, 10000/17000)
VRACIME_CERNE = binopdf(8,30,7000/17000)
```
## Geometrické rozdělení
### Příklad 13
> [!example] Házíte kostkou. Určete pravděpodobnost, že právě u pátého hodu Vám padne poprvé šestka.

```matlab
geopdf(4, 1/6)
```

### Příklad 14
> [!example] Dva hráči střídavě házejí kostkou. Vyhrává ten, kdo první hodí šestku. Jaká je pravděpodobnost, že vyhraje ten, který začínal.

```matlab
% Pokud má vyhrát začínající hráč, musí být hra ukončena v lichém tahu
% Nevim jak to spočítat more
p_prvni = 0;
p_druhy = 0;
for index = 0:2:100
    p_prvni = p_prvni + geopdf(index, 1/6);
    p_druhy = p_druhy + geopdf(index + 1, 1/6);
end

p_prvni
p_druhy
```

### Příklad 15
> [!example] Distributor prodává knihu. 10% knihkupců ji zakoupilo. Jaká je pravděpodobnost, že distributor bude poprvé úspěšný 
> - Právě u 5. návštěvy knihkupectví
> - Do 5. návštěvy (5. již neuvažujeme)
> - Při 8. a více náštěvě

```matlab
geopdf(4, 1/10)
geocdf(3, 1/10)
1 - geocdf(6, 1/10)
```

## Negativně binomické rozdělení
### Příklad 15a
> [!example] Pravděpodobnost výskytu krevní skupiny A+ je 0.35. V nemocnici potřebují najít 3 dárce s touto krevní skupinou. Dárcové však neznají svojí krevní skupinu. Jaká je pravděpobodnost, že pro nalezení právě 3. dárce s krevní skupinou A+ budou muset vyšetřit
> - Právě 10 dárců
> - Více jak 9 dárců
> - Alespoň 6 (včetně) a nejvýše 10 dárců (včetně)

```matlab
nbinpdf(7, 3, 0.35)
1 - nbincdf(6, 3, 0.35)
nbincdf(7, 3, 0.35) - nbincdf(2, 3, 0.35)
```

## Multinomické rozdělení
### Příklad 15b
> [!example] Máte balíček mariášových karet. 10x losujete kartu, kterou následně vracíte do balíčku. Určete pravděpodobnost, že:
> - Vylosujete 8 karet a to buď spodky, filky, krále nebo esa. 
> - Vylosujete právě 2 esa, 3 krále, 2 filky a 1 spodka. 
> - Vypočtěte příklad ad a) a ad b), jestliže karty nevracíte zpět.

```matlab
% Vracíme
binopdf(8,210,16/32)
% Ta poslední dvojka z prvního vektoru tam je, protože musíme dopočítat do 10ti tahů
mnpdf([2 3 2 1 2], [4/32 4/32 4/32 4/32 16/32])

% Nevracíme
hygepdf(8,32,16,10)
nchoosek(4,2) * nchoosek(4,3) * nchoosek(4,2) * nchoosek(4,1) * nchoosek(16,2) / nchoosek(32,10)
```

## Poissonovo rozdělení
### Příklad 16
> [!example] Na 100 metrech látky se nachází 10 kazů. Jestliže vybereme 20 metrový úsek látky, jaká je pravděpodobnost, že zde
> - není žádný kaz
> - jsou zde právě 2 kazy
> - je zde více než 5 kazů

```matlab
% 10 kazů na 100 metrů
lambda = 10 / 100
% zajímá nás 20 metrů
t = 20

% Není žádný kaz
poisspdf(0, lambda * t)
% Jsou zde právě 2 kazy
poisspdf(2, lambda * t)
% Více než 5 kazů
1 - poisscdf(5.1, lambda * t)
```

### Příklad 17
> [!example] Při sledování poruchovosti provozu se zjistilo, že za 1 rok zde bylo na 10 strojích zaznamenáno 5 poruch. Určete pravděpodobnost, že v následujících 2 letech bude na 25 strojích zaznamenáno
> - Méně než 12 poruch
> - Právě 20 poruch
> - Více než 25 poruch

```matlab
% 5 poruch na 10 strojů za 1 rok
lambda = 5 / 10 / 1
% 2 roky * 25 strojů
t = 2 * 25

poisscdf(11, lambda * t)
poisspdf(20, lambda * t)
1 - poisscdf(25, lambda * t)
```

### Příklad 18
> [!example] Průměrný telefonní hovor trvá 1,5 min. Dochází-li průměrně k 600 hovorům za hodinu, jaká je pravděpodobnost, že se bude současně konat více než 30 hovorů.

```matlab
% 600 hovorů za 60 minut
lambda = 600 / 60
t = 1.5 % interval je 1.5 minuty

% P(X > 30) => 1 - P(X <= 30)
1 - poisscdf(30, lambda * t)
```

### Příklad 19
> [!example] Průměrný telefonní hovor trvá 1,5 min. Kolik linek musí ústředna mít, dochází-li průměrně ke 240 hovorům za hodinu a pravděpodobnost ztráty volání nesmí překročit 0,01.

```matlab
% 240 hovorů za hodinu
lambda = 240 / 60
% Interval 1.5 minut na hovor
t = 1.5

% inv => inverzní cdf
poissinv(1 -  0.01, lambda * t)
```

## Aproximace binomického a hypergeometrického rozdělení na Poissonovo rozdělení
Aproximace hypergeometrického rozdělení pomocí binomického:
$$\large
\begin{aligned}
    n_{\normalsize\text{bin}} &= n_{\normalsize\text{hyp}} \\
    p_{\normalsize\text{bin}} &= \frac{M_{\normalsize\text{hyp}}}{N_{\normalsize\text{hyp}}} \\
    \frac{n_{\normalsize\text{hyp}}}{N_{\normalsize\text{hyp}}} &\lt 0.05
\end{aligned}
$$

Aproximace binomického rozdělení pomocí poissonového:
$$\large
\begin{aligned}
    \lambda_{\normalsize\text{poiss}} &= n_{\normalsize\text{bin}} \cdot p_{\normalsize\text{bin}} \\
    n_{\normalsize\text{bin}} &\gt 30 \\
    p_{\normalsize\text{bin}} &\lt 0.05
\end{aligned}
$$

### Příklad 20
> [!example] Tisíckrát se hodilo mincí. Jaká je pravděpodobnost, že mezi 480x až 520x padne orel. Proveďte výpočet pomocí:
> - Binomického rozdělení,
> - Poissonova rozdělení,
> - Proč nejsou splněny předpoklady převedení binomického rozdělení na poissonovo?

```matlab
% Rozdíl intervalů od 0 do 520 a od 0 do 479
% Ten druhý není do 480, protože cdf je včetně té hodnoty
% takže bychom 480x pokus vynechali
binocdf(520, 1000, 1/2) - binocdf(479, 1000, 1/2)

lambda = 1000 * 1/2
poisscdf(520, lambda) - poisscdf(479, lambda)
```
Předpoklady převodu binomického na poissonovo rozdělení nejsou splněny, protože

- počet pokusů \(n\) musí být větší než \(30\) (což je splněno)
- pravděpodobnost \(p\) musí být menší než \(0.05\) (__není splněno__)

### Příklad 21
> [!example] Ve sportce se táhne 6 čísel ze 49. Sázíme 6 čísel. Jaká je pravděpodobnost, že jsme uhodli právě 2 čísla.
> - Řeště pomocí hypergeometrického rozdělení
> - Řeště pomocí aproximace na binomické rozdělení
> - Řešte pomocí aproximace na Poissonovo rozdělení

```matlab
% Hledáme 2 čísla ze 49 čísel, když taháme 6 ze 6 čísel
hygepdf(2, 49, 6, 6)

% Nejsou splněny předpoklady pro dobrou aproximaci
% k = 2, n_bin = 6, p_bin = 6/49

binopdf(2, 6, 6/49)

% Nejsou splněny předpoklady pro dobrou aproximaci
% lambda = n_bin * p_bin = 6 * 6/49
poisspdf(2, 6 * 6 /49)
```

### Příklad 22
> [!example] Korektura tisíce stran textu prokázala 1500 chyb. 
> - Určete pravděpodobnost, že na náhodně vybrané stránce se nachází 4 chyby. 
> - Odhadněte, kolik stran v tisícistránskové knize bude bez chyby.

```matlab
% 1500 chyb na 1000 stran
lambda = 1500 / 1000
% Interval jedné stránky
t = 1

% Na náhodně vybrané stránce se nachází 4 chyby
poisspdf(4, lambda * t)
% Kolik stran v tisícistránskové knize bude bez chyby.
poisspdf(0, lambda * t) * 1000
```

### Příklad 23
> [!example] Bankovní úředník zjistil, že u 20 % návrhů na půjčku zákazníci zamlčí důležité informace. Určete pravděpodobnost, že mezi 100 návrhy budou 25 se zamlčenými informacemi.
> - Řešte pomocí binomického rozdělení
> - Řešte pomocí aproximace na Poissonovo rozdělení

```matlab
% Řešte pomocí binomického rozdělení
binopdf(25, 100, 0.2)

% Řešte pomocí aproximace na Poissonovo rozdělení
poisspdf(25, 100 * 0.2)
```

### Příklad 24
> [!example] Bankovní úředník zjistil, že u 50 % návrhů na půjčku zákazníci zamlčí důležité informace. Určete pravděpodobnost, že mezi 10 návrhy bude 5 se zamlčenými informacemi.
> - Řešte pomocí binomického rozdělení
> - Řešte pomocí aproximace na Poissonovo rozdělení
> - Jaké předpoklady aproximace nejsou splněny.

```matlab
binopdf(5, 10, 0.5)
poisspdf(5, 10 * 0.5)
```

Není splněn předpoklad většího množství pokusů (\(n > 30\)) a pravděpodobnosti menší než 0.05