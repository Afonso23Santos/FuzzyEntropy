%%   Laboratório Avançado de Processamento de Sinal e Imagem   %%

% Afonso Pourfarzaneh, 48249
% Ângelo Nunes, 48254
% Docente: Professor Alexandre Andrade
% 2020
%% User Input Mode
clearvars
close all
clc

% Takes user input for each function Fuz parameter (except the sginal), default values are included. 
% Usual input intervals for each parameter: 
%      dim - [2, 3];
%      delay - [1,2,3];
%      centroi - [0.05, 0.10, 0.15, 0.20, 0.25];
%     
%% Receive inputs - dim, mf, centroi, delay

dim = input('Embedding dimension (> 1): ');
if isempty(dim)
    disp('Empty: default value (2) ')
    dim = 2;
end
if dim == 1
    disp(['Error: Embedding dimension must be bigger than 1, default value (2)'])
    dim = 2;
end

mf = input('Choose MF (1 = Gaussian, 2 = Constant-Gaussian ou 3 = Exponential): ');
if isempty(mf)
    disp('Erro: MF choice is needed')
    mf = input('Choose MF (1 = Gaussian, 2 = Constant-Gaussian ou 3 = Exponential): ');
end
if mf == 3
    ordem = input('Order for the Exponential (3 or 4): ');
    if isempty(ordem)
        disp('Empty: Default value (3)')
        ordem = 3;
    end
else 
    ordem = 0;
end

centroi = input('Choose centroid value: ');
if isempty(centroi)
    disp('Empty: Default value (0.1)')
    centroi = 0.1;
end

delay = input('Time delay: ');
if isempty(delay)
    disp('Empty: Default value (1)')
    delay = 1;
end

disp(' Function is ready to be applied to a signal. Example : y = rand(1,100); Fuz(y,dim,delay, mf,centroi,ordem)')