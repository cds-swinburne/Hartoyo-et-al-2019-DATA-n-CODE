function [p,s] = PriorType(pt,dev)
%
%   [p,s] = PriorType(pt,dev)
%
%   Structure of prior type markers and scaled deviations
%       (pt = 0 => Gaussian prior; 1 => uniform; 2 => exponential; 3 => log-normal)
%       (dev is the deviation structure for uniform distributions)
%   p.he_rest = excitatory cell mean resting potential (mV)
%   p.hi_rest = inhibitory cell mean resting potential (mV)
%   p.Nee_beta = intracortical e->e connections
%   p.Nei_beta = intracortical e->i connections
%   p.Nie_beta = intracortical i->e connections
%   p.Nii_beta = intracortical i->i connections
%   p.Gamma_e = EPSP peak (mV)
%   p.Gamma_i = IPSP peak (mV)
%   p.Tau_e = Excitatory cell time constant (ms)
%   p.Tau_i = Inhibitory cell time constant (ms)
%   p.Se_max = excitatory cell maximum firing rate (/ms)
%   p.Si_max = inhibitory cell maximum firing rate (/ms)
%   p.mu_e = excitatory cell threshold (mV)
%   p.mu_i = inhibitory cell threshold (mV)
%   p.sigma_e = excitatory cell firing standard deviation (mV)
%   p.sigma_i = inhibitory cell firing standard deviation (mV)
%   p.he_eq = excitatory cell equilibrium potential (mV)
%   p.hi_eq = inhibitory cell equilibrium potential (mV)
%   p.pee = e->e input rate (/ms)
%   p.pei = e->i input rate (/ms)
%   p.pie = e->e input rate (/ms)
%   p.pii = e->i input rate (/ms)
%   p.gamma_ee = ee rate constant (/ms)
%   p.gamma_ei = ei rate constant (/ms)
%   p.gamma_ie = ie rate constant (/ms)
%   p.gamma_ii = ii rate constant (/ms) 
%   p.eta = background spectrum power/2 
%
%   s is the same structure but with deviations appropriately scaled 
%   for the chosen prior distributions types
%

switch(pt)
    case 0  % All Gaussian     
        p.he_rest = 0;
        p.hi_rest = 0;
        p.Nee_beta = 0;
        p.Nei_beta = 0;
        p.Nie_beta = 0;
        p.Nii_beta = 0;
        p.Gamma_e = 0;
        p.Gamma_i = 0;
        p.Tau_e = 0;
        p.Tau_i = 0;
        p.Se_max = 0;
        p.Si_max = 0;
        p.mu_e = 0;
        p.mu_i = 0;
        p.sigma_e = 0;
        p.sigma_i = 0;
        p.he_eq = 0;
        p.hi_eq = 0;
        p.pee = 0;
        p.pei = 0;
        p.pie = 0;
        p.pii = 0;
        p.gamma_ee = 0;
        p.gamma_ei = 0;
        p.gamma_ie = 0;
        p.gamma_ii = 0;
        p.eta = 0;
    case 1  % All Uniform
        p.he_rest = 1;
        p.hi_rest = 1;
        p.Nee_beta = 1;
        p.Nei_beta = 1;
        p.Nie_beta = 1;
        p.Nii_beta = 1;
        p.Gamma_e = 1;
        p.Gamma_i = 1;        
        p.Tau_e = 1;
        p.Tau_i = 1;
        p.Se_max = 1;
        p.Si_max = 1;
        p.mu_e = 1;
        p.mu_i = 1;
        p.sigma_e = 1;
        p.sigma_i = 1;
        p.he_eq = 1;
        p.hi_eq = 1;
        p.pee = 1;
        p.pei = 1;
        p.pie = 1;
        p.pii = 1;
        p.gamma_ee = 1;
        p.gamma_ei = 1;
        p.gamma_ie = 1;
        p.gamma_ii = 1;
        p.eta = 1;  
    case 2  % Mixed Gaussian and uniform
        p.he_rest = 0;
        p.hi_rest = 0;
        p.Nee_beta = 1;
        p.Nei_beta = 1;
        p.Nie_beta = 1;
        p.Nii_beta = 1;
        p.Gamma_e = 1;
        p.Gamma_i = 1;
        p.Tau_e = 1;
        p.Tau_i = 1;
        p.Se_max = 1;
        p.Si_max = 1;
        p.mu_e = 0;
        p.mu_i = 0;
        p.sigma_e = 1;
        p.sigma_i = 1;
        p.he_eq = 0;
        p.hi_eq = 0;
        p.pee = 1;
        p.pei = 1;
        p.pie = 0;
        p.pii = 0;
        p.gamma_ee = 1;
        p.gamma_ei = 1;
        p.gamma_ie = 1;
        p.gamma_ii = 1;
        p.eta = 1;
 case 3  % Mixed Gaussian and log-normal
        p.he_rest = 0;
        p.hi_rest = 0;
        p.Nee_beta = 3;
        p.Nei_beta = 3;
        p.Nie_beta = 3;
        p.Nii_beta = 3;
        p.Gamma_e = 3;
        p.Gamma_i = 3;
        p.Tau_e = 3;
        p.Tau_i = 3;
        p.Se_max = 3;
        p.Si_max = 3;
        p.mu_e = 0;
        p.mu_i = 0;
        p.sigma_e = 3;
        p.sigma_i = 3;
        p.he_eq = 0;
        p.hi_eq = 0;
        p.pee = 3;
        p.pei = 3;
        p.pie = 0;
        p.pii = 0;
        p.gamma_ee = 3;
        p.gamma_ei = 3;
        p.gamma_ie = 3;
        p.gamma_ii = 3;
        p.eta = 3;        
end
