function param = UpdateParam(param,th,sel,dev)
%
%   param = UpdateParam(param,theta,sel,dev)
%
%   Convert the selected elements of the parameter structure to an array
%

if nargin < 4
    k = 0;
    if sel.he_rest;k = k+1;param.he_rest = th(k);end
    if sel.hi_rest;k = k+1;param.hi_rest = th(k);end
    if sel.Nee_beta;k = k+1;param.Nee_beta = th(k);end
    if sel.Nei_beta;k = k+1;param.Nei_beta = th(k);end
    if sel.Nie_beta;k = k+1;param.Nie_beta = th(k);end
    if sel.Nii_beta;k = k+1;param.Nii_beta = th(k);end
    if sel.Gamma_e ;k = k+1;param.Gamma_e  = th(k);end
    if sel.Gamma_i ;k = k+1;param.Gamma_i  = th(k);end
    if sel.gamma_ee;k = k+1;param.gamma_ee = th(k);end
    if sel.gamma_ei;k = k+1;param.gamma_ei = th(k);end
    if sel.gamma_ie;k = k+1;param.gamma_ie = th(k);end
    if sel.gamma_ii;k = k+1;param.gamma_ii = th(k);end
    if sel.Tau_e;k = k+1;param.Tau_e = th(k);end
    if sel.Tau_i;k = k+1;param.Tau_i = th(k);end
    if sel.Se_max;k = k+1;param.Se_max = th(k);end
    if sel.Si_max;k = k+1;param.Si_max = th(k);end
    if sel.mu_e;k = k+1;param.mu_e = th(k);end
    if sel.mu_i;k = k+1;param.mu_i = th(k);end
    if sel.sigma_e;k = k+1;param.sigma_e = th(k);end
    if sel.sigma_i;k = k+1;param.sigma_i = th(k);end
    if sel.he_eq;k = k+1;param.he_eq = th(k);end
    if sel.hi_eq;k = k+1;param.hi_eq = th(k);end
    if sel.pee;k = k+1;param.pee = th(k);end
    if sel.pei;k = k+1;param.pei = th(k);end
    if sel.pie;k = k+1;param.pie = th(k);end
    if sel.pii;k = k+1;param.pii = th(k);end
    if sel.eta;k = k+1;param.eta = th(k);end
else
    k = 0;
    if sel.he_rest;k = k+1;param.he_rest = th(k)*dev.he_rest ;end
    if sel.hi_rest;k = k+1;param.hi_rest = th(k)*dev.hi_rest ;end
    if sel.Nee_beta;k = k+1;param.Nee_beta = th(k)*dev.Nee_beta ;end
    if sel.Nei_beta;k = k+1;param.Nei_beta = th(k)*dev.Nei_beta ;end
    if sel.Nie_beta;k = k+1;param.Nie_beta = th(k)*dev.Nie_beta ;end
    if sel.Nii_beta;k = k+1;param.Nii_beta = th(k)*dev.Nii_beta ;end
    if sel.Gamma_e ;k = k+1;param.Gamma_e  = th(k)*dev.Gamma_e ;end
    if sel.Gamma_i ;k = k+1;param.Gamma_i  = th(k)*dev.Gamma_i ;end
    if sel.gamma_ee;k = k+1;param.gamma_ee = th(k)*dev.gamma_ee ;end
    if sel.gamma_ei;k = k+1;param.gamma_ei = th(k)*dev.gamma_ei ;end
    if sel.gamma_ie;k = k+1;param.gamma_ie = th(k)*dev.gamma_ie ;end
    if sel.gamma_ii;k = k+1;param.gamma_ii = th(k)*dev.gamma_ii ;end
    if sel.Tau_e;k = k+1;param.Tau_e = th(k)*dev.Tau_e ;end
    if sel.Tau_i;k = k+1;param.Tau_i = th(k)*dev.Tau_i ;end
    if sel.Se_max;k = k+1;param.Se_max = th(k)*dev.Se_max ;end
    if sel.Si_max;k = k+1;param.Si_max = th(k)*dev.Si_max ;end
    if sel.mu_e;k = k+1;param.mu_e = th(k)*dev.mu_e ;end
    if sel.mu_i;k = k+1;param.mu_i = th(k)*dev.mu_i ;end
    if sel.sigma_e;k = k+1;param.sigma_e = th(k)*dev.sigma_e ;end
    if sel.sigma_i;k = k+1;param.sigma_i = th(k)*dev.sigma_i ;end
    if sel.he_eq;k = k+1;param.he_eq = th(k)*dev.he_eq ;end
    if sel.hi_eq;k = k+1;param.hi_eq = th(k)*dev.hi_eq ;end
    if sel.pee;k = k+1;param.pee = th(k)*dev.pee; end
    if sel.pei;k = k+1;param.pei = th(k)*dev.pei; end
    if sel.pie;k = k+1;param.pie = th(k)*dev.pie; end
    if sel.pii;k = k+1;param.pii = th(k)*dev.pii; end
    if sel.eta;k = k+1;param.eta = th(k)*dev.eta; end
end