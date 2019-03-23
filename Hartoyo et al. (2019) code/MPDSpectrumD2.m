function [F,freq1,F1,F2,F3] = MPDSpectrumD2(param,freq1,flg)
%
%   [F,freq,F1,F2,F3] = MPDSpectrumD2(param,freq,flg)
%
%   Find the Fourier transfer function F over the frequencies in freq (Hz)
%   Assuming that the input is on pee alone
%   Uses analytic expression for the linearised system componentrs
%
%   param as defined in MPDParam2.m - using 4 distinct 4 gammas
%   freq = frequency range required (Hz)
%   flg = 0 to suppress plot (default)
%

if (nargin < 1)||isempty(param)
    param = AgusParam();
end

if (nargin < 2)||isempty(freq1)
    freq1 = linspace(0,60,200);
else
    freq1 = reshape(freq1,1,length(freq1));
end
freq = freq1*1e-3; % times are in ms 
if nargin < 3
    flg = 0;
end

% find the zeros
[~,Lam,Jac] = MPDSingPts2(param,0);
N = length(Lam);
M = length(freq);
w = 2*pi*freq;
L = 0;
S = zeros(N,length(freq));
F = zeros(N,M);
F1 = zeros(N,M);
F2 = zeros(N,M);
F3 = zeros(N,M);
for n = (1:N)
    jac = Jac{n};
    [~,vlam] = eig(jac);
    if max(real(diag(vlam))) < 0 % only proceed for stable fixed points            
        L = L+1;
        [F(L,:),F1(L,:),F2(L,:),F3(L,:)] = TferFn(jac,w);
       
%         S(L,:) = abs(F(L,:)).^2;        
%         if flg
%             figure(ceil(abs(flg))+L-1),clf;
%             plot(freq1,S(L,:),'r');
%             xlabel('Frequency (Hz)');
%             ylabel('PSD');
%         end
    end
end

if L == 0
    F = [];
    F1 = [];
    F2 = [];
else
    F = F(1:L,:);
    F1 = F1(1:L,:);
    F2 = F2(1:L,:);
    if isfield(param,'eta')
        if (param.eta < 0)
            eta = 0;
        elseif (param.eta > 1)
            eta = 1;
        else
            eta = param.eta;
        end
        if eta > 0
            F = F./repmat((freq).^eta,L,1);                        
        end
    end
end

if flg
    for n = (1:L)
        S(n,:) = abs(F(n,:)).^2;        
        figure(ceil(abs(flg))+L-1),clf;
        plot(freq1,S(L,:),'r');
        xlabel('Frequency (Hz)');
        ylabel('PSD');
    end
end

% --- Calculate the reduced matrix and its (4,1) cofactor
    function [H,H1,H2,H3] = TferFn(Jcb,w1)
        k11 = Jcb(1,1)-1i*w1; k13 = Jcb(1,3); k15 = Jcb(1,7);
        k22 = Jcb(2,2)-1i*w1; k24 = Jcb(2,5); k26 = Jcb(2,9);
        k31 = Jcb(4,1); k33 = -(1i*w1+param.gamma_ee).^2; 
        k41 = Jcb(6,1); k44 = -(1i*w1+param.gamma_ei).^2; 
        k52 = Jcb(8,2); k55 = -(1i*w1+param.gamma_ie).^2;
        k62 = Jcb(10,2); k66 = -(1i*w1+param.gamma_ii).^2;        
        
        H1 = k13./(k13*k31 - k11.*k33);
        H2 = (k15*k24*k41*k52/k13)./(k22.*k66 - k26*k62); 
        H3 = k33.*k66./(k44.*k55);
        H = H1./(1 + H1.*H2.*H3);        
    end

end
