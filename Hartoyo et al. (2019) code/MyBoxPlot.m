function MyBoxPlot(f,tl)
%
%   MyBoxPlot(f,tl)
%
%   Basic box plot of array f (Num samples x Num parameters)
%   tl is the tick label array
%   Behaves a little like BoxPlot but handles formatted labels
%

[~,Np] = size(f);
q = quantile(f,[0.05 0.25 0.5 0.75 0.95]);
m = mean(f);

% determine box size etc
w = 0.25;
x1 = (1:Np) - w;
x2 = (1:Np) + w;
y1 = q(2,:);
ym = q(3,:);
y2 = q(4,:);
yU = q(5,:);
yL = q(1,:);

figure(gcf);clf;
for n = (1:Np)
    plot([x1(n) x2(n) x2(n) x1(n) x1(n)],[y1(n) y1(n) y2(n) y2(n) y1(n)],'b',...
         [x1(n) x2(n)],[ym(n) ym(n)],'r',...
         [n n],[yL(n) y1(n)],'k',...
         [n n],[y2(n) yU(n)],'k',...
         n+[-w w]/2,[yL(n) yL(n)],'k',...
         n+[-w w]/2,[yU(n) yU(n)],'k',...
         n,m(n),'ob');
     if n == 1
         hold on;
     end
end
hold off
ax = gca;
ax.XTick = (1:Np);
ax.XTickLabel = tl;
ax.XTickLabelMode = 'manual';

