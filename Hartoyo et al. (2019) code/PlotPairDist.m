function PlotPairDist(fp)
%
%   PlotPairDist(fp)
%
%   Plot the pairwise distributions for the parameters selected in
%   fp.pairs
%

if (~isfield(fp,'pairs'))||isempty(fp.pairs)
        return;
end
Np = size(fp.pairs,2);
npages = floor(Np/9);
dnp = mod(Np,9);
nx = 3;ny = 3;
if (npages < 1)
    switch (dnp)
        case 1; nx = 1; ny = 1;
        case 2; nx = 1; ny = 2;
        case 3; nx = 2; ny = 2;
        case 4; nx = 2; ny = 2;
        case 5; nx = 3; ny = 2;
        case 6; nx = 3; ny = 2;
    end
end
if dnp ~= 0
    npages = npages+1;
end
dev = sqrt(3)*ParamArray(fp.dev,fp.psel);
thbar = ParamArray(fp.prm(2),fp.psel);
binedges = -1 + (0:30)/15;
for s = (1:length(fp.subjects))
    ns = fp.subjects(s);
    k = 0;                        
    for n = (1:npages)
        figure(fp.figbase+(s-1)*npages+(n-1)),clf;                
        for m = (1:9)
            k = k + 1;
            if k > Np
                break;
            end
            subplot(ny,nx,m);
            if fp.norm
                % normalise the parameters
                th1 = (fp.th{s}(fp.pairs(1,k),:) - thbar(fp.pairs(1,k)))/dev(fp.pairs(1,k));
                th2 = (fp.th{s}(fp.pairs(2,k),:) - thbar(fp.pairs(2,k)))/dev(fp.pairs(2,k));
                histogram2(th1,th2,binedges,binedges,'DisplayStyle','tile','ShowEmptyBins','off');
            else
                th1 = fp.th{s}(fp.pairs(1,k),:);
                th2 = fp.th{s}(fp.pairs(2,k),:);
                histogram2(th1,th2,30,'DisplayStyle','tile','ShowEmptyBins','off');                        
            end                    
            pname1 = ParamNameBase(fp.psel,fp.pairs(1,k));
            pname2 = ParamNameBase(fp.psel,fp.pairs(2,k));
            xlabel(pname1);
            ylabel(pname2);
            if m == 1
                title(sprintf('Subject %d',fp.indx_s(ns)));
            end
        end
    end
end