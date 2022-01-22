%%   Laboratório Avançado de Processamento de Sinal e Imagem   %%

% Afonso Pourfarzaneh, 48249
% Ângelo Nunes, 48254
% Docente: Professor Alexandre Andrade
% 2020
%% Find optimal threshold
clearvars
close all
clc

% This code outputs a figure for each MF: each figure consists of 5 plots, for
% each of the 5 centroid values. Each plot in turn contains three vectors of 40 entropy 
% values, corresponding to each noise (white, pink and brown). This allows
% the user to observe how the algorithm performance varies with the
% centroid value, which is particularly applied to a noise distinction task. 
% Note that signal length is fixed at 1000 points.
%% Set variables

centroide = [0.05, 0.1, 0.15, 0.2, 0.25];
delay = 1;
dim = 2;

%% Generate noise and entropy matrices 

% Noise

y1 = wgn(40,1000,25);  %white noise

y2 = dsp.ColoredNoise('Color','pink','SamplesPerFrame',1000,'NumChannels',40);  % Pink noise
y2 = (y2())';

y3 = dsp.ColoredNoise('Color','brown','SamplesPerFrame',1000,'NumChannels',40); % Brown noise
y3 = (y3())';

y = {y1, y2, y3};

% Entropy values

ent1 = zeros(3,40);
ent2 = zeros(3,40);
ent3 = zeros(3,40);
ent4 = zeros(3,40);
ent5 = zeros(3,40);

ent = {ent1,ent2,ent3,ent4,ent5};

%% MF = 1 Gaussian
mf = 1;
ordem = 0;
for i = 1:5
    centroi = centroide(i);
    for k = 1:3
        sig = y{k};
        for j = 1:40
            ent{i}(k,j) = Fuz(sig(j,:),dim,delay,mf,centroi,ordem);
        end
    end
end

figure
set(gcf,'color','w');
subplot(5,1,1),plot(ent{1}(1,:)), hold on,plot(ent{1}(2,:)), plot(ent{1}(3,:));
title('MF Gaussian, Cr = 0.05'); legend('White noise', 'Pink noise', ' Brown noise');
axis([0 45 -1 4]);

subplot(5,1,2),plot(ent{2}(1,:)), hold on,plot(ent{2}(2,:)), plot(ent{2}(3,:));
title('MF Gaussian, Cr = 0.10'); 
axis([0 45 -1 4]);

subplot(5,1,3),plot(ent{3}(1,:)), hold on,plot(ent{3}(2,:)), plot(ent{3}(3,:));
title('MF Gaussian, Cr = 0.15'); 
axis([0 45 -1 4]);

subplot(5,1,4),plot(ent{4}(1,:)), hold on,plot(ent{4}(2,:)), plot(ent{4}(3,:));
title('MF Gaussian, Cr = 0.20'); 
axis([0 45 -1 4]);

subplot(5,1,5),plot(ent{5}(1,:)), hold on,plot(ent{5}(2,:)), plot(ent{5}(3,:));
title('MF Gaussian, Cr = 0.25'); 
axis([0 45 -1 4]);
%% MF = 2 Constant-Gaussian
mf = 2;
ordem = 0;
for i = 1:5
    centroi = centroide(i);
    for k = 1:3
        sig = y{k};
        for j = 1:40
            ent{i}(k,j) = Fuz(sig(j,:),dim,delay,mf,centroi,ordem);
        end
    end
end

figure
set(gcf,'color','w');
subplot(5,1,1),plot(ent{1}(1,:)), hold on,plot(ent{1}(2,:)), plot(ent{1}(3,:));
title('MF Constant-Gaussian, Cr = 0.05'); legend('White noise', 'Pink noise', ' Brown noise');
axis([0 45 -1 4]);

subplot(5,1,2),plot(ent{2}(1,:)), hold on,plot(ent{2}(2,:)), plot(ent{2}(3,:));
title('MF Constant-Gaussian, Cr = 0.10'); 
axis([0 45 -1 4]);

subplot(5,1,3),plot(ent{3}(1,:)), hold on,plot(ent{3}(2,:)), plot(ent{3}(3,:));
title('MF Constant-Gaussian, Cr = 0.15'); 
axis([0 45 -1 4]);

subplot(5,1,4),plot(ent{4}(1,:)), hold on,plot(ent{4}(2,:)), plot(ent{4}(3,:));
title('MF Constant-Gaussian, Cr = 0.20'); 
axis([0 45 -1 4]);

subplot(5,1,5),plot(ent{5}(1,:)), hold on,plot(ent{5}(2,:)), plot(ent{5}(3,:));
title('MF Constant-Gaussian, Cr = 0.25'); 
axis([0 45 -1 4]);
%% MF = 3  Exponential order 3
mf = 3;
ordem = 3;
for i = 1:5
    centroi = centroide(i);
    for k = 1:3
        sig = y{k};
        for j = 1:40
            ent{i}(k,j) = Fuz(sig(j,:),dim,delay,mf,centroi,ordem);
        end
    end
end

figure
set(gcf,'color','w');
subplot(5,1,1),plot(ent{1}(1,:)), hold on,plot(ent{1}(2,:)), plot(ent{1}(3,:));
title('MF Exponential order 3, Cr = 0.05'); legend('White noise', 'Pink noise', ' Brown noise');
axis([0 45 -1 4]);

subplot(5,1,2),plot(ent{2}(1,:)), hold on,plot(ent{2}(2,:)), plot(ent{2}(3,:));
title('MF Exponential order 3, Cr = 0.10'); 
axis([0 45 -1 4]);

subplot(5,1,3),plot(ent{3}(1,:)), hold on,plot(ent{3}(2,:)), plot(ent{3}(3,:));
title('MF Exponential order 3, Cr = 0.15'); 
axis([0 45 -1 4]);

subplot(5,1,4),plot(ent{4}(1,:)), hold on,plot(ent{4}(2,:)), plot(ent{4}(3,:));
title('MF Exponential order 3, Cr = 0.20'); 
axis([0 45 -1 4]);

subplot(5,1,5),plot(ent{5}(1,:)), hold on,plot(ent{5}(2,:)), plot(ent{5}(3,:));
title('MF Exponential order 3, Cr = 0.25'); 
axis([0 45 -1 4]);

%% MF = 3  Exponential order 4
mf = 3;
ordem = 4;
for i = 1:5
    centroi = centroide(i);
    for k = 1:3
        sig = y{k};
        for j = 1:40
            ent{i}(k,j) = Fuz(sig(j,:),dim,delay,mf,centroi,ordem);
        end
    end
end

figure
set(gcf,'color','w');
subplot(5,1,1),plot(ent{1}(1,:)), hold on,plot(ent{1}(2,:)), plot(ent{1}(3,:));
title('MF Exponential order 4, Cr = 0.05'); legend('White noise', 'Pink noise', ' Brown noise');
axis([0 45 -1 4]);

subplot(5,1,2),plot(ent{2}(1,:)), hold on,plot(ent{2}(2,:)), plot(ent{2}(3,:));
title('MF Exponential order 4, Cr = 0.10'); 
axis([0 45 -1 4]);

subplot(5,1,3),plot(ent{3}(1,:)), hold on,plot(ent{3}(2,:)), plot(ent{3}(3,:));
title('MF Exponential order 4, Cr = 0.15'); 
axis([0 45 -1 4]);

subplot(5,1,4),plot(ent{4}(1,:)), hold on,plot(ent{4}(2,:)), plot(ent{4}(3,:));
title('MF Exponential order 4, Cr = 0.20'); 
axis([0 45 -1 4]);

subplot(5,1,5),plot(ent{5}(1,:)), hold on,plot(ent{5}(2,:)), plot(ent{5}(3,:));
title('MF Exponential order 4, Cr = 0.25'); 
axis([0 45 -1 4]);



%% Optimal centroid 

% Compute distances between white noise and brown noise entropy values, for
% each centroid. The MF used is the Exponential with order 4.

dist1 = (ent{1}(1,:)-ent{1}(3,:));
dist2 = (ent{2}(1,:)-ent{2}(3,:));
dist3 = (ent{3}(1,:)-ent{3}(3,:));
dist4 = (ent{4}(1,:)-ent{4}(3,:));
dist5 = (ent{5}(1,:)-ent{5}(3,:));

% Plot distances to allow comparison between centroid values
figure
set(gcf,'color','w');
plot(dist1),hold on, plot(dist2),plot(dist3),plot(dist4),plot(dist5),title('MF Exponential, order 4: distinction for each Cr');
legend('Cr = 0.05','Cr = 0.10','Cr = 0.15','Cr = 0.20','Cr = 0.25');