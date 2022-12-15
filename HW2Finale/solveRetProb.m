function[money,assetQta,var,cvar]=solveRetProb(W0,Ret,WTarget,alpha,P0,Short)

%In questa function viene costruito e risolto il problema di ottimizzazione
%di portafoglio.

%Input: 

% W0 è la ricchezza totale iniziale richiesta dal vincolo di budget, uno
% scalare.

% Ret è una matrice che contiene gli scenari, che sono i return degli asset
% alla maturità; la matrice è di dimensioni nScenari x nAsset.

% WTarget è la ricchezza minima da raggiungere alla maturità, ed è uno
% scalare.

% alpha è un valore compreso fra 0 e 1, tale che il CV@R sia calcolato al
% livello 1-alpha.

% P0 è un vettore di prezzi iniziali degli asset.

% Short è un parametro che può assumere valori 0 o 1; se Short = 1, SI dà
% la possibilità di avere short selling, quindi di avere eventualmente
% anche dei portafogli con valori delle quantità di asset negativi.


%Output:

%money è il vettore delle quantità di budget spese in ogni asset, quindi sarà un vettore
%tale che la sua somma sarà uguale al budget W0

%assetQta è il vettore delle quantità di asset possedute alla
%maturità(acquistate al prezzo P0).

%var è il V@R

%cvar è il CV@R


optim = optimproblem('ObjectiveSense','min');

% x è un vettore di quantità di denaro investita negli asset
if Short == 1
    x = optimvar('x',size(Ret,2));
else if Short == 0
   x = optimvar('x',size(Ret,2),'LowerBound',0);
else disp('Error')
end
end

%variabile decisionale che rappresenterà il V@R all'ottimo
zeta = optimvar('zeta',1,1);

%variabile ausiliaria che rappresenta una loss centrata in zeta(dettagli
%maggiori nella parte teorica), e ne abbiamo una per ogni scenario;
%ricordiamo che la loss corrisponde a W0 - WTs, dove WTs è la ricchezza
%terminale per lo scenario s
z = optimvar('z',length(Ret),'LowerBound',0);

%prob = 1/Nscenarios;
prob = 1/length(Ret);

%funzione obbiettivo
optim.Objective = zeta + sum (prob * z) / alpha;

% VINCOLI 

% vincolo variabili ausiliarie almeno pari alla differenza fra loss e V@R

optim.Constraints.c1 = z >= W0 - (1 + Ret)* x - zeta;

%vincolo ricchezza minima target

optim.Constraints.c2 = (mean(Ret)+1) * x >= WTarget;

%vincolo di budget iniziale

optim.Constraints.c3 = ones(1,size(Ret,2))*x == W0;

sol=solve(optim);

var=sol.zeta;

money=sol.x;

assetQta = money./P0;

cvar= sol.zeta + sum(prob * sol.z) / alpha;

end