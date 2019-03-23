function PlotCParamHistBase(ev,th,thk,sel,fig,param,dev,nev)
%
%   PlotCParamHistBase(ev,th,thk,sel,fig,flg,param,dev,nev)
%
%   Plot the hisograms for the combinations of the fitted parameters th (Nparam x Nsamples)
%   defined by the Fisher information matrix eigenvectors ev (Nparam x Nparam)
%
%   sel = slection structure
%   fig = base figure number (default 1)
%   param(1) = starting points parameters
%   param(2) = mean value parameters
%   param(3) = Ground truth parameters (if supplied)
%   param(4) = ML fit to surrogate spectrum (if supplied)
%   nev = number of eigenvectors to plot (default = num param)

[N,Ns] = size(th);
if nargin < 8
    nev = N;
elseif nev > N
    nev = N;
end

[L1,L2,Npages] = PlotShape(nev,1);

sigma = ParamArray(dev,sel);

if length(param) > 2
    gt = ParamArray(param(3),sel);
else
    gt = [];
end
if length(param) > 3
    sg = ParamArray(param(4),sel);
else
    sg = [];
end

%   rescale the eigenvectors
ev = diag(1./sigma)*ev;

% combine and offset the parameters in th
th = ev'*(th - repmat(thk,1,Ns));

figure(fig),clf;
Np = L1*L2;

for np = (1:Npages)
    figure(fig-1+np);clf;
    for n = (1:Np)
        k = (np-1)*Np + n;
        if k <= nev
            subplot(L1,L2,n);

            [f,x] = ksdensity(th(k,:));
            xbar = trapz(x,x.*f);
            m2 = trapz(x,x.^2.*f);
            s = sqrt(m2 - xbar.^2);
            plot(x,f,'b','LineWidth',2);  
            xlim([-3 3]);
            xlabel(sprintf('Eigenvector %d',k));
            ylabel('pdf');
        else
            return;
        end
    end
end
