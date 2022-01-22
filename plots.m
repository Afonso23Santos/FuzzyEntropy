%%   Laboratório Avançado de Processamento de Sinal e Imagem   %%

% Afonso Pourfarzaneh, 48249
% Ângelo Nunes, 48254
% Docente: Professor Alexandre Andrade
% 2020
%% Plots 
clearvars
close all
clc
% This code allows the user to choose one type of noise, and obtain plots
% for the entropy values for each MF, different centroid values and data
% length sizes. As such, the output is 4 figures (for each MF), each one
% having three plots, corresponding to the signal data length of 10, 100
% and 1000 points. Each plot displays 5 row vectors of 40 entropy values,
% corresponding to the 5 centroid values used. The Y-axis has the entropy
% values and the X-axis is simply their indexes. 
%% Set parameter values 

delay = 1;  % Time delay is fixed at 1
dim = 2;    % Embedding dimension is fixed at 2
centroide = [0.05, 0.1, 0.15, 0.2, 0.25]; % 5 centroid values


%% Noise generation
 
% Three matrices for entropy values across 3 data lengths
ent1 = zeros(5,40);  % each row for each centroid value and each column for the entropy values
ent2 = zeros(5,40);
ent3 = zeros(5,40);
ent = {ent1, ent2, ent3};  % Cell containing all entropy values

noise_q = input('Choose noise (1 = white, 2 = pink, 3 = brown): ');
if isempty(noise_q)
    disp('Vazio: white (default)')
    noise_q = 1;
end

if noise_q == 1  % White noise
    y10 = wgn(40,10,25);  % Matrix for 40 repetitions of white noise, each one with 10 points
    y100 = wgn(40,100,25); % 100 points
    y1000 = wgn(40,1000,25); % 1000 points, 25(dbW) is the power of the output noise 
    y = {y10, y100, y1000};
    disp('White noise chosen')
elseif noise_q == 2 % Same process for Pink noise
    pink10 = dsp.ColoredNoise('Color','pink','SamplesPerFrame',10,'NumChannels',40);
    pink100 = dsp.ColoredNoise('Color','pink','SamplesPerFrame',100,'NumChannels',40);
    pink1000 = dsp.ColoredNoise('Color','pink','SamplesPerFrame',1000,'NumChannels',40);
    y10 = (pink10())'; %retrieves the matrix of noise signals
    y100 = (pink100())';
    y1000 =(pink1000())';
    y = {y10, y100, y1000};
    disp('Pink noise chosen')
else % Brown noise
    brown10 = dsp.ColoredNoise('Color','brown','SamplesPerFrame',10,'NumChannels',40);
    brown100 = dsp.ColoredNoise('Color','brown','SamplesPerFrame',100,'NumChannels',40);
    brown1000 = dsp.ColoredNoise('Color','brown','SamplesPerFrame',1000,'NumChannels',40);
    y10 = (brown10())';
    y100 = (brown100())';
    y1000 = (brown1000())';
    y = {y10, y100, y1000};
    disp('Brown noise chosen')
end

%% MF 1 - Gaussian

mf = 1;
ordem = 0;
for i = 1:3
    sig = y{i};  % 10, 100 or 1000 points
    for k = 1:5
        centroi = centroide(k);  % 5 values of centroid considered
        for j = 1:40
            ent{i}(k,j) = Fuz(sig(j,:),dim,delay,mf,centroi,ordem); 
        end
    end
end

figure
set(gcf,'color','w');
subplot(3,1,1),plot(ent{1}(1,:)),hold on,plot(ent{1}(2,:)),plot(ent{1}(3,:)), ...
    plot(ent{1}(4,:)),plot(ent{1}(5,:)); title('MF Gaussian vs Centroid, data length = 10');
legend('Cr = 0.05', 'Cr = 0.10','Cr = 0.15', 'Cr = 0.20', 'Cr = 0.25');
subplot(3,1,2),plot(ent{2}(1,:)),hold on,plot(ent{2}(2,:)),plot(ent{2}(3,:)), ...
    plot(ent{2}(4,:)),plot(ent{2}(5,:)); title('MF Gaussian vs Centroid, data length = 100');
