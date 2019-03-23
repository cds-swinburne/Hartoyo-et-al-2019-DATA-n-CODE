function KLD = PlotParamHistBase(th,sel,fig,flg,param,dev,mparam)
%
%   KLD = PlotParamHistBase(th,sel,fig,flg,param,dev,mparam)
%
%   Plot the hisograms for the fitted parameters th (Nparam x Nsamples)
%   sel = slection structure
%   fig = base figure number (default 1)
%   flg = 0 for histogram plots
%   flg = 1 for kernel fit plots
%   flg = 2 for both
%   param(1) = starting points parameters
%   param(2) = mean value parameters
%   param(3) = Ground truth parameters (if supplied)
%   param(4) = ML fit to surrogate spectrum (if supplied)
%   mparam uses ptype structure
%

[N,~] = size(th);
[L1,L2,Npages] = PlotShape(N);
if nargin < 3
    fig = 1;
end
if nargin > 4
    th0 = ParamArray(param(2),sel);
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
end
KLD = zeros(1,N);
figure(fig),clf;
Np = L1*L2;
if nargin > 4
    ptype = ParamArray(mparam.ptype,sel);
end

for np = (1:Npages)
    figure(fig-1+np);clf;
    for n = (1:Np)
        k = (np-1)*Np + n;
        if k <= N
            subplot(L1,L2,n);
            if (flg == 0)||(flg ==2)
                histogram(th(k,:),100,'Normalization','pdf','FaceColor','r','EdgeColor','none');
            end
            if (flg == 1)||(flg == 2)
                [f,x] = ksdensity(th(k,:));
                hold on
                plot(x,f,'b','LineWidth',2)
                if ~isempty(gt)
                    plot(gt(k)*[1 1],[0 max(f)],'r','LineWidth',2);
                end  
                if ~isempty(sg)
                    plot(sg(k)*[1 1],[0 max(f)],'--r','LineWidth',2);
                end   
                hold off
            end
            if nargin > 4
           %     if ~strcmp(ParamNameSimple(sel,k),'eta') 
                    if ptype(k) == 0
                        y = th0(k) + linspace(-2,2,101)*sigma(k); 
                        g = exp(-0.5*((y - th0(k))/sigma(k)).^2)/(sqrt(2*pi)*sigma(k));
                        f0 = exp(-0.5*((x - th0(k))/sigma(k)).^2)/(sqrt(2*pi)*sigma(k));
                    elseif ptype(k) == 1
                        y = th0(k) + linspace(-2,2,101)*sigma(k)*sqrt(3); 
                        g = (y >= th0(k)-sigma(k)*sqrt(3)).*(y <= th0(k) + sigma(k)*sqrt(3))./(2*sigma(k)*sqrt(3));
                        f0 = (x >= th0(k)-sigma(k)*sqrt(3)).*(x <= th0(k) + sigma(k)*sqrt(3))./(2*sigma(k)*sqrt(3));
                        f = f.*(x >= th0(k)-sigma(k)*sqrt(3)).*(x <= th0(k) + sigma(k)*sqrt(3));
                    elseif ptype(k) == 2
                        y = linspace(0,2*th0(k),101);
                        g = exp(-y/th0(k))/th0(k);
                        f0 = exp(-x/th0(k))/th0(k);
                    elseif ptype(k) == 3
                        y = linspace(0,2*th0(k),101);
                        s2 = log(1 + sigma(k).^2./th0(k).^2);
                        m = log(th0(k)) - 0.5*s2;
                        g = (y > 0).*exp(-0.5*((log(y)-m)).^2./s2)./(sqrt(2*pi*s2).*y);                        
                        f0 = (x > 0).*exp(-0.5*((log(x)-m)).^2./s2)./(sqrt(2*pi*s2).*x);                    
                    end
%                 else
%                     y = linspace(0,2*th0(k),101);
%                     g = exp(-y/th0(k))/th0(k);
%                     f0 = exp(-x/th0(k))/th0(k);                                     
%                 end
                hold on;
                plot(y,g,'k','LineWidth',2);
                hold off;
                q = f.*log(f./f0);
                q(isnan(q)) = 0;
                KLD(k) = trapz(x,q);
                if KLD(k) < 0 % must be due to numerical errors - ksdensity extends too far
                    KLD(k) = 0;
                end               
                
            end
            x0 = xlim;
            y0 = ylim;                
            text(x0(1),0.9*y0(2),sprintf('KLD = %6.4f',KLD(k)));
            ylim(y0);
            xlim(x0);
            xlabel(ParamNameBase(sel,k));
            ylabel('pdf');
        else
            return;
        end
    end
end
