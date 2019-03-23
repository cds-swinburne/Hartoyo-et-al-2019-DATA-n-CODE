function k = NumSel(sel)
%
%   k = NumSel(sel)
%
%   Calculate the number of selected parameters
%
k = 0;
if sel.he_rest;k = k+1;end
if sel.hi_rest;k = k+1;end
if sel.Nee_beta;k = k+1;end
if sel.Nei_beta;k = k+1;end
if sel.Nie_beta;k = k+1;end
if sel.Nii_beta;k = k+1;end
if sel.Gamma_e ;k = k+1;end
if sel.Gamma_i ;k = k+1;end
if sel.gamma_ee;k = k+1;end
if sel.gamma_ei;k = k+1;end
if sel.gamma_ie;k = k+1;end
if sel.gamma_ii;k = k+1;end
if sel.Tau_e;k = k+1;end
if sel.Tau_i;k = k+1;end
if sel.Se_max;k = k+1;end
if sel.Si_max;k = k+1;end
if sel.mu_e;k = k+1;end
if sel.mu_i;k = k+1;end
if sel.sigma_e;k = k+1;end
if sel.sigma_i;k = k+1;end
if sel.he_eq;k = k+1;end
if sel.hi_eq;k = k+1;end
if sel.pee;k = k+1;end
if sel.pei;k = k+1;end
if sel.pie;k = k+1;end
if sel.pii;k = k+1;end
if sel.eta;k = k+1;end















