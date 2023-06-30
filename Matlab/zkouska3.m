%% Příklad 1
disp("Úloha 1");
disp("==================================================");

poruchy = [121, 254, 378, 541, 652, 687, 721, 798, 921, 992];
nahrazeny = 1000 - poruchy;

x = cat(2, poruchy, nahrazeny);
x(end + 1) = 1000;

cens = repelem([0 1], [10 11]);
freq = ones([1 20]);
freq(end+1) = 90;

[a, b] = wblfit(x, 0.05, cens, freq);
fprintf("a = %f\n", a(1))
fprintf("b = %f\n", a(2))
disp("");
fprintf("a = (%f, %f)\n", b(1, 1), b(2, 1))
fprintf("b = (%f, %f)\n", b(1, 2), b(2, 2))

disp("");

fprintf("Pravděpodobnost porouchání do 2000h: %f\n", wblcdf(2000, a(1), a(2)));

%% Příklad 2
disp("Úloha 2");
disp("==================================================");

x = [24,27,28,29,32,35,38,41,44,47,49,52,55,58,64,68,97,112,116,121,152,195,214,254,267,298,389];
y = [27,32,35,38,39,42,45,48,51,54,59,65,68,72,79,79,85,91,94,98,112,115,121,154,157,168,214,223,254,287,295,325,354,375];

[x_norm] = lillietest(x, "Distr","norm", "Alpha", 0.01);
[y_norm] = lillietest(y, "Distr","norm", "Alpha", 0.01);

fprintf("Je X z normálního rozdělení? Lillietest=%f\n", x_norm);
fprintf("Je Y z normálního rozdělení? Lillietest=%f\n", y_norm);

[median_p, median_hyp] = ranksum(y, x, "alpha", 0.01, "tail", "right");

fprintf("Ranksum=%f, p-value=%f\n", median_hyp, median_p);

%% Příklad 4
disp("Úloha 4");
disp("==================================================");

x1(1:58) = 1;
x2(1:77) = 2;
x3(1:56) = 3;
x4(1:38) = 4;
x5(1:21) = 5;

x = [x1, x2, x3, x4, x5];

y11(1:18) = 1;
y21(1:21) = 1;
y31(1:17) = 1;
y41(1:12) = 1;
y51(1:4) = 1;

y12(1:20) = 2;
y22(1:24) = 2;
y32(1:15) = 2;
y42(1:8) = 2;
y52(1:5) = 2;

y13(1:14) = 3;
y23(1:16) = 3;
y33(1:15) = 3;
y43(1:8) = 3;
y53(1:6) = 3;

y14(1:3) = 4;
y24(1:12) = 4;
y34(1:5) = 4;
y44(1:5) = 4;
y54(1:4) = 4;

y15(1:3) = 5;
y25(1:4) = 5;
y35(1:4) = 5;
y45(1:5) = 5;
y55(1:2) = 5;

y = [y11, y12, y13, y14, y15, y21, y22, y23, y24, y25, y31, y32, y33, y34, y35, y41, y42, y43, y44, y45, y51, y52, y53, y54, y55];
[tbl,chi2,p] = crosstab(x,y)

soucty = [58, 77, 56, 38, 21];
celkem = sum(soucty)

[h, p, stats] = chi2gof(soucty, "Expected", soucty ./ celkem)
