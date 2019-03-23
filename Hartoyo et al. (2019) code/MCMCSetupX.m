% MCMCSetupX.m
%
%   Extended setup for MCMC2 using all parameters (except pie and pii)
%   as variable (also uses only gamma_e and gamma_i)
%   and normalised parameters (probably redundant)
%

global wb_handle;
wb_handle = [];
global GuiSel;
GuiSel = [];
[param,~,dev] = AgusParam();
[param_a,~,dev_a] = AgusParamDev();

% select all parameters as variable, except pie and pii
psel = RawSel(1);

mparam.K =28;
mparam.N = 100000;
mparam.Nb = 20000;
mparam.fig = -1;
mparam.ptype = 0;
mparam.eitype = 1;
mparam.norm = 1;
mparam.rho = 0;
mparam.offset = 0;

if exist('S_c','var') ~= 1
    load('EEGSpectra.mat');
end
if exist('indx_f','var') ~= 1
    load('indexes.mat');
end

