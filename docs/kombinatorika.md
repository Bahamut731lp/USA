# 01 - Kombinatorika

## Faktoriál, kombinační čísla

### Příklad 1
> [!EXAMPLE] **Jak a pro jaká čísla je definován faktoriál?**

Faktoriál je definován pro nezáporná celá čísla jako
$$n! = n \cdot (n - 1) \cdot (n - 2) \cdot \;...\;\cdot\;2\cdot 1$$
neboli, pokud bychom použili zápis produktu
$$n! = \prod_i^n i$$

V matlabu lze pro výpočet faktoriálu použít funkci `factorial(n)`

> [!TIP] Výpočet velkých faktoriálů
> Velké faktoriály je doporučené počítat pomocí jeho logaritum
> $$ \log(n!) \approx \frac{1}{2}\log(2\pi{n})+ n \cdot \log{n} - n\cdot \log{e}$$

> [!INFO] Rozšíření faktoriálu
> Definici faktoriálu lze rozšířit na reálná čísla pomocí gamma funkce.
> $$ z! = \Gamma(z + 1)$$

### Příklad 2
> [!EXAMPLE] Vypočtěte faktoriál čísla 20 
> a) pomocí for cyklu,
>
> b) pomocí příkazu počítající faktoriál (funkce `factorial`). 
>
> Zkuste se zamyslet a spočítat faktoriál 1000000.

```matlab
result = 1;
for index = 1:20
    result = result * index;
end
result
```

```matlab
factorial(20)
```

### Příklad 3
> [!EXAMPLE] Jak se vypočítají kombinační čísla a co musí pro ně platit. Jak se značí.

Kombinační čísla se počítají jako kombinace bez opakování a tudíž
$$ {n \choose k} = \frac{n!}{k! \cdot (n - k)!}$$

V matlabu lze použít pro výpočet funkci `nchoosek(n, k)`

### Příklad 4
> [!EXAMPLE] Vypočtěte kombinační číslo \(10 \choose 6\) pomocí faktoriálu a pomocí v matlabu implementované funkce (funkce `nchoosek`)

```matlab
% Proměnné
n = 10;
k = 6;

% Pomocí faktoriálu
faktorial = factorial(n) / (factorial(k) * factorial(n - k))

% Pomocí implementované funkce
implementovana = nchoosek(n, k)
```


> [!EXAMPLE] Zkuste obdobně spočítat kombinační číslo \(100 \choose 60\) a \(1000 \choose 600\). Zauvažujte, proč nelze vypočítat na počítači pomocí faktoriálu kombinační číslo 1000 600 a jak lze problém obejít.

Na počítači nelze výpočítat, protože faktoriály, se kterými bychom tam pracovali, jsou příliš velké. Tento problém lze obejít užitím *Stirlingova vzorce* nebo logaritmů.

$$ \log {n \choose k} = \sum_{i = 2}^n \log{i} - \sum_{i = 2}^{n - k} \log{i} - \sum_{i = 2}^k \log{i}$$

## Pravděpodobnost

### Příklad 5
> [!EXAMPLE] Co je to pravděpodobnost a jak je definována? 
> (dle středoškolské matematiky, vysokoškolské definice se naučíte později v kap. 2)

Pravděpodobnost \(P\) jevu \(A\) v nejjednoduším slova smyslu můžeme definovat jako míru očekávatelnosti jevu \(A\), neboli 
$$ P(A) = \frac{m}{n}$$

Takto definovanou pravděpodobnost nazýváme *klasickou*.

## Příklad 6
> [!EXAMPLE] Z telefonního čísla, které má devět cifer, jste poslední dvě cifry zapomněli. Víte pouze, že jsou různé. Zkoušíte je náhodně. Jaká je pravděpodobnost, že vytočené číslo je správné?

$$ 
    P(A) = \frac{1}{10} \cdot \frac{1}{9}    
$$

