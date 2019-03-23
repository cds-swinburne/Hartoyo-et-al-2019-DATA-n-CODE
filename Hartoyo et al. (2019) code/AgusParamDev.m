function [param,jac,dev] = AgusParamDev()
%
%   [param,jac,dev] = AgusParamDev()
%
%   Default parameters and jacobian
%   for Agus implementation of Liley model
%   based on Agus' allowed parameter ranges
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


param.he_rest = (-80-60)/2;
dev.he_rest = (-60 + 80)/sqrt(12);
param.hi_rest = (-80-60)/2;
dev.hi_rest = (-60 + 80)/sqrt(12);
param.Nee_beta = (2000+5000)/2;
dev.Nee_beta = (5000-2000)/sqrt(12);
param.Nei_beta = (2000+5000)/2;
dev.Nei_beta = (5000-2000)/sqrt(12);
param.Nie_beta = (100+1000)/2;
dev.Nie_beta = (1000-100)/sqrt(12);
param.Nii_beta = (100+1000)/2;
dev.Nii_beta = (1000-100)/sqrt(12);
param.Gamma_e = (0.1+2)/2;
dev.Gamma_e = (2 - 0.1)/sqrt(12);
param.Gamma_i = (0.1+2)/2;
dev.Gamma_i = (2 - 0.1)/sqrt(12);
param.gamma_e = (0.1+1)/2;
dev.gamma_e = (1 - 0.1)/sqrt(12);
param.gamma_i = (0.01+0.5)/2;
dev.gamma_i = (0.5 - 0.01)/sqrt(12);
param.Tau_e = (5 + 150)/2;
dev.Tau_e = (150-5)/sqrt(12);
param.Tau_i = (5 + 150)/2;
dev.Tau_i = (150-5)/sqrt(12);
param.Se_max = (0.05+0.5)/2;
dev.Se_max = (0.5-0.05)/sqrt(12);
param.Si_max = (0.05+0.5)/2;
dev.Si_max = (0.5-0.05)/sqrt(12);
param.mu_e = (-55-40)/2;
dev.mu_e = (-40 + 55)/sqrt(12);
param.mu_i = (-55-40)/2;
dev.mu_i = (-40 + 55)/sqrt(12);
param.sigma_e = (2+7)/2;
dev.sigma_e = (7 - 2)/sqrt(12);
param.sigma_i = (2+7)/2;
dev.sigma_i = (7 - 2)/sqrt(12);
param.he_eq = (-20+10)/2;
dev.he_eq = (10 + 20)/sqrt(12);
param.hi_eq = (-90-65)/2;
dev.hi_eq = (-65 + 90)/sqrt(12);
param.pee = (0 + 10)/2;
dev.pee = (10 - 0)/sqrt(12);
param.pei = (0 + 10)/2;
dev.pei = (10 - 0)/sqrt(12);
param.pie = 0;
dev.pie = 0;
param.pii = 0;
dev.pii = 0;
param.gamma_ee = (0.1+1)/2;
dev.gamma_ee = (1 - 0.1)/sqrt(12);
param.gamma_ei = (0.1+1)/2;
dev.gamma_ei = (1 - 0.1)/sqrt(12);
param.gamma_ie = (0.01+0.5)/2;
dev.gamma_ie = (0.5 - 0.01)/sqrt(12);
param.gamma_ii = (0.01+0.5)/2;
dev.gamma_ii = (0.5 - 0.01)/sqrt(12);
param.eta = (0+1)/2;
dev.eta = (1 - 0)/sqrt(12);
          
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

