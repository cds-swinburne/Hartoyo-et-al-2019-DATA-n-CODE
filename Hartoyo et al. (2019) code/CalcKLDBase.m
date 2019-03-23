function KLD = CalcKLDBase(th,sel,param,dev,mparam)
%
%   KLD = CalcKLDBase(th,sel,param,dev,mparam)
%
%   Calculate the Kullback-Leibler divergences for the marginals 
%   based on the parameter arrays th
%   corresponding to the selection structure sel
%   compared to the prior distributions based on the param and dev arrays
%   param(1) = starting points parameters
%   param(2) = mean value parameters
%   mparam uses ptype structure
%

[N,~] = size(th);

th0 = ParamArray(param(2),sel);
sigma = ParamArray(dev,sel);
KLD = zeros(1,N);
if nargin > 4
    ptype = ParamArray(mparam.ptype,sel);
end
for k = (1:N) 
    [f,x] = ksdensity(th(k,:));
    if ptype(k) == 0         
        f0 = exp(-0.5*((x - th0(k))/sigma(k)).^2)/(sqrt(2*pi)*sigma(k));
    elseif ptype(k) == 1       
        f0 = (x >= th0(k)-sigma(k)*sqrt(3)).*(x <= th0(k) + sigma(k)*sqrt(3))./(2*sigma(k)*sqrt(3));
        f = f.*(x >= th0(k)-sigma(k)*sqrt(3)).*(x <= th0(k) + sigma(k)*sqrt(3));
    elseif ptype(k) == 2       
        f0 = exp(-x/th0(k))/th0(k);
    elseif ptype(k) == 3        
        s2 = log(1 + sigma(k).^2./th0(k).^2);
        m = log(th0(k)) - 0.5*s2;                         
        f0 = (x > 0).*exp(-0.5*((log(x)-m)).^2./s2)./(sqrt(2*pi*s2).*x);                    
    end

    q = f.*log(f./f0);
    q(isnan(q)) = 0;
    KLD(k) = trapz(x,q);
    if KLD(k) < 0 % must be due to numerical errors - ksdensity extends too far
        KLD(k) = 0;
    end
    
end
