function [d2C,le,la] = DKYHessianSeqBase(th,freq,param,dev,psel,fig,mparam)
%
%   [d2C,le,la] = DKYHessianSeqBase(th,freq,param,dev,psel,fig,mparam)
%
%   Estimate the Hessian of the KL divergence
%   for the Nparam x  Nsubj array of fitted parameters th. 
%   the Hessian is based on un-normalised parameters th(:,i)
%
%   freq = frequency at sample points,
%   param,dev,psel and mparam as in LHOptim2
%   fig = figure number to use (default 1)
%
%   d2C is a cell array of Hessians, 
%   le is a cell array of sorted eigenvectors
%   la is the array of sorted eigenvalues
%

if nargin < 7
    mparam.K =28;% 145;
    mparam.N = 100000;
    mparam.Nb = 20000;
    mparam.fig = 1;
    mparam.ptype = 0;
    mparam.Ne = 5;
    mparam.Clf = 1;
    mparam.clr = 'r';
end

if nargin < 6
    fig = 1;
end

[Np,Ns] = size(th);
if (~isfield(mparam,'Ne'))||(mparam.Ne > Np)
    mparam.Ne = Np;
end
if ~isfield(mparam,'Clf')
    mparam.Clf = 1;
end
if ~isfield(mparam,'clr')
    mparam.clr = 'r';
end

    
d2C = cell(1,Np);
le = cell(1,Np);
la = zeros(Np,Ns);
for n = (1:Np)
    le{n} = zeros(Np,Ns);
end
figure(fig);
if mparam.Clf
    clf;
end
    
h = 0;
for n = (1:Ns)
    thn = th(:,n);
    d2C{n} = DKYHessianBase(thn,freq,param,dev,psel,mparam);
    if ~isempty(d2C{n})
        [ev,lambda] = eig(d2C{n});
        lm = diag(lambda);
        Lambda = lm;%abs(lm);
        [maxLambda,indx] = sort(Lambda,'descend');%max(Lambda);
        Lambda = maxLambda/maxLambda(1);  
        la(:,n) = lm(indx);
        ne = 0;
        for k = (1:Np)
            le{k}(:,n) = ev(:,indx(k));
            if (Lambda(k) > 0)&&(ne < mparam.Ne)
                semilogy([n n+1]-0.5,Lambda(k)*[1 1],mparam.clr,'LineWidth',2);  
                if h == 0
                    hold on
                    h = 1;
                end
                ne = ne+1;
            end            
        end
        xlim([0 Ns+1]);
    else
        semilogy([n n+1]-0.5,[1 1],':k','LineWidth',1);
        xlim([0 Ns+1]);
    end
    drawnow;
end
hold off

    