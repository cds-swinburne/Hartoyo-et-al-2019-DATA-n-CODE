function [th,thk] = ConvertAgusData(paramset,psel)
%
%   [th,thk] = ConvertAgusData(paramset,psel)
%
%   Convert Agus' 82 x N x 24 data set 
%   to my format using the selection structure psel
%

[Ns,Nr,Np] = size(paramset);

% Parameter names in Agus sequence
pName = cell(1,Np);
pName{1} = 'te';
pName{2} = 'ti';
pName{3} = 'gee';
pName{4} = 'gii';
pName{5} = 'Ge';
pName{6} = 'Gi';
pName{7} = 'Nee';
pName{8} = 'Nei';
pName{9} = 'Nie';
pName{10} = 'Nii';
pName{11} = 'pee';
pName{12} = 'pei';
pName{13} = 'her';
pName{14} = 'hir';
pName{15} = 'heeq';
pName{16} = 'hieq';
pName{17} = 'Se';
pName{18} = 'Si';
pName{19} = 'me';
pName{20} = 'mi';
pName{21} = 'se';
pName{22} = 'si';
pName{23} = 'g';
pName{24} = 'heb';

% construct translation index array
indx = zeros(1,Np);
for n = (1:Np-2)
    pn = ParamNameSimple(psel,n);
    for k = (1:Np)
        if strcmp(pn,pName{k})
            indx(n) = k;
        end
    end
end

% convert to arrays in my format
th = cell(1,Ns);
thk = zeros(Np-2,Ns);
for n = (1:Np-2)
    for k = (1:Ns)
        th{k}(n,:) = paramset(k,:,indx(n));
    end
    thk(n,:) = paramset(:,1,indx(n));
end


