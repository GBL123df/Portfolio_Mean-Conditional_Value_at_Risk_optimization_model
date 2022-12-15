function plotCVaRHistOpt(alpha,W0,WTmin,short, P0, ret, nBin)
% This function is used to plot histogram of returns by 
% highlighting the bins with value lower than VaR in red 
% using the vertical line to indicate the CVaR level
% VaR = zeros(portNum,1);
% CVaR = zeros(portNum,1);
% w = zeros(size(ret,2),portNum);
% for j = 1:portNum
% [~,w(:,j),VaR(j),CVaR(j)] = solveRetProb(W0,ret,WTmin(j),alpha,P0,short);
% end
[~,w,VaR,CVaR] = solveRetProb(W0,ret,WTmin,alpha,P0,short);
% portRet = ret*w(:,portNum);
portRet = ret*w;



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