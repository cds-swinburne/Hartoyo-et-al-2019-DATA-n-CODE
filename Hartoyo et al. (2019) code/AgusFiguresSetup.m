% AgusFiguresSetup.m
%
%   Run the figures program for Agus' data
%

if ~exist('S_c','var')
    BaseSetup;
end

load('82x100x24_best_paramsets.mat')
[th_a,thk_a] = ConvertAgusData(paramset,psel);
RunKLDBase_a;
subjects = [2 19  52 56 58 82];

if exist('subjects','var')
    fparam_a.subjects = subjects;
else
    %fparam.subjects = [2 26 30 56 58 61 76 82];
    fparam_a.subjects = [2 19 40 52 56 58 64 82];% Agus' selection
end
if ~exist('record_c','var')
    ReadEEGDataOz;
end

fparam_a.record_c = record_c;
fparam_a.S = S_c;
fparam_a.indx_s = indx_a;
fparam_a.indx_f = indx_f;
fparam_a.freq =  freq;
fparam_a.prm = prm;
fparam_a.psel = psel;
mparam.Ne = 8;%5;
mparam.flg = 0;
fparam_a.mparam = mparam;
fparam_a.thk = thk_a;
fparam_a.dev = dev_a;
fparam_a.le = le;
Ns = length(fparam_a.subjects);
fparam_a.figbase = 1;

% update fparam for Agus data
load('DKLHessDataWN_a.mat');
load('FisherDataWN_a.mat');
thn_a = cell(1,length(fparam_a.subjects));
for n = (1:length(fparam_a.subjects))
    thn_a{n} = th_a{fparam_a.subjects(n)};
end
fparam_a.th = thn_a;
fparam_a.thk = thk_a;
fparam_a.KLD = kld;
fparam_a.le = le_a;
fparam_a.le_f = le_a_f;

fparam_a.dz = 1e-7;
fparam_a.evnum = [1 2 3];
fparam_a.invert = [0 0 0 0 0 0;1 0 1 1 1 0;0 0 0 0 0 0];
fparam_a.pairs = [9 9 9 10 10 11;10 11 12 11 12 12];
fparam_a.norm = 0;
