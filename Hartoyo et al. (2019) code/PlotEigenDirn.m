function edt = PlotEigenDirn(fp,Ne,c)
%
%   edt = PlotEigenDirn(fparam,Ne,c)
%
%   Generate a table of the leading components of the Ne leading eigen directions
%   for each subject
%   and plot a synoptic chart
%
%   c (ignored) is the minimum fraction of the L1-norm of any of the leading components (default 0.2)
%

if (nargin < 3)||isempty(c)||(c > 1)
    c = 0.2;
end
if (nargin < 2)||isempty(Ne)
    Ne = 3;
end

[Np,Ns] = size(fp.le_f{1});

edt = cell(1,Ne);
p = zeros(Np+1,Ns+1);
q = p;
tl = cell(1,Np);
for n = (1:Np)
    tl{n} = ParamNameBase(fp.psel,n);
end
for ne = (1:Ne)
    edt{ne} = zeros(Np,Ns);
    [f,indx] = sort(abs(fp.le_f{ne}),'descend');
    sf = sum(f);
    g = abs(fp.le_f{ne})./repmat(sf,Np,1);
    Nc = sum(f./repmat(sf,Np,1)>=c);
    for ns = (1:Ns)
        for n = (1:Nc(ns))
            edt{ne}(indx(n,ns),ns) = n;
        end           
    end
    p(1:Np,1:Ns) = edt{ne};
    q(1:Np,1:Ns) = g;
    figure(fp.figbase+ne-1),clf;
%     subplot(2,1,1);
%     pcolor(p);colorbar();
%     subplot(2,1,2);
    pcolor(q);caxis([0 1]);colormap('hot');colorbar();
    ax = gca;
    ax.YTick = (1.5:Np+0.5);
    ax.YTickLabel = tl;
    ax.YTickLabelMode = 'manual';
    xlabel('Subject');
    ylabel('Parameter');
    title(sprintf('Eigenvector %d',ne));

end

    
    
    