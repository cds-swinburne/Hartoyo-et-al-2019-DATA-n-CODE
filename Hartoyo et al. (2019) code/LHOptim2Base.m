function thk = LHOptim2Base(S,freq,param,dev,psel,mparam)
%
%   thk = LHOptim2Base(S,freq,param,dev,psel,mparam)
%
%   Find the arguments (thk) which maximise the log likelihood 
%   corresponding to the measured spectrum S at the frequencies freq (Hz)
%   Log likelihood version with updated alpha
%
%   param(1) is the parameter structure at the initial point
%   param(2) is the parameter structure of mean values used in priors
%   dev is the deviation structure 
%   psel is the selection structure
%   mparam.K is the number of epochs used in pwelch
%   mparam.eitype: 0 for independent gamma_xx, 1 for ee = e1 and ii = ie
%   mparam.fig is the base figure number for plotting 
%       (0 to suppress all plots)
%   mparam.ptype = is a prior distribution structure ( field = 0 => Gaussian, 1 => uniform, 2 => exponential, 3 => log-normal )
%   mparam.norm = 1 -> normalize parameters in optimisation (default = 0)
%

if (nargin <6)||isempty(mparam)
    mparam.K = 28;    
    mparam.fig = -1;
    mparam.ptype = PriorType(1);
    mparam.eitype = 1;
    mparam.norm = 1;
end
if ~isfield(mparam,'eitype')
    mparam.eitype = 0;
end
if mparam.eitype == 1 % make sure the linked case varies only gamma_ee and gamma_ii
    psel.gamma_ei = 0;
    psel.gamma_ie = 0;
end
if ~isfield(mparam,'norm')
    mparam.norm = 0;
end
K = mparam.K;
fig = abs(mparam.fig);
ptype = ParamArray(mparam.ptype,psel);

% generate starting values
if mparam.norm == 0
    theta = ParamArray(param(1),psel);
    theta_p = ParamArray(param(2),psel);
    sigma = ParamArray(dev,psel);
else
    theta = ParamArray(param(1),psel,dev);
    theta_p = ParamArray(param(2),psel,dev);
    sigma = ParamArray(dev,psel,dev);
end

tsf = 1e-4;%5e-4;
f0 = cf(theta);
tf = f0*tsf;
x0 = sum(abs(theta));
tx = x0*tsf;

% find the best fit 
mxfn = 40000;
mxitr = 20000;
%options = optimset('TolX',1e-7,'MaxFunEvals',mxfn,'MaxIter',mxitr);
if mparam.norm == 0
    options = optimset('TolX',1e-7,'MaxFunEvals',mxfn,'MaxIter',mxitr);
else
    options = optimset('TolX',tx,'TolFun',tf,'MaxFunEvals',mxfn,'MaxIter',mxitr);
end
[thk,feval,eflg] = fminsearch(@cf,theta,options);
if eflg < 0
    fprintf('fminsearch returned erflg = -1 and feval = %f\n',feval);
    return
end
if mparam.norm == 0
    param1 = UpdateParam(param(1),thk,psel);
else
    param1 = UpdateParam(param(1),thk,psel,dev);    
end

if mparam.eitype == 1
    param1.gamma_ei = param1.gamma_ee;
    param1.gamma_ie = param1.gamma_ii;
end

if mparam.norm == 1 % convert to un-nomalised parameter values
    thk = DeNormArray(thk,psel,[],dev);    
end

if mparam.fig == 0
    return;
end

fkm = MPDSpectrumD2(param1,freq,0);
if isempty(fkm)
    return;
end
skm = abs(fkm(1,:)).^2;
alpha = sum(S)/sum(skm);%K/sum(S./skm);

[S1,~,sd] = IdealSpect(param1,freq,K);
if ~isempty(S1)
    %figure(fig),clf,plot(freq,skm,'r',freq,alpha*S,'b',freq,S1,'k',freq,skm-sd,'k',freq,skm+sd,'k');
    figure(fig),clf,plot(freq,skm*alpha,'r',freq,S,'b',freq,(skm-sd)*alpha,'k',freq,(skm+sd)*alpha,'k');
    xlabel('Freq (Hz)')
    ylabel('PSD')
    legend('S_k(w|\theta)','S(w)','S_k_n');
end

    function f = cf(th)
        if mparam.norm==0
            param1 = UpdateParam(param(1),th,psel);        
        else
            param1 = UpdateParam(param(1),th,psel,dev);        
        end
        %param1 = UpdateParam(param,th,psel);
         if mparam.eitype == 1
            param1.gamma_ei = param1.gamma_ee;
            param1.gamma_ie = param1.gamma_ii;
        end
         fk1 = MPDSpectrumD2(param1,freq,0);
         if isempty(fk1)     % skip if there are no stable solutions 
             f = inf;
             return;
         end
         sk1 = abs(fk1(1,:)).^2;            
         pk = PriorPDF(th,theta_p,sigma,ptype);
         %pk = PriorPDF(th,theta,sigma,ptype);
         f = -log(pk) - LHLogValue(sk1,S,K);         
    end
         


end