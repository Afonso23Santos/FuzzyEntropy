%%   Laboratório Avançado de Processamento de Sinal e Imagem   %%

% Afonso Pourfarzaneh, 48249
% Ângelo Nunes, 48254
% Docente: Professor Alexandre Andrade
% 2020

%% Function

function FuzEn = Fuz(sinal,dim,delay,mf,centroi,ordem)
% Computes the fuzzy entropy value (scalar) of a univariate time series (row vector)
% Inputs:
%    sinal - time series in question;
%    dim - embedding dimension (controls subset size i.e. number of observations); 
%    delay - time delay (controls index distance between observations);
%    mf - membership function (1 = Gaussian, 2 = Constant-Gaussian, 3 = Exponential);
%    centroi - centroid value (constrains each different threshold through a direct relationship);
%    ordem - 3 or 4, needed for Exponential MF;
% 
% Note that this code is similar to the one developed by Azami et al., which contains more MFs. (1)
% (1) - H. Azami, P. Li, S. Arnold, J. Escudero, and A. Humeau-Heurtier, "Fuzzy Entropy Metrics for the Analysis 
%       of Biomedical  Signals: Assessment and Comparison", IEEE ACCESS, 2019.


%% Prepare input signal and build subsets
N = length(sinal); 

% normalize
sinal = zscore(sinal(:));  % converts to column vector and zscore normalizes

% reconstruction
matriz_m = hankel(1:N-dim*delay, N-dim*delay:N-delay);    % embedding dimension m
sinal_m   = sinal(matriz_m); 

matriz_a = hankel(1:N-dim*delay, N-dim*delay:N);          % m+1
sinal_a   = sinal(matriz_a);

% Subtract average to remove subset baseline
sinal_m = sinal_m - mean(sinal_m, 2)*ones(1, dim);       
sinal_a = sinal_a - mean(sinal_a, 2)*ones(1, dim+1);


%% Compute distances

% Row vectors containing all chebychev distances for each pair of subsets
dist_m = pdist(sinal_m, 'chebychev');  
dist_a = pdist(sinal_a, 'chebychev');

% Apply desired MF, and compute each threshold through the centroid 
if mf == 1  % Gaussian
    thresh_order = centroi/(sqrt(2/pi));
    cm = exp(-(dist_m./(sqrt(2)*thresh_order)).^2);  % for dimension m
    ca = exp(-(dist_a./(sqrt(2)*thresh_order)).^2);  % m+1
    
elseif mf == 2  % Constant-Gaussian
    
    thresh_order = centroi/((0.5 + (0.5/log(2))+(sqrt(pi/(4*log(2)))))/(1+(sqrt(pi/(4*log(2))))));
    cm = ones(size(dist_m));
    cm(dist_m>thresh_order) = exp(-log(2).*((dist_m(dist_m>thresh_order) - thresh_order)./thresh_order).^2);
    
    ca = ones(size(dist_a));
    ca(dist_a>thresh_order) = exp(-log(2).*((dist_a(dist_a>thresh_order) - thresh_order)./thresh_order).^2);
    
else  % Exponential
    thresh_order = zeros(1,2);
    thresh_order(2) = ordem;
    thresh_order(1) = (centroi/((gamma(2/ordem))/(gamma(1/ordem))))^ordem;
    
    cm = exp(-dist_m.^thresh_order(2) ./ thresh_order(1));
    ca = exp(-dist_a.^thresh_order(2) ./ thresh_order(1));
end




FuzEn = -log(sum(ca) / sum(cm));  % Fuzzy entropy value  
end
