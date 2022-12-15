function plotCVaRHist(p, w, ret, portNum, nBin)
% This function is used to plot histogram of returns by 
% highlighting the bins with value lower than VaR in red 
% using the vertical line to indicate the CVaR level

% portfolio returns given portNum
portRet = ret*w(:,portNum); 

% Calculate VaR and CVaR of the portfolios.
VaR = estimatePortVaR(p,w(:,portNum));
CVaR = estimatePortRisk(p,w(:,portNum));

% Convert positive number to negative number
VaR = -VaR; 
CVaR = -CVaR;

% Plot main histogram
figure;
h1 = histogram(portRet,nBin);
title('Histogram of Returns');
xlabel('Returns')
ylabel('Frequency')
hold on;

% Highlight bins with lower edges < VaR level in red
edges = h1.BinEdges;
counts = h1.Values.*(edges(1:end-1) < VaR);
h2 = histogram('BinEdges',edges,'BinCounts',counts);
h2.FaceColor = 'r';

% Add CVaR line
plot([CVaR;CVaR],[0;max(h1.BinCounts)*0.80],'--r')

% Add CVaR text
text(edges(1), max(h1.BinCounts)*0.85,['CVaR = ' num2str(round(-CVaR,4))])
hold off;
end