function [x,t] = IdealEEG(param,fs,T,Hd)
%
%   [x,t] = IdealEEG(param,fs,T,Hd)
%
%   Generate a random sample of the idealised time domain signal
%   for the MPD version of the Liley model 
%   param is the usual parameter structure (see AgusParam2.m)
%   fs is the desired sampling frequency
%   T is the duration of the signal (sec)
%   Hd is the FIR filter to use (default none)
%
%   x is a sequence of sampled eeg signals
%   t is the sampletime array
%

if (nargin < 4)
    Hd = [];
end
if (nargin < 3)||isempty(T)
    T = 10;
end
if (nargin < 2)||isempty(fs)
    fs = 160;
end

% Generate the idealised unit amlitude spectrum
N = round(fs*T);
r = nextpow2(N);
N = 2^r;
t = (0:N-1)/fs;
freq = (0:N-1)*fs/N;
fk = MPDSpectrumD2(param,freq,0);
if isempty(fk(1,:))
    x = [];    
    return;
end

% generate the sampled time-domain signal

phi = 2*pi*rand(1,N/2);
phi = [phi phi(N/2:-1:1)];
Fm = fk(1,:).*exp(1i*phi);
Fm(1) = 0; % remove any dc component
x = real(ifft(Fm));

% apply filter is required
if ~isempty(Hd)
    x = filter(Hd,x);
end