|kde||
| -- | -- |
|\(\frac{1}{10}\)| je počet možností na první zapomenuté cifře (\(<0, 9>\))|
|\(\frac{1}{9}\)| je počet možností na druhé zapomenuté cifře. Těch je o jednu míň, protože obě cifry jsou různé, tudíž musí být jedna použita už na té první.|

## Příklad 7
> [!EXAMPLE] Na pěti kartičkách jsou napsány číslice 1, 2, 3, 4, 5. Vyberete tři kartičky, které najednou otočíte. Vypočtěte pravděpodobnost, že číslo je sudé.

Pravděpodobnost, že je číslo sudé, je poměr počtu sudých čísel a počtu kartiček, neboli
$$ 
\begin{aligned}
    P(A) &= \frac{2}{5} \\
    P(A) &= 0.4
\end{aligned}
$$

> [!EXAMPLE] Jaká je pravděpodobnost, že z balíčku karet obsahující 32 karet vyberete buď spodka nebo filka. V balíčku jsou 4 spodci a 4 filci.

$$ 
\begin{aligned}
    P(A) &= \frac{4}{32} + \frac{4}{32} \\
    P(A) &= \frac{8}{32} \\
    P(A) &= 0.25
\end{aligned}  
$$

## Variace, permutace, kombinace

### Příklad 8
> [!EXAMPLE] Co to jsou variace a jaký je rozdíl mezi variacemi bez opakování a s opakováním. Zkuste odvodit vzorec na jejich výpočet.

Variace bez opakování jsou uspořádané k-tice různých prvků. U variací vždy záleží na pořadí losování.
$$
    V(n, k) = \frac{n!}{(n - k)!}
$$

Variace s opakováním jsou také uspořádané k-tice, jenom se jednotlivé prvky mohou opakovat.
$$
    V'(n, k) = n^k
$$

### Příklad 9
> [!EXAMPLE] V mariášovém turnaji je 10 hráčů. Kolika způsoby mohou obsadit první čtyři místa v turnaji?

Vybíráme variace bez opakování, protože záleží na pořadí závodníků a není možné, aby jeden závodník obsadil více pozic.

$$
\begin{aligned}
    V(10, 4) &= \frac{10!}{(10 - 4)!} \\
    V(10, 4) &= 5040
\end{aligned}
$$

```matlab
n = 10
k = 4

factorial(n) / factorial(n - k)
% ans = 5040
```

### Příklad 10
> [!EXAMPLE] 5x házíme šestistěnnou hrací kostkou a zaznamenáváme na papír výslednou číselnou hodnotu. Kolik existuje možností zapsaných čísel?

Vybíráme variace s opakováním, protože záleží na pořadí hozených čísel (ostatně si je píšeme na papír) a na kostce mohou padnou čísla několikrát.

$$
\begin{aligned}
    V'(6, 5) &= 6^5 \\
    V'(6, 5) &= 7776
\end{aligned}
$$

```matlab
n = 6
k = 5

n.^k
% ans = 5040
```

### Příklad 11
> [!EXAMPLE] V osudí je 10 karet s ciframi 0 až 9. Vybereme 6 cifer a položíme je na stůl. Kolik různých čísel můžeme zaznamenat? První cifra může být 0.

Vybíráme variace bez opakování, protože každá karta má vlastní unikátní číslo z intervalu \(<0, 9>\)

$$
\begin{aligned}
    V(10, 6) &= \frac{10!}{(10 - 6)!} \\
    V(10, 6) &= 5040
\end{aligned}
$$

```matlab
n = 10
k = 6

factorial(n) / factorial(n - k)
% ans = 151200
```

### Příklad 12
> [!example] Na papíru máte napsané následující cifry 1,1,1,2,2,2,2,3,3,3,3,3. Kolik dvanáctimístných čísel z nich můžete vytvořit.

Využijeme permutace s opakováním, protože máme více skupin, které využíváme, a které potřebujeme vyčerpat.

