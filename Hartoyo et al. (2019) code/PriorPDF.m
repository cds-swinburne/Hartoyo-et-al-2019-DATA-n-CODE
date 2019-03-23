function p = PriorPDF(theta,theta_bar,sigma,tp)
%
%   p = PriorPDF(theta,theta_bar,sigma,tp)
%
%   calculate the pdf for the parameters (theta) given their means
%   (theta_bar) standard deviations (sigma) and types (tp)
%       tp(n) can be normal (tp(n) = 0) 
%       uniform (tp(n) = 1) 
%       exponential (tp(n) = 2, the sigma parameter is ignored)
%       log-normal (tp(n) = 3, negative theta => p = 0)
%

indx = find(tp==0);
if ~isempty(indx)
    p0  = prod(exp(-0.5*((theta(indx)-theta_bar(indx))./sigma(indx)).^2)./(sqrt(2*pi)*sigma(indx)));
else
    p0 = 1;
end

indx = find(tp==1);
if ~isempty(indx)
    th1 = theta_bar(indx) - sigma(indx)*sqrt(3);
    th2 = theta_bar(indx) + sigma(indx)*sqrt(3);
    p1 = prod(((theta(indx) >= th1)&(theta(indx) <= th2))./(2*sqrt(3)*sigma(indx)));
else
    p1 = 1;
end
   
indx = find(tp==2);
if ~isempty(indx)
    p2 = prod(exp(-theta(indx)./theta_bar(indx)).*(theta(indx) >= 0)./theta_bar(indx));
else
    p2 = 1;
end

indx = find(tp==3);
if ~isempty(indx)
    s2 = log(1 + sigma(indx).^2./theta_bar(indx).^2);
    m = log(theta_bar(indx)) - 0.5*s2;
    p3 =prod((theta(indx) > 0).*exp(-0.5*((log(theta(indx))-m)).^2./s2)./(sqrt(2*pi)*theta(indx).*sqrt(s2)));
else
    p3 = 1;
end

p = p0*p1*p2*p3;

