function pp = LHLogValue(sk,S,K)
%
%   pp = LHLogValue(sk,S,K)
%
%   Calculate the raw log likelyhood for the trial spectrum sk
%   given the target spectrum S
%   and the number of sweeps in the welsh estimate K
%

M = length(S);
b = log(mean(S./sk));
c = sum(log(sk));
pp = -K*M*b - K*c;

