function plotWeight(w, symbol, title1)
% This function is used to plot portfolio weights 
% for each portfolio number (scenarios)

figure;
w = round(w'*100,1);
area(w);
ylabel('Portfolio weight (%)')
xlabel('Port Number')
title(title1);
ylim([0 100]);
legend(symbol);
end