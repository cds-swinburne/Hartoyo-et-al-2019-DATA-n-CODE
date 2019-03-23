function th = ParamArray(param,sel,dev)
%
%   th = ParamArray(param,sel,dev)
%
%   Convert the selected elements of the parameter structure to an array
%
if nargin < 3
    k = 0;
    if sel.he_rest;k = k+1;th(k) = param.he_rest;end
    if sel.hi_rest;k = k+1;th(k) = param.hi_rest;end
    if sel.Nee_beta;k = k+1;th(k) = param.Nee_beta;end
    if sel.Nei_beta;k = k+1;th(k) = param.Nei_beta;end
    if sel.Nie_beta;k = k+1;th(k) = param.Nie_beta;end
    if sel.Nii_beta;k = k+1;th(k) = param.Nii_beta;end
    if sel.Gamma_e ;k = k+1;th(k) = param.Gamma_e ;end
    if sel.Gamma_i ;k = k+1;th(k) = param.Gamma_i ;end
    if sel.gamma_ee;k = k+1;th(k) = param.gamma_ee;end
    if sel.gamma_ei;k = k+1;th(k) = param.gamma_ei;end
    if sel.gamma_ie;k = k+1;th(k) = param.gamma_ie;end
    if sel.gamma_ii;k = k+1;th(k) = param.gamma_ii;end
    if sel.Tau_e;k = k+1;th(k) = param.Tau_e;end
    if sel.Tau_i;k = k+1;th(k) = param.Tau_i;end
    if sel.Se_max;k = k+1;th(k) = param.Se_max;end
    if sel.Si_max;k = k+1;th(k) = param.Si_max;end
    if sel.mu_e;k = k+1;th(k) = param.mu_e;end
    if sel.mu_i;k = k+1;th(k) = param.mu_i;end
    if sel.sigma_e;k = k+1;th(k) = param.sigma_e;end
    if sel.sigma_i;k = k+1;th(k) = param.sigma_i;end
    if sel.he_eq;k = k+1;th(k) = param.he_eq;end
    if sel.hi_eq;k = k+1;th(k) = param.hi_eq;end
    if sel.pee;k = k+1;th(k) = param.pee;end
    if sel.pei;k = k+1;th(k) = param.pei;end
    if sel.pie;k = k+1;th(k) = param.pie;end
    if sel.pii;k = k+1;th(k) = param.pii;end
    if sel.eta;k = k+1;th(k) = param.eta;end
else
    k = 0;
    if sel.he_rest;k = k+1;th(k) = param.he_rest/dev.he_rest;end
    if sel.hi_rest;k = k+1;th(k) = param.hi_rest/dev.hi_rest;end
    if sel.Nee_beta;k = k+1;th(k) = param.Nee_beta/dev.Nee_beta;end
    if sel.Nei_beta;k = k+1;th(k) = param.Nei_beta/dev.Nei_beta;end
    if sel.Nie_beta;k = k+1;th(k) = param.Nie_beta/dev.Nie_beta;end
    if sel.Nii_beta;k = k+1;th(k) = param.Nii_beta/dev.Nii_beta;end
    if sel.Gamma_e ;k = k+1;th(k) = param.Gamma_e/dev.Gamma_e ;end
    if sel.Gamma_i ;k = k+1;th(k) = param.Gamma_i/dev.Gamma_i ;end
    if sel.gamma_ee;k = k+1;th(k) = param.gamma_ee/dev.gamma_ee;end
    if sel.gamma_ei;k = k+1;th(k) = param.gamma_ei/dev.gamma_ei;end
    if sel.gamma_ie;k = k+1;th(k) = param.gamma_ie/dev.gamma_ie;end
    if sel.gamma_ii;k = k+1;th(k) = param.gamma_ii/dev.gamma_ii;end
    if sel.Tau_e;k = k+1;th(k) = param.Tau_e/dev.Tau_e;end
    if sel.Tau_i;k = k+1;th(k) = param.Tau_i/dev.Tau_i;end
    if sel.Se_max;k = k+1;th(k) = param.Se_max/dev.Se_max;end
    if sel.Si_max;k = k+1;th(k) = param.Si_max/dev.Si_max;end
    if sel.mu_e;k = k+1;th(k) = param.mu_e/dev.mu_e;end
    if sel.mu_i;k = k+1;th(k) = param.mu_i/dev.mu_i;end
    if sel.sigma_e;k = k+1;th(k) = param.sigma_e/dev.sigma_e;end
    if sel.sigma_i;k = k+1;th(k) = param.sigma_i/dev.sigma_i;end
    if sel.he_eq;k = k+1;th(k) = param.he_eq/dev.he_eq;end
    if sel.hi_eq;k = k+1;th(k) = param.hi_eq/dev.hi_eq;end
    if sel.pee;k = k+1;th(k) = param.pee/dev.pee;end
    if sel.pei;k = k+1;th(k) = param.pei/dev.pei;end
    if sel.pie;k = k+1;th(k) = param.pie/dev.pie;end
    if sel.pii;k = k+1;th(k) = param.pii/dev.pii;end
    if sel.eta;k = k+1;th(k) = param.eta/dev.eta;end
end


    
    













