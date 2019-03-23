function s = ParamNameBase(sel,n)
%
%   s = ParamNameBase(sel,n)
%
%   Get the string name of the n-th parameter in the selection array sel
%

k = 0;
if sel.he_rest;k = k+1;if k == n;s = 'h_e^r^e^s^t';return;end;end
if sel.hi_rest;k = k+1;if k == n;s = 'h_i^r^e^s^t';return;end;end
if sel.Nee_beta;k = k+1;if k == n;s = 'N_e_e';return;end;end
if sel.Nei_beta;k = k+1;if k == n;s = 'N_e_i';return;end;end
if sel.Nie_beta;k = k+1;if k == n;s = 'N_i_e';return;end;end
if sel.Nii_beta;k = k+1;if k == n;s = 'N_i_i';return;end;end
if sel.Gamma_e ;k = k+1;if k == n;s = '\Gamma_e';return;end;end
if sel.Gamma_i ;k = k+1;if k == n;s = '\Gamma_i';return;end;end
if sel.gamma_ee;k = k+1;if k == n;s = '\gamma_e';return;end;end
if sel.gamma_ei == 1;k = k+1;if k == n;s = '\gamma_e';return;end;end
if sel.gamma_ie == 1;k = k+1;if k == n;s = '\gamma_i';return;end;end
if sel.gamma_ii;k = k+1;if k == n;s = '\gamma_i';return;end;end
if sel.Tau_e;k = k+1;if k == n;s = '\tau_e';return;end;end
if sel.Tau_i;k = k+1;if k == n;s = '\tau_i';return;end;end
if sel.Se_max;k = k+1;if k == n;s = 'S_e^m^a^x';return;end;end
if sel.Si_max;k = k+1;if k == n;s = 'S_i^m^a^x';return;end;end
if sel.mu_e;k = k+1;if k == n;s = '\mu_e';return;end;end
if sel.mu_i;k = k+1;if k == n;s = '\mu_i';return;end;end
if sel.sigma_e;k = k+1;if k == n;s = '\sigma_e';return;end;end
if sel.sigma_i;k = k+1;if k == n;s = '\sigma_i';return;end;end
if sel.he_eq;k = k+1;if k == n;s = 'h_e^e^q';return;end;end
if sel.hi_eq;k = k+1;if k == n;s = 'h_i^e^q';return;end;end
if sel.pee;k = k+1;if k == n;s = 'p_e_e';return;end;end
if sel.pei;k = k+1;if k == n;s = 'p_e_i';return;end;end
if sel.pie;k = k+1;if k == n;s = 'p_i_e';return;end;end
if sel.pii;k = k+1;if k == n;s = 'p_i_i';return;end;end
if sel.eta;k = k+1;if k == n;s = '\eta';return;end;end
s = [];

