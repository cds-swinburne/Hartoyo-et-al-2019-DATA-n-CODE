function MyDistPlot(f,tl)
%
%   MyDistPlot(f,tl)
%
%   Basic ks density plot of array f (Num samples x Num parameters)
%   tl is the tick label array
%   Behaves a little like MyBoxPlot but with ksdensity estimates
%

[~,Np] = size(f);


figure(gcf);%clf;
for n = (1:Np)
    [fp,y] = ksdensity(f(:,n));
    x = n - 0.5*fp/max(fp);
    plot(x,y,'r');
    if n == 1
        hold on;
    end
end
yl = ylim;
for n = (1:Np)
    plot([n n],yl,':k');
end

hold off
ax = gca;
ax.XTick = (1:Np);
ax.XTickLabel = tl;
ax.XTickLabelMode = 'manual';
xlim([0 Np+1]);
