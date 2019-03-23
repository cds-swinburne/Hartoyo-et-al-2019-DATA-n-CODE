function [L1,L2,Npages] = PlotShape(L,flg)
%
%   [L1,L2,Npages] = PlotShape(L,flg)
%
% Define a convenient subplot grid
%   L= number of parameters to plot
%   flg = 0 -> number of plots = L*(L-1)/2 (default)
%   flg = 1 -> number of plots = L
%

if L < 1
    L1 = 0;
    L2 = 0;
    Npages = 0;
    return;
end

MxNm = 12;
if nargin < 2
    flg = 0;
end
if flg == 0
    M = round(L*(L-1)/2);
else
    M = round(L);
end

Nx = mod(M,MxNm);
if Nx >  0
    Npages = floor(M/MxNm)+1;
else
    Npages = round(M/MxNm);
end
if Npages == 1
    switch (L)
        case 1; L1 = 1; L2 = 1;
        case 2; L1 = 1; L2 = 2;
        case 3; L1 = 2; L2 = 2;
        case 4; L1 = 2; L2 = 2;
        case 5; L1 = 2; L2 = 3;
        case 6; L1 = 2; L2 = 3;
        case 7; L1 = 3; L2 = 3;
        case 8; L1 = 3; L2 = 3;    
        case 9; L1 = 3; L2 = 3;
        case 10; L1 = 4; L2 = 3;
        case 11; L1 = 4; L2 = 3;
        case 12; L1 = 4; L2 = 3;
    end
else
    L1 = 4;
    L2 = 3;
end
