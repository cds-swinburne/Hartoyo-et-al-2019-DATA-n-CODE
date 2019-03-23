function theta = Proposal1(theta,sigma,t)
%
%   theta = Proposal1(theta,sigma,t)
%
%   select a proposed updated parameter set theta1 - stepped version
%   given the current value of the parameters 
%   and an array (sigma) of step sizes.
%   and a stepping index
%

theta(t) = theta(t) + sigma(t)*randn(1,1);

