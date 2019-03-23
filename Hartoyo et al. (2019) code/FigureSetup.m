% FigureSetup.m
%
%   Setup default figure parameter array
%

if ~exist('S_c','var')
    BaseSetup;
end
% if (~exist('fparam','var'))||(~isfield(fparam,'record_c'))||isempty(fparam.record_c)
%     ReadEEGDataOz;
%     fparam.record_c = record_c;
%     clear record_c;
% end
subjects = [2 19  52 56 58 82];
if exist('subjects','var')
    fparam.subjects = subjects;
else
    %fparam.subjects = [2 26 30 56 58 61 76 82];
    fparam.subjects = [2 19 40 52 56 58 64 82];% Agus' selection
end


fparam.S = S_c;
fparam.indx_s = indx_a;
fparam.indx_f = indx_f;
fparam.freq =  freq;
fparam.prm = prm;
fparam.psel = psel;
mparam.Ne = 8;
mparam.flg = 0;
fparam.mparam = mparam;
fparam.thk = thk;
fparam.dev = dev_a;
fparam.KLD = kld;
fparam.le = le;
fparam.le_f = le_f;
Ns = length(fparam.subjects);
thn = cell(1,Ns);
for n = (1:length(fparam.subjects))
    flnm = sprintf('ThetaFileBaseWN%d.mat',fparam.subjects(n));
    load(flnm);
    thn{n} = th;
end
fparam.th = thn;
clear thn;
fparam.figbase = 1;

fparam.dz = 1e-7;
fparam.evnum = [1 2 3];
fparam.invert = [0 0 0 0 0 0;1 0 0 0 1 1;0 0 0 0 0 1];
fparam.pairs = [9 9 9 10 10 11;10 11 12 11 12 12];
fparam.norm = 0;

% Clean up redundant variables
clear d2C d2C_f datafiles freq GuiSel Hd hdr indx_sr kld la la_f le le_f M M1 M2 mparam n r_c refine S_c S_o skp th thk;
