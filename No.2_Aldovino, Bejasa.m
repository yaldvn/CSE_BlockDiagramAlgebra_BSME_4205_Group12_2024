%Clear
clear
clc
close all

%% Block Diagram Algebra
%% Number 2

G_num1 = [1];
G_den1 = [1 0 0];
G1 = tf(G_num1,G_den1);

G_num2 = [1];
G_den2 = [1 1];
G2 = tf(G_num2,G_den2);

G_num3 = [1];
G_den3 = [1 0];
G3 = tf(G_num3,G_den3);

G_num4 = [1];
G_den4 = [0 2 0];
G4 = tf(G_num4,G_den4);

H_num1 = [1];
H_den1 = [1 0];
H1 = tf(H_num1,H_den1);

H_num2 = [1];
H_den2 = [1 -1];
H2 = tf(H_num2,H_den2);

H_num3 = [1];
H_den3 = [1 -2];
H3 = tf(H_num3,H_den3);

H_num7 = [2 -2 -4 1 1 0];
H_den7 = [1];
H7 = tf(H_num7,H_den7);

%% Reduce Block Diagram (SERIES:G4H3)
G4H3_num = conv(G_num4,H_num3);
G4H3_den = conv(G_den4,H_den3);

TF_G4H3 = tf(G4H3_num,G4H3_den)

%% Reduce Block Diagram (PARALLEL:G3,G4H3)
G3G4H3_num = conv(G4H3_num, G_num3);
G3G4H3_den = conv(G4H3_den, G_den3);

G3G4H3_den_sum = [2 -4 0 1];

TF_G3G4H3_num = conv(G3G4H3_den, G_num3);
TF_G3G4H3_den = conv(G3G4H3_den_sum, G_den3);

TF_G3G4H3 = tf(TF_G3G4H3_num,TF_G3G4H3_den)

%% Reduce Block Diagram (SERIES:G2,G3G4H3)
G2G3G4H3_num = conv(TF_G3G4H3_num, G_num2);
G2G3G4H3_den = conv(TF_G3G4H3_den, G_den2);

TF_G2G3G4H3 = tf(G2G3G4H3_num,G2G3G4H3_den)

%% Reduce Block Diagram (PARALLEL:H2,G2G3G4H3)
H2G2G3G4H3_num = conv(G2G3G4H3_num, H_num2);
H2G2G3G4H3_den = conv(G2G3G4H3_den, H_den2);

H2G2G3G4H3_den_sum = [2 -4 -2 7 -4 -1 0];

TF_H2G2G3G4H3_num = conv(H2G2G3G4H3_num, H_den2);
TF_H2G2G3G4H3_den = conv(H2G2G3G4H3_den_sum, H_num2);

TF_H2G2G3G4H3 = tf(TF_H2G2G3G4H3_num,TF_H2G2G3G4H3_den)

%% Reduce Block Diagram (SERIES:G1,H2G2G3G4H3)
G1G4_num = conv(G_num1,G_num4);
G1G4_den = conv(G_den1,G_den4);
TF_g1g4 = tf(G1G4_num,G1G4_den);
G1H2G2G3G4H3_num = conv(TF_H2G2G3G4H3_num, G1G4_num);
G1H2G2G3G4H3_den = conv(TF_H2G2G3G4H3_den, G1G4_den);

TF_G1H2G2G3G4H3 = tf(G1H2G2G3G4H3_num,G1H2G2G3G4H3_den)

%% Reduce Block Diagram (PARALLEL:H1,G1H2G2G3G4H3)
H1G1H2G2G3G4H3_num = conv(G1H2G2G3G4H3_num, H_num1);
H1G1H2G2G3G4H3_den = conv(G1H2G2G3G4H3_den, H_den1);

H1G1H2G2G3G4H3_den_sum = [4 -8 -4 14 -8 -2 2 -6 4 0 0];

TF_H1G1H2G2G3G4H3_num = conv(H1G1H2G2G3G4H3_num, H_den1);
TF_H1G1H2G2G3G4H3_den = conv(H1G1H2G2G3G4H3_den_sum, H_num1);

TF_H1G1H2G2G3G4H3 = tf(TF_H1G1H2G2G3G4H3_num,TF_H1G1H2G2G3G4H3_den)

% step response
step(TF_G1H2G2G3G4H3,0:0.1:20)
figure
