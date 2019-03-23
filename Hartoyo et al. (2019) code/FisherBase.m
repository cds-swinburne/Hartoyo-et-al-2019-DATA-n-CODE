function d2C = FisherBase(th,freq,param,dev,psel,mparam)
%
%   d2C = FisherBase(th,freq,param,dev,psel,mparam)
%
%   Estimate the Fisher Information matrix (metric)
%   for the fitted parameters th. 
%   based on normalised parameters and gamma distribution
%
%   freq = frequency at sample points,
%   param,dev,psel and mparam as in LHOptim2Figures
%

if (nargin < 6)||isempty(mparam)
    K = 28;
    dx = 1e-7;
else
    K = mparam.K;
    if isfield(mparam,'dx')
        dx = mparam.dx;
    else
        dx = 1e-7;
    end
end

if mparam.eitype == 1
    psel.gamma_ei = 0;
    psel.gamma_ie = 0;
    param.gamma_ei = param.gamma_ee;
    param.gamma_ie = param.gamma_ii;
end

sigma = ParamArray(dev,psel);
dth = abs(dx*sigma); % to use normalised parameters
%dth = abs(dx*ones(size(sigma))); % to use un-normalised parameters
Np = length(th);
param0 = UpdateParam(param,th,psel);
if mparam.eitype == 1   
    param0.gamma_ei = param0.gamma_ee;
    param0.gamma_ie = param0.gamma_ii;
end

% Calculate the gradient at sampled frequencies
Nf = length(freq);
dC = zeros(Nf,Np);
for n = (1:Np)
    thn = th;
    thn(n) = th(n) + 2*dth(n);
    c1 = CostFn(thn);
    if isempty(c1)
        d2C = [];
        return;
    end
    thn(n) = th(n) + dth(n);
    c2 = CostFn(thn);
    if isempty(c2)
        d2C = [];
        return;
    end
    thn(n) = th(n) - dth(n);
    c4 = CostFn(thn);
    if isempty(c4)
        d2C = [];
        return;
    end
    thn(n) = th(n) - 2*dth(n);
    c5 = CostFn(thn);
    if isempty(c5)
        d2C = [];
        return;
    end
    dC(:,n) = (-c1 + 8*c2 - 8*c4 + c5)/(12*dx);
end

% calculate the Fisher information matrix
d2C = zeros(Np,Np);
for n = (1:Np)
    for m = (n:Np)
        d2C(n,m) = sum(dC(:,n).*dC(:,m));
        d2C(m,n) = d2C(n,m);
    end
end
d2C = K*d2C;

    function C = CostFn(th1)
        param1 = UpdateParam(param0,th1,psel);
        if mparam.eitype == 1   
            param1.gamma_ei = param1.gamma_ee;
            param1.gamma_ie = param1.gamma_ii;
        end
        f1 = MPDSpectrumD2(param1,freq,0);
        if isempty(f1)
            C = [];
            return
        end
        C = log(abs(f1(1,:)).^2);        
    end
       
end


