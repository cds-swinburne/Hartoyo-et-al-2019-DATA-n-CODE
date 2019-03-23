% ReadEEGDataOz.m
%
%   Read in physionet eeg data
%

M = 109;
if M < 10
    M1 = M;
    M2 = M;
elseif M < 100
    M1 = 9;
    M2 = M;
else
    M1 = 9;
    M2 = 99;
end
datafiles = cell(1,2*M);
%record_o = cell(1,M);
record_c = cell(1,M);
for n = (1:M1)
    datafiles{2*(n-1)+1} = sprintf('S00%dR01.edf',n);
    datafiles{2*n} = sprintf('S00%dR02.edf',n);
end
for n = (10:M2)
    datafiles{2*(n-1)+1} = sprintf('S0%dR01.edf',n);
    datafiles{2*n} = sprintf('S0%dR02.edf',n);
end
for n = (100:M)
    datafiles{2*(n-1)+1} = sprintf('S%dR01.edf',n);
    datafiles{2*n} = sprintf('S%dR02.edf',n);
end
Oz = 62;
skp = 640;
Hd = BPFilterBase;
for n = (1:M)
    %[hdr,record_o{n}] = edfread(datafiles{2*(n-1)+1});
    [hdr,r_c] = edfread(datafiles{2*n});
    record_c{n} = filter(Hd,r_c(Oz,skp:end));
end



    
    
    