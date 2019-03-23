function [S,sk,sd] = IdealSpect(param,freq,K)
%
%   [S,sk,sd] = IdealSpect(param,freq,K)
%
%   Generate a random sample of the idealised psd for the MPD version of the Liley model 
%   param is the usual parameter structure (see AgusParam2.m)
%   freq is the set of frequencies  (Hz) at which to calculate the spectrum
%   K is the number of epochs in the Welch periodogram
%   
%   S is a sequence of gamma distributed random variates based on the 
%   ideal psd (sk) with unit driving signal amplitude
%   sd is the standard deviation of the spectral estmates
%

% Generate the idelaised unit amlitude spectrum
fk = MPDSpectrumD2(param,freq,0);
if isempty(fk)
    S = [];
    sk = [];
    sd = [];
    return;
end
sk = abs(fk(1,:)).^2;

% calculate the scale parameters
theta = sk/K;
sd = theta*sqrt(K);

% generate the random devaites
S = gamrnd(K,theta);

