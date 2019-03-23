% RunLHOptim2BaseML.m
%
%   Run a sequence of optimisations (starting from max of MCMC likelyhood)
%

Nsubj = length(indx_a);
Np = NumSel(psel);
thk_ml = zeros(Np,Nsubj);
prm2 = prm;
for n = (1:Nsubj)
    mparam.subj = n;
    fnm = sprintf('ThetaFileBaseWN%d.mat',n);
    load(fnm);
    idx1 = (1:1000:length(th));   
    cf = LogLFnBase(S_c(indx_a(n),indx_f),freq(indx_f),th(:,idx1),prm,dev_a,psel,mparam);
    [~,idx] = max(cf);
    prm2(1) = UpdateParam(param(1),th(:,idx1(idx)),psel);
    thk_ml(:,n) = LHOptim2Base(S_c(indx_a(n),indx_f),freq(indx_f),prm2,dev_a,psel,mparam);
    if mparam.fig ~= 0
        title(sprintf('Subject %d',indx_a(n)));
        drawnow;
    end
end