```matlab
jednicek = 3
dvojek = 4
trojek = 5
celkem = 12

factorial(celkem) / (factorial(jednicek) * factorial(dvojek) * factorial(trojek))
% ans = 27720
```

### Příklad 13
> [!example] Uveďte vzorce pro výpočet kombinací bez opakování a s opakováním. Odvoďte správnost vzorce pro kombinace bez opakování.

$$
\begin{aligned}
    C(n, k) &= \frac{n!}{k! \cdot (n - k)!} \\
    C'(n, k) &= { n + k - 1 \choose k }
\end{aligned}
$$

### Příklad 14
>[!example] V prodejně si můžete vybrat ze sedmi druhů pohlednic. Od každé pohlednice mají dostatečný počet exemplářů. Kolika způsoby lze koupit
> a) 10 pohlednic
>
> b) 5 pohlednic
>
> c) 5 různých pohlednic


Pracujeme s kombinacemi, protože nám nezáleží na pořadí koupených pohlednic.

```matlab
pocet_druhu = 7

a = nchoosek(pocet_druhu + 10 - 1, pocet_druhu)
b = nchoosek(pocet_druhu + 5 - 1, pocet_druhu) 
c = nchoosek(5, pocet_druhu) 
```

### Příklad 15
> [!example] Osm přátel si poslalo vzájemně pohlednice z prázdnin. Kolik pohlednic celkem rozeslali?

Každý z osmi přátel musel odeslat 7 pohlednic (páč předpokládáme, že neposílá pohlednici sám sobě).

```matlab
vysledek = 8 * 7
% ans = 56
```

### Příklad 16
> [!example] Na florbalovém mistrovství je 12 mužstev. Kolik se odehraje zápasů, jestliže každý hraje s každým.

Spočítáme všechny kombinace družstev, kde jestli hraje každý s každým, tak utkání hrají 2 družstva.

```matlab
pocet_muzstev = 12
pocet_drustev_v_zapase = 2

nchoosek(12, 2)
% ans = 66
```

## Kombinatorické pravidlo součinu
Kombinatorické pravidlo součinu funguje podobně jako logický součin.

### Příklad 17
> [!example] Třikrát hodíte hracími kostkami. Jaká je pravděpodobnost, že 
> a) padnou tři šestky,
>
> b) padnou všechna stejná čísla,
>
> c) padnou dvě šestky a jedno číslo jiné.

- Aby padly tři šestky, pravděpodobnost pro každý hod, že padne číslo 6, je 1/6
- Aby padly 3 stejná čísla, nezáleží, co padne jako první - ale pro další dva hody už je pravděpodobnost 1/6, protože potřebujeme, aby nám padlo přesně to jedno číslo
- Pro každou šestku je šance 1/6, a pro další *jiné* číslo je šance 5/6

```matlab
a = 1/6 * 1/6 * 1/6
b = 6/6 * 1/6 * 1/6
c = 1/6 * 1/6 * 5/6

%a = 0.0046
%b = 0.0278
%c = 0.0231
```

### Příklad 18
> [!example] Máme dva balíčky karet, v prvním jsou pouze červené (8 různých karet) a v druhém pouze žaludy (také 8 různých karet). Z prvního balíčku vyberete 5 karet, z druhého 4 karty. Kolik existuje kombinací výběru karet?

```matlab
nchoosek(8, 5) * nchoosek(8, 4)
% ans = 3920
```

### Příklad 19
> [!example] Jaká je pravděpodobnost, že v normálním balíčku mariášových karet, při výběru 4 karet budou samá esa? 
> - Vybranou kartu vracíte do balíčku.
> - Vybranou kartu necháte venku.

```matlab
% Vracíme do balíčku - šance se tudíž nemění
bez_vraceni = (4/32)^4

% Nevracíme do balíčku - 
s_vracenim = 4/32 * 3/31 * 2/30 / 1/29
```

```diff
+ bez_vraceni = 2.7809e-05
+ s_vracenim = 2.7809e-05
```

