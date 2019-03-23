function th = DeNormArray(thk,fsel,vsel,dev)
%
%   th = DeNormArray(thk,fsel,vsel,dev)
%
%   De-normalize the parameter array
%

k = 0;
if fsel.he_rest;k = k+1;th(k) = thk(k)*dev.he_rest;end
if fsel.hi_rest;k = k+1;th(k) = thk(k)*dev.hi_rest;end
if fsel.Nee_beta;k = k+1;th(k) = thk(k)*dev.Nee_beta;end
if fsel.Nei_beta;k = k+1;th(k) =thk(k)*dev.Nei_beta;end
if fsel.Nie_beta;k = k+1;th(k) = thk(k)*dev.Nie_beta;end
if fsel.Nii_beta;k = k+1;th(k) = thk(k)*dev.Nii_beta;end
if fsel.Gamma_e ;k = k+1;th(k) = thk(k)*dev.Gamma_e ;end
if fsel.Gamma_i ;k = k+1;th(k) = thk(k)*dev.Gamma_i ;end
if fsel.gamma_ee;k = k+1;th(k) = thk(k)*dev.gamma_ee;end
if fsel.gamma_ei;k = k+1;th(k) = thk(k)*dev.gamma_ei;end
if fsel.gamma_ie;k = k+1;th(k) = thk(k)*dev.gamma_ie;end
if fsel.gamma_ii;k = k+1;th(k) = thk(k)*dev.gamma_ii;end
if fsel.Tau_e;k = k+1;th(k) = thk(k)*dev.Tau_e;end
if fsel.Tau_i;k = k+1;th(k) = thk(k)*dev.Tau_i;end
if fsel.Se_max;k = k+1;th(k) = thk(k)*dev.Se_max;end
if fsel.Si_max;k = k+1;th(k) = thk(k)*dev.Si_max;end
if fsel.mu_e;k = k+1;th(k) = thk(k)*dev.mu_e;end
if fsel.mu_i;k = k+1;th(k) = thk(k)*dev.mu_i;end
if fsel.sigma_e;k = k+1;th(k) = thk(k)*dev.sigma_e;end
if fsel.sigma_i;k = k+1;th(k) = thk(k)*dev.sigma_i;end
if fsel.he_eq;k = k+1;th(k) = thk(k)*dev.he_eq;end
if fsel.hi_eq;k = k+1;th(k) = thk(k)*dev.hi_eq;end
if fsel.pee;k = k+1;th(k) = thk(k)*dev.pee;end
if fsel.pei;k = k+1;th(k) = thk(k)*dev.pei;end
if fsel.pie;k = k+1;th(k) = thk(k)*dev.pie;end
if fsel.pii;k = k+1;th(k) = thk(k)*dev.pii;end
if fsel.eta;k = k+1;th(k) = thk(k)*dev.eta;end

if ~isempty(vsel)
    if vsel.he_rest;k = k+1;th(k) = thk(k)*dev.he_rest;end
    if vsel.hi_rest;k = k+1;th(k) = thk(k)*dev.hi_rest;end
    if vsel.Nee_beta;k = k+1;th(k) = thk(k)*dev.Nee_beta;end
    if vsel.Nei_beta;k = k+1;th(k) =thk(k)*dev.Nei_beta;end
    if vsel.Nie_beta;k = k+1;th(k) = thk(k)*dev.Nie_beta;end
    if vsel.Nii_beta;k = k+1;th(k) = thk(k)*dev.Nii_beta;end
    if vsel.Gamma_e ;k = k+1;th(k) = thk(k)*dev.Gamma_e ;end
    if vsel.Gamma_i ;k = k+1;th(k) = thk(k)*dev.Gamma_i ;end
    if vsel.gamma_ee;k = k+1;th(k) = thk(k)*dev.gamma_ee;end
    if vsel.gamma_ei;k = k+1;th(k) = thk(k)*dev.gamma_ei;end
    if vsel.gamma_ie;k = k+1;th(k) = thk(k)*dev.gamma_ie;end
    if vsel.gamma_ii;k = k+1;th(k) = thk(k)*dev.gamma_ii;end
    if vsel.Tau_e;k = k+1;th(k) = thk(k)*dev.Tau_e;end
    if vsel.Tau_i;k = k+1;th(k) = thk(k)*dev.Tau_i;end
    if vsel.Se_max;k = k+1;th(k) = thk(k)*dev.Se_max;end
    if vsel.Si_max;k = k+1;th(k) = thk(k)*dev.Si_max;end
    if vsel.mu_e;k = k+1;th(k) = thk(k)*dev.mu_e;end
    if vsel.mu_i;k = k+1;th(k) = thk(k)*dev.mu_i;end
    if vsel.sigma_e;k = k+1;th(k) = thk(k)*dev.sigma_e;end
    if vsel.sigma_i;k = k+1;th(k) = thk(k)*dev.sigma_i;end
    if vsel.he_eq;k = k+1;th(k) = thk(k)*dev.he_eq;end
    if vsel.hi_eq;k = k+1;th(k) = thk(k)*dev.hi_eq;end
    if vsel.pee;k = k+1;th(k) = thk(k)*dev.pee;end
    if vsel.pei;k = k+1;th(k) = thk(k)*dev.pei;end
    if vsel.pie;k = k+1;th(k) = thk(k)*dev.pie;end
    if vsel.pii;k = k+1;th(k) = thk(k)*dev.pii;end
    if vsel.eta;k = k+1;th(k) = thk(k)*dev.eta;end
end


    
    