subplot(3,1,3),plot(ent{3}(1,:)),hold on,plot(ent{3}(2,:)),plot(ent{3}(3,:)), ...
    plot(ent{3}(4,:)),plot(ent{3}(5,:)); title('MF Gaussian vs Centroid, data length = 1000');

%% MF 2 - Constant-Gaussian (same process)

mf = 2;
ordem = 0;
for i = 1:3
    sig = y{i};
    for k = 1:5
        centroi = centroide(k);
        for j = 1:40
            ent{i}(k,j) = Fuz(sig(j,:),dim,delay,mf,centroi,ordem);
        end
    end
end
figure
set(gcf,'color','w');
subplot(3,1,1),plot(ent{1}(1,:)),hold on,plot(ent{1}(2,:)),plot(ent{1}(3,:)), ...
    plot(ent{1}(4,:)),plot(ent{1}(5,:)); title('MF Constant-Gaussian vs Centroid, data length = 10');
legend('Cr = 0.05', 'Cr = 0.10','Cr = 0.15', 'Cr = 0.20', 'Cr = 0.25');
subplot(3,1,2),plot(ent{2}(1,:)),hold on,plot(ent{2}(2,:)),plot(ent{2}(3,:)), ...
    plot(ent{2}(4,:)),plot(ent{2}(5,:)); title('MF Constant-Gaussian vs Centroid, data length = 100');

subplot(3,1,3),plot(ent{3}(1,:)),hold on,plot(ent{3}(2,:)),plot(ent{3}(3,:)), ...
    plot(ent{3}(4,:)),plot(ent{3}(5,:)); title('MF Constant-Gaussian vs Centroid, data length = 1000');

%% MF 3 - Exponential with order 3

mf = 3;
ordem = 3;
for i = 1:3
    sig = y{i};
    for k = 1:5
        centroi = centroide(k);
        for j = 1:40
            ent{i}(k,j) = Fuz(sig(j,:),dim,delay,mf,centroi,ordem);
        end
    end
end
figure
set(gcf,'color','w');
subplot(3,1,1),plot(ent{1}(1,:)),hold on,plot(ent{1}(2,:)),plot(ent{1}(3,:)), ...
    plot(ent{1}(4,:)),plot(ent{1}(5,:)); title('MF Exponential order 3 vs Centroid, data length = 10');
legend('Cr = 0.05', 'Cr = 0.10','Cr = 0.15', 'Cr = 0.20', 'Cr = 0.25');
subplot(3,1,2),plot(ent{2}(1,:)),hold on,plot(ent{2}(2,:)),plot(ent{2}(3,:)), ...
    plot(ent{2}(4,:)),plot(ent{2}(5,:)); title('MF Exponential order 3 vs Centroid, data length = 100');

subplot(3,1,3),plot(ent{3}(1,:)),hold on,plot(ent{3}(2,:)),plot(ent{3}(3,:)), ...
    plot(ent{3}(4,:)),plot(ent{3}(5,:)); title('MF Exponential order 3 vs Centroid, data length = 1000');

%% MF 3 - Exponential with order 4

mf = 3;
ordem = 4;
for i = 1:3
    sig = y{i};
    for k = 1:5
        centroi = centroide(k);
        for j = 1:40
            ent{i}(k,j) = Fuz(sig(j,:),dim,delay,mf,centroi,ordem);
        end
    end
end

figure
set(gcf,'color','w');
subplot(3,1,1),plot(ent{1}(1,:)),hold on,plot(ent{1}(2,:)),plot(ent{1}(3,:)), ...
    plot(ent{1}(4,:)),plot(ent{1}(5,:)); title('MF Exponential order 4 vs Centroid, data length = 10');
legend('Cr = 0.05', 'Cr = 0.10','Cr = 0.15', 'Cr = 0.20', 'Cr = 0.25');
subplot(3,1,2),plot(ent{2}(1,:)),hold on,plot(ent{2}(2,:)),plot(ent{2}(3,:)), ...
    plot(ent{2}(4,:)),plot(ent{2}(5,:)); title('MF Exponential order 4 vs Centroid, data length = 100');

subplot(3,1,3),plot(ent{3}(1,:)),hold on,plot(ent{3}(2,:)),plot(ent{3}(3,:)), ...
    plot(ent{3}(4,:)),plot(ent{3}(5,:)); title('MF Exponential order 4 vs Centroid, data length = 1000');