### Příklad 20
> [!example] Vyučující připravuje zadání písemné práce. Má k dispozici 10 příkladů, z nichž vybere 3. Studenti znají z loňského roku zadání 5 příkladů, které se mohu objevit v písemné práci. 
> - Zjistěte pravděpodobnost, že učitel vybere z 10 příkladů všechny ty, jejichž zadání studenti znají. 
> - Zjistěte pravděpodobnost, že studenti budou znát pouze 2 zadané příklady.


```matlab
% Vybere všechny, které znají
nchoosek(5,3) / nchoosek(10,3)
% Pomocí hypergeometrického rozdělení
hygepdf(3, 10, 5, 3)

% Studenti znají dva příklady z 5, a další 
nchoosek(5,2) * nchoosek(5, 1) / nchoosek(10,3)
% Alternativně řešeno pomocí hypergeometrického rozdělení
hygepdf(2, 10, 5, 3)
```

### Příklad 21
> [!example] Učitel má připraveno 15 příkladů z pravděpodobnosti a 5 příkladů ze statistiky. 
>- Náhodně zvolí 6 příkladů, kolik existuje možností výběrů příkladů?
>- Jaká je pravděpodobnost, že z 6 vybraných příkladů budou právě 2 ze statistiky?

```matlab
priklady_pravdepodobnost = 15;
priklady_statistika = 5;

% První bod
nchoosek(20, 6)

% Druhý bod
nchoosek(15, 4) * nchoosek(5, 2) / nchoosek(20, 6)
hygepdf(2, priklady_pravdepodobnost + priklady_statistika, 6, priklady_statistika)
```

### Příklad 22
> [!example] Dle zadání příkoladu 21 dokažte, že součet pravděpodobností přes všechny možné stavy bude roven 1

```matlab
% Z 15ti příkladů vybírám 6 => nchoosek(15,6)
% Z 5 vybírám nula => nchoosek(5, 0)
pocet = 5;
soucet = 0;

for i = 0:pocet
    soucet = soucet + (nchoosek(15,pocet - i) * nchoosek(5, i) / nchoosek(20,pocet));
end

soucet
```

### Příklad 23
> [!example] Hodí se \(n\) kostek. Určete pravděpodobnost, že na všech bude stejné číslo.

Stejně jako u předchozích příkladů, pravděpodobnost padnutí jednoho čísla na šestistěnné kostce je 1/6. Pokud má padat za sebou, musí se tyto pravděpodobnosti násobit.

Pravděpodobnost padnutí stejného čísla na \(n\) kostkách je tudíž součinem všech hodů, neboli
$$ \left(\frac{1}{6}\right)^{n-1}$$

>[!help] Proč je v exponentu \(-1\) ?
>Je to hlavně kvůli prvnímu hodu. Představme si, že hodíme první kostkou - jaká je šance, že padne... jakékoliv číslo? No 1, že jo. Nemůže se nám stát, že po hodu kostkou nám nepadne číslo (zanedbáme situace, kdy kostka spadne na roh :P).
>
>Pro první kostku je šance na padnutí čísla 100%, pak pro ty další už je 1/6, protože musí být stejné číslo, jako na té první. Kdyby tam nebyla ta \(-1\), tak na první kostce je šance padnutí čísla 1/6... a co by se jako dělo v těch dalších 5/6 případů?

## Sčítání pravděpodobností

### Příklad 23a
> [!example] V mariášovém balíčku je 32 karet (8 hodnot po 4 barvách). Vypočtěte pravděpodobnost, že vyberete spodka, nebo filka, nebo žaludovou barvu.  

```matlab
spodky = 4;
filci = 4;
zaludy = 8 - 2; % Odečítáme 2, protože žaludové filky a spodky už jsme započítali v jejich vlastních hodnotách

(spodky + filci + zaludy) / 32
```

