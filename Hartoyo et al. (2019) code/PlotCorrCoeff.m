function pairs = PlotCorrCoeff(fp,Nd)
%
%   pairs = PlotCorrCoeff(fp,Nd)
%
%   Plot the correlation coefficients for the 22 parameters
%   for the selected set of subjects
%
%   Nd = number of leading correlations to report
%

subjs = fp.subjects;
if ((nargin < 2)||isempty(Nd))||(nargout < 1)
    Nd = 0;
end

Np = size(fp.thk,1);
p = zeros(Np+1,Np+1);
tl = cell(1,Np);
for n = (1:Np)
    tl{n} = ParamNameBase(fp.psel,n);
end
if Nd > 1
    pairs = cell(1,length(subjs));    
    Nq = Np*(Np-1)/2;
    ts = zeros(Nq,1);
    row = ts;
    col = ts;
end
for n = (1:length(subjs))
    figure(fp.figbase+n-1),clf;
    ths = fp.th{n}';
    rho = corr(ths);
    if Nd > 0
        pairs{n} = zeros(2,Nd);
        k = 1;
        for c = (2:Np)
            ts(k:(k+c-2)) = abs(rho(c,1:(c-1)));
            row(k:(k+c-2)) = (1:(c-1));
            col(k:(k+c-2)) = c;
            k = k + c - 1;
        end
        [~,indx] = sort(ts,'descend');
        for m = (1:Nd)
            q = indx(m);
            pairs{n}(:,m) = [row(q);col(q)];
        end
    end
    p(1:22,1:22) = rho;
    pcolor(abs(p)),colormap('hot'),colorbar('FontSize',10);
    ax = gca;
    ax.FontSize = 7;
    ax.XTick = (1.5:Np+0.5);
    ax.XTickLabel = tl;
    ax.XTickLabelMode = 'manual';
    ax.YTick = (1.5:Np+0.5);
    ax.YTickLabel = tl;
    ax.YTickLabelMode = 'manual';
    title(sprintf('Subject %d',fp.indx_s(subjs(n))),'FontSize',10); 
end
