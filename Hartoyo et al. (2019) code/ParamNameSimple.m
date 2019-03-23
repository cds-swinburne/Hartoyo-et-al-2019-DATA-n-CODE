function s = ParamNameSimple(sel,n)
%
%   s = ParamNameSimple(sel,n)
%
%   Get the string name of the n-th parameter in the selection array sel
%   Does not use greek characters
%

k = 0;
if sel.he_rest;k = k+1;if k == n;s = 'her';return;end;end
if sel.hi_rest;k = k+1;if k == n;s = 'hir';return;end;end
if sel.Nee_beta;k = k+1;if k == n;s = 'Nee';return;end;end
if sel.Nei_beta;k = k+1;if k == n;s = 'Nei';return;end;end
if sel.Nie_beta;k = k+1;if k == n;s = 'Nie';return;end;end
if sel.Nii_beta;k = k+1;if k == n;s = 'Nii';return;end;end
if sel.Gamma_e ;k = k+1;if k == n;s = 'Ge';return;end;end
if sel.Gamma_i ;k = k+1;if k == n;s = 'Gi';return;end;end
if sel.gamma_ee;k = k+1;if k == n;s = 'gee';return;end;end
if sel.gamma_ei == 1;k = k+1;if k == n;s = 'gei';return;end;end
if sel.gamma_ie == 1;k = k+1;if k == n;s = 'gie';return;end;end
if sel.gamma_ii;k = k+1;if k == n;s = 'gii';return;end;end
if sel.Tau_e;k = k+1;if k == n;s = 'te';return;end;end
if sel.Tau_i;k = k+1;if k == n;s = 'ti';return;end;end
if sel.Se_max;k = k+1;if k == n;s = 'Se';return;end;end
if sel.Si_max;k = k+1;if k == n;s = 'Si';return;end;end
if sel.mu_e;k = k+1;if k == n;s = 'me';return;end;end
if sel.mu_i;k = k+1;if k == n;s = 'mi';return;end;end
if sel.sigma_e;k = k+1;if k == n;s = 'se';return;end;end
if sel.sigma_i;k = k+1;if k == n;s = 'si';return;end;end
if sel.he_eq;k = k+1;if k == n;s = 'heeq';return;end;end
if sel.hi_eq;k = k+1;if k == n;s = 'hieq';return;end;end
if sel.pee;k = k+1;if k == n;s = 'pee';return;end;end
if sel.pei;k = k+1;if k == n;s = 'pei';return;end;end
if sel.pie;k = k+1;if k == n;s = 'pie';return;end;end
if sel.pii;k = k+1;if k == n;s = 'pii';return;end;end
if sel.eta;k = k+1;if k == n;s = 'eta';return;end;end
s = [];

