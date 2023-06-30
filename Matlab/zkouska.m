clc
clear

%% Příklad 1
randoms = zeros(100, 1);

for index = 1:100
    % V zadání je, že čísla mají rozptyl stejný jako střední hodnotu
    % Matlab ale chce směrodatné odchylky
    randoms(index) = normrnd(index, sqrt(index));
end

% výsledná střední hodnota je dána součtem nezávislých středních hodnot náhodných veličin
vyberova_stredni_hodnota = sum(1:100)
% výsledný rozptyl je dán součtem rozptylů nezávislých náhodných veličin
vyberovy_rozptyl = sum(1:100)

% Asi to vede na centrální limitní větu?
fprintf('Se směrodatnou odchylkou: %f\n', normcdf(5000, vyberova_stredni_hodnota, sqrt(vyberovy_rozptyl)))

randoms_2 = zeros(100, 1);
for index = 1:100
    % V zadání je, že čísla mají rozptyl stejný jako střední hodnotu
    % Matlab ale chce směrodatné odchylky
    randoms_2(index) = normrnd(index, index);
end

fprintf('S rozptylem: %f\n', normcdf(5000, vyberova_stredni_hodnota, vyberovy_rozptyl  ))

%% Příklad 2
pravdepodobnost_2a = 1;
for index = 0:7
    pravdepodobnost_2a = pravdepodobnost_2a * (4 / (32 - index));
end

pravdepodobnost_2a

pravdepodobnost_2b = 1;
for index = 0:7
    pravdepodobnost_2b = pravdepodobnost_2b * (8 / (64 - index));
end

pravdepodobnost_2b

%TODO: Tohle nějakým způsobem nemá jít k nule, ale k nějakým 5.6% cca
pravdepodobnost_2c = 1;
for multiplier = 1:50
    for index = 0:7
        pravdepodobnost_2c = pravdepodobnost_2c * ((4*multiplier) / ((32 - index)*multiplier));
    end

    pravdepodobnost_2c
end

%% Příklad 3
Vek6=[38,41,52,46,54,51,45,41,42,44,46,47,48,46,45,41,42,43,44,41,52,51,54,57,52,49,46,45];
Vek7=[42,45,47,49,51,42,43,43,38,39,42,45,52,57,58];
Vek8=[51,54,28,52,54,48,45,46,46,42,43,45,47,48,51,52,54,21,52,46,45];
Vek9=[57,54,52,45,41,48,44,45,39,42,46,41,43,42,45,47,54,52];

alpha = 0.05

[h6, p6] = lillietest(Vek6, Alpha=alpha, Distr="norm")
[h7, p7] = lillietest(Vek7, Alpha=alpha, Distr="norm")
[h8, p8] = lillietest(Vek8, Alpha=alpha, Distr="norm")
[h9, p9] = lillietest(Vek9, Alpha=alpha, Distr="norm")

Skupina6(1:length(Vek6)) = 1;
Skupina7(1:length(Vek7)) = 2;
Skupina8(1:length(Vek8)) = 3;
Skupina9(1:length(Vek9)) = 4;

data = [Vek6, Vek7, Vek8, Vek9]';
skupina = [Skupina6, Skupina7, Skupina8, Skupina9]';

% a - Nalezení odlehlých bodů pomocí z-souřadnice

vyberova_odchylka = sqrt(var(data));
vyberovy_prumer = mean(data);

disp("Odlehlé hodnoty:")
for index = 1:length(data)
    if (abs((data(index) - vyberovy_prumer) / vyberova_odchylka) > 3)
        disp(data(index))
    end
end
disp("====================")

% b

[p] = vartestn(data, skupina, "Display","off", "TestType","LeveneAbsolute")
[p] = kruskalwallis(data, skupina, "off")

%% Příklad 4



%% Příklad 5
X = 1:10';
Y=[6,22, 70, 240, 810, 2700, 8900, 29000, 98000, 330000]';
modelfun = @(b,x)b(1)*exp(b(2)*x);
fitnlm(X, Y, modelfun, [0,0])


modelfun = @(b,x)b(1)*exp(b(2)*x+b(3));
fitnlm(X, Y, modelfun, [0,0,0])