% BaseSetup.m
%

MCMCSetupX;
mparam.ptype = PriorType(1); % all uniform
mparam.dx = 1e-7;
psel.gamma_ei = 0;
psel.gamma_ie = 0;
psel.eta = 0;
param.eta = 0;
param_a.eta = 0;
prm = [param param_a];
load('indexes.mat');
load('KLDataWN.mat');
load('MLDataWN.mat');
load('DKLHessDataWN.mat');
load('FisherDataWN.mat');

