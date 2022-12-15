function cvaresatto = cvarnormal (W0,mu,sigma,x,alpha,ret,P0)

%Questa function calcola il CV@R teorico nel caso in cui la distribuzione
%degli scenari dei return sia una normale multivariata, con 3 metodi
%diversi.

%Input:

% W0 è la ricchezza totale iniziale richiesta dal vincolo di budget, uno
% scalare.

% mu vettore media della Normale multivariata.

% sigma matrice di Varianza-Covarianza.

% x è un vettore che assume diversi significati a seconda del valore di
% ret. In ogni caso, esso ci può ricondurre ai pesi di portafoglio.

% alpha è un valore compreso fra 0 e 1, tale che il CV@R sia calcolato al
% livello 1-alpha.

%ret può assumere 3 valori:
%ret=1 allora ci basiamo sui return e i pesi sono quantità di asset
%ret=2 ci basiamo sui return e i pesi sono quantità di denaro investite in
%ogni asset
%ret = 0 ci basiamo sui prezzi degli asset e i pesi sono quantità di asset

%P0 vettore di prezzi iniziali degli asset.
if ret == 1 
    mu_l=W0 -(P0.*(1+mu))*x;
    sigma_l=sqrt((P0'.*x)'*sigma*(P0'.*x));
else if ret == 2
      mu_l=W0 - (1+mu)*x;
      sigma_l=sqrt(x'*sigma*x);
else disp('ERRORE')
end
end



cvaresatto= mu_l+(sigma_l/alpha)*normpdf(norminv(alpha));


end