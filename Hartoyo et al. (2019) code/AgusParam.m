function [param,jac,dev] = AgusParam(r)
%
%   Default parameters and experimental jacobian
%   for Agus implementation of Liley model
%   r = relative error std dev (default 0)
%
%   param.he_rest = excitatory cell mean resting potential (mV)
%   param.hi_rest = inhibitory cell mean resting potential (mV)
%   param.Nee_beta = intracortical e->e connections
%   param.Nei_beta = intracortical e->i connections
%   param.Nie_beta = intracortical i->e connections
%   param.Nii_beta = intracortical i->i connections
%   param.Gamma_e = EPSP peak (mV)
%   param.Gamma_i = IPSP peak (mV)
%   param.gamma_e = EPSP rate constant (/mS)
%   param.gamma_i = IPSP rate constant (/mS)
%   param.Tau_e = Excitatory cell time constant (ms)
%   param.Tau_i = Inhibitory cell time constant (ms)
%   param.Se_max = excitatory cell maximum firing rate (/ms)
%   param.Si_max = inhibitory cell maximum firing rate (/ms)
%   param.mu_e = excitatory cell threshold (mV)
%   param.mu_i = inhibitory cell threshold (mV)
%   param.sigma_e = excitatory cell firing standard deviation (mV)
%   param.sigma_i = inhibitory cell firing standard deviation (mV)
%   param.he_eq = excitatory cell equilibrium potential (mV)
%   param.hi_eq = inhibitory cell equilibrium potential (mV)
%   param.pee = e->e input rate (/ms)
%   param.pei = e->i input rate (/ms)
%   param.pie = e->e input rate (/ms)
%   param.pii = e->i input rate (/ms)
%   param.gamma_ee = ee rate constant (/ms)
%   param.gamma_ei = ei rate constant (/ms)
%   param.gamma_ie = ie rate constant (/ms)
%   param.gamma_ii = ii rate constant (/ms) 
%   param.eta = background spectrum power/2 
%

if (nargin < 1)||isempty(r)
    r = 0;
end

param.he_rest = -69.6952;
param.hi_rest = -74.4255;
param.Nee_beta = 2847.80;
param.Nei_beta = 4422.60;
param.Nie_beta = 744.01;
param.Nii_beta = 173.86;
param.Gamma_e = 1.9827*(1 + r*randn(1));
param.Gamma_i = 0.4169*(1 + r*randn(1));
param.gamma_e = 0.3030*(1 + r*randn(1));
param.gamma_i = 0.0486*(1 + r*randn(1));
param.Tau_e = 106.1237*(1 + r*randn(1));
param.Tau_i = 69.5959*(1 + r*randn(1));
param.Se_max = 0.2943;
param.Si_max = 0.0671;
param.mu_e = -40.0612;
param.mu_i = -52.8817;
param.sigma_e = 3.8213;
param.sigma_i = 2.4760;
param.he_eq = -2.5335;
param.hi_eq = -87.5723;
param.pee = 3.1560*(1 + r*randn(1));
param.pei = 2.6976*(1 + r*randn(1));
param.pie = 0;
param.pii = 0;
% bring into line with MPDParam2 for convenience
param.gamma_ee = param.gamma_e;
param.gamma_ei = param.gamma_e;
param.gamma_ie = param.gamma_i;
param.gamma_ii = param.gamma_i;
% add default input parameter for convenience
param.eta = 0.5;

if nargout > 1
    jac = zeros(10,10);
    jac(3,4) = 1;
    jac(5,6) = 1;
    jac(7,8) = 1;
    jac(9,10) = 1;
    jac(1,1) = -0.04344; jac(1,3) = 0.008994; jac(1,7) = -0.01114;
    jac(2,2) = -0.03536; jac(2,5) = 0.011093; jac(2,9) = -0.03172;
    jac(4,1) = 0.026998; jac(4,4) = -0.60612; jac(4,3) = -(jac(4,4)/2)^2;
    jac(6,1) = 0.043338; jac(6,6) = jac(4,4); jac(6,5) = jac(4,3);
    jac(8,2) = 0.056625; jac(8,8) = -0.09954; jac(8,7) = -(jac(8,8)/2)^2;
    jac(10,2) = 0.013495; jac(10,9) = jac(8,7); jac(10,10) = jac(8,8);
end

if nargout > 2
    dev.he_rest = 5;
    dev.hi_rest = 5;
    dev.Nee_beta = 750;
    dev.Nei_beta = 500;
    dev.Nie_beta = 50;
    dev.Nii_beta = 50;
    dev.Gamma_e = 0.2;
    dev.Gamma_i = 0.05;
    dev.gamma_ee = 0.01;
    dev.gamma_ei = 0.01;
    dev.gamma_ie = 0.005;
    dev.gamma_ii = 0.005;
    dev.Tau_e = 10;
    dev.Tau_i = 5;
    dev.Se_max = 0.03;
    dev.Si_max = 0.007;
    dev.mu_e = 4;
    dev.mu_i = 5;
    dev.sigma_e = 0.3;
    dev.sigma_i = 0.25;
    dev.he_eq = 0.3;
    dev.hi_eq = 8;
    dev.pee = 0.3;
    dev.pei = 0.3;
    dev.pie = 0;
    dev.pii = 0;
    dev.eta = 2;%1/sqrt(12);%0.1;
end


