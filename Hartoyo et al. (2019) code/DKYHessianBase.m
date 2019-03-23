function d2C = DKYHessianBase(th,freq,param,dev,psel,mparam)
%
%   d2C = DKYHessianBase(th,freq,param,dev,psel,mparam)
%
%   Estimate the Hessian of the KL divergence
%   for the fitted parameters th. 
%   the Hessian is based on normalised parameters
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

% calculate the spectrum at the fitted point
f = MPDSpectrumD2(param0,freq,0);
s_q = abs(f(1,:)).^2;

% Calculate the diagonal elements of the Hessian
d2C = zeros(Np,Np);
c3 = CostFn(th);
if isempty(c3)
    d2C = [];
    return;
end
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
    d2C(n,n) = (-c1 + 16*c2 -30*c3 + 16*c4 - c5)/(12*dx^2);
end

% calculate the off-diagonal elements of the Hessian
for n = (1:Np-1) 
    thn = th;    
    for m = (n+1:Np)
        thn(n) = th(n) + dth(n);
        thn(m) = th(m) + dth(m);
        c1 = CostFn(thn);
        if isempty(c1)
            d2C = [];
        return;
        end
        thn(m) = th(m) - dth(m);
        c2 = CostFn(thn);
        if isempty(c2)
            d2C = [];
            return;
        end
        thn(n) = th(n) - dth(n);
        thn(m) = th(m) + dth(m);
        c4 = CostFn(thn);
        if isempty(c4)
            d2C = [];
            return;
        end
        thn(m) = th(m) - dth(m);
        c5 = CostFn(thn);
        if isempty(c5)
            d2C = [];
            return;
        end
       d2C(n,m) = (c1 - c2 - c4 + c5)/(4*dx^2);
       d2C(m,n) = d2C(n,m);
    end
end

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
        s_p = abs(f1(1,:)).^2;
        C = DKY_gamma(K,s_p/K,K,s_q/K);
    end
       
end


