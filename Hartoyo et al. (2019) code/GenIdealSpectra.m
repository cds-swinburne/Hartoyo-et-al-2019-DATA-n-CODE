function [sk] = GenIdealSpectra(th,param,psel,freq,K)
%
%   [sk] = GenIdealSpectra(th,param,psel,freq,K)
%
%   Generate a set of ideal spectra corresponding to the parameter sets (th : numparam x N))
%   using the base structure param 
%   with the selection structure psel
%
%   sk is the Nfreq x N array of mean spectra
%
%   freq = frequencies (Hz) at which to calculate specral estimates
%   K = number of segments averaged in Welch periodogram (default 28)
%

if nargin < 5
    K = 28;
end
if (nargin < 4)||isempty(freq)
    freq = linspace(2,19.75,72);
end
N = size(th,2);
sk = zeros(length(freq),N);
for n = (1:N)
    p = UpdateParam(param,th(:,n),psel);
    p.gamma_ei = p.gamma_ee;
    p.gamma_ie = p.gamma_ii;
    [~,sk1,~] = IdealSpect(p,freq,K);
    %S(:,n) = S1';
    if ~isempty(sk1)
        sk(:,n) = sk1';
    end
end