### Příklad 24
> [!example] Mezi 100 a 1000 (čísla na kraji interval započítejte) je 143 prvočísel. Určete pravděpodobnost, že náhodně vybrané celé číslo mezi 100 a 1000 je:
> - Prvočíslo (funkce primes), nebo dělitelné dvěma, nebo dělitelné třemi
> - není prvočíslo
> - je dělitelné dvěma nebo pěti

>[!warning] Pozor na princip inkluze a exkluze
> Čísla, co jsou dělitelná 2 i 3 se objeví v pravděpodobnosti dvakrát, což nechceme. Musíme tedy tyhle zdvojená čísla odečíst.

```matlab
interval = 100:1000
pocet_v_intervalu = length(interval)
pocet_prvocisel = 143

delitelnych_2 = length(interval(mod(interval, 2) == 0))
delitelnych_3 = length(interval(mod(interval, 3) == 0))
delitelnych_5 = length(interval(mod(interval, 5) == 0))

% Pravděpodobnost, že je prvočíslo, dělitelné 2 nebo 3
% Btw je potřeba myslet na princip inkluze-exkluze. Některá čísla jsou dělitelná 2 i 3 a nechcem je započítat 2x

delitelny_obemi = length(interval(mod(interval, 3) == 0 & mod(interval, 2) == 0))
prvni_bod = (pocet_prvocisel + delitelnych_2 + delitelnych_3 - delitelny_obemi) / pocet_v_intervalu

% Není prvočíslo
druhy_bod = 1 - (pocet_prvocisel / pocet_v_intervalu)

% Je dělitelné 2 nebo 5
delitelny_obemi = length(interval(mod(interval, 5) == 0 & mod(interval, 2) == 0))
treti_bod = (delitelnych_2 + delitelnych_5 - delitelny_obemi) / pocet_v_intervalu
```

```diff
prvni_bod =

    0.8257


druhy_bod =

    0.8413


delitelny_obemi =

    91


treti_bod =

    0.6004
```

## Obecné příklady a opakování

### Příklad 25
> [!Example] Kolika způsoby je možno na šachovnici s 64 poli vložit 5 věží tak, aby se vzájemně neovlivňovaly, tj. žádná neležela ve stejném sloupci a řádku.


Šachovnice je čtvercové pole. Aby se věže neohrožovaly, musí být samostatné na řádku a sloupci. Tudíž po každém umístění odebíráme jeden řádek a sloupec.

```matlab
8^2 * 7^2 * 6^2 * 5^2 * 4^2 / factorial(5)
```

### Příklad 26
> [!example] Vytvořte Pascalův trojúhelník kombinačních čísel pro 8 prvků (funkce pascal). Zkuste z něj zjistit následující kombinační čísla \(6 \choose 1\), \(6 \choose 2\), \(6 \choose 3\), \(6 \choose 4\). Určete základní početní pravidla pro aritmetické operace s kombinačními čísly.

```matlab
pascal(6)
```

```diff
ans =

     1     1     1     1     1     1
     1     2     3     4     5     6
     1     3     6    10    15    21
     1     4    10    20    35    56
     1     5    15    35    70   126
     1     6    21    56   126   252

6, 15, 20, 15
```

### Příklad 27
> [!example] Ověřte, že součet kombinačních čísel i=0mm i , pro pět libovolných m je 2m. (Ověření platnosti binomické věty.)

> [!TODO] To se mi fakt dělat nechce.

### Příklad 28
> [!example] Máte funkci \(y=(1+x)^{28}\). Spočtěte koeficient u \(x^6\), \(x^9\) a \(x^12\).

### Příklad 29
> [!example] V atletickém oddíle je 15 chlapců a 10 dívek. Pro reprezentaci je nutné vybrat deset členů (5 chlapců a 5 dívek). Kolik možností výběru existuje?

```matlab
% Proč to není plus? Já neviem už.
% Asi protože v zadání byla spojka "a" místo "nebo".
nchoosek(15, 5) * nchoosek(10, 5)
```