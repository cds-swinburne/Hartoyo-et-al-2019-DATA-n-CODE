function pp = LHLogRatio(sk1,sk,S,K)
%
%   pp = LHLogRatio(sk1,sk,S,K)
%
%   Calculate the value of the un-normalised log likelyhood
%   ratio the measured specrtum S 
%   sk is previous calculated spectrum
%   sk1 is current trial calculated spectrum
%   K is the number of epochs averaged over
% 

M = length(sk1);
b1 = log(mean(S./sk1));
b = log(mean(S./sk));
c1 = sum(log(sk1));
c = sum(log(sk));
pp = K*M*(b-b1) + K*(c-c1);


