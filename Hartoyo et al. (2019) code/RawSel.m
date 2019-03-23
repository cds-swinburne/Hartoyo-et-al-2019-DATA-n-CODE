function sel = RawSel(c)
%
%   sel = RawSel(c)
%
%   Generate an empty selection structure
%   c == 0 -> all zero (default)
%   c == 1 -> all ones (except pie and pii which are zero) 
%   c == 2 -> standard variable selection
%   c == 3 -> identify positive variables
%

if (nargin < 1)
    c = 0;
end
if ((c == 0)||(c == 1))    
    sel.he_rest = c;
    sel.hi_rest = c;
    sel.Nee_beta = c;
    sel.Nei_beta = c;
    sel.Nie_beta = c;
    sel.Nii_beta = c;
    sel.Gamma_e = c;
    sel.Gamma_i = c;
    sel.gamma_ee = c;
    sel.gamma_ei = c;
    sel.gamma_ie = c;
    sel.gamma_ii = c;
    sel.Tau_e = c;
    sel.Tau_i = c;
    sel.Se_max = c;
    sel.Si_max = c;
    sel.mu_e = c;
    sel.mu_i = c;
    sel.sigma_e = c;
    sel.sigma_i = c;
    sel.he_eq = c;
    sel.hi_eq = c;
    sel.pee = c;
    sel.pei = c;
    sel.pie = 0;
    sel.pii = 0;
    sel.eta = c;
    return;
elseif c == 3
    sel.he_rest = 0;
    sel.hi_rest = 0;
    sel.Nee_beta = 1;
    sel.Nei_beta = 1;
    sel.Nie_beta = 1;
    sel.Nii_beta = 1;
    sel.Gamma_e = 1;
    sel.Gamma_i = 1;
    sel.gamma_ee = 1;
    sel.gamma_ei = 1;
    sel.gamma_ie = 1;
    sel.gamma_ii = 1;
    sel.Tau_e = 1;
    sel.Tau_i = 1;
    sel.Se_max = 1;
    sel.Si_max = 1;
    sel.mu_e = 0;
    sel.mu_i = 0;
    sel.sigma_e = 1;
    sel.sigma_i = 1;
    sel.he_eq = 0;
    sel.hi_eq = 0;
    sel.pee = 1;
    sel.pei = 1;
    sel.pie = 0;
    sel.pii = 0;
    sel.eta = 1;
    return;
else %if c == 2
    sel.he_rest = 0;
    sel.hi_rest = 0;
    sel.Nee_beta = 0;
    sel.Nei_beta = 0;
    sel.Nie_beta = 0;
    sel.Nii_beta = 0;
    sel.Gamma_e = 1;
    sel.Gamma_i = 1;
    sel.gamma_ee = 1;
    sel.gamma_ei = 1;
    sel.gamma_ie = 1;
    sel.gamma_ii = 1;
    sel.Tau_e = 1;
    sel.Tau_i = 1;
    sel.Se_max = 0;
    sel.Si_max = 0;
    sel.mu_e = 0;
    sel.mu_i = 0;
    sel.sigma_e = 0;
    sel.sigma_i = 0;
    sel.he_eq = 0;
    sel.hi_eq = 0;
    sel.pee = 1;
    sel.pei = 1;
    sel.pie = 0;
    sel.pii = 0;
    sel.eta = 1;
    return;
end
    
