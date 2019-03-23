function cf = LogLFnBase(S,freq,thk,prm,dev,psel,mparam)
%
%   cf = LogLFnBase(S,freq,thk,prm,dev,psel,mparam)
%
%   Calculate the maximum likelyhood fn for the spectrum S 
%   sampled at the frequencies in freq (Hz)
%   with the MCMC2 parameter arrays in thk (Num param x num samples, un-normalised)
%   prm(1) is the starting parameter structure
%   prm(2) is the prior mean parameter structure
%   corresponding to the selection parameter structure
%   
%   cf is an array of log likelyhood values 
%   the sequence of values corresponds to the sequence of sampled points in
%   thk
%

global wb_handle;

param = prm(2);
[~,Ns] = size(thk);
cf = zeros(1,Ns);
if (nargin < 5)||isempty(mparam)
    K = 28;
else
    K = mparam.K;
end
Nu = 100;
if Ns > Nu-1
    wb_handle = waitbar(0,'1','Name','Ratio cost functions...',...
                'CreateCancelBtn',...
                'setappdata(gcbf,''canceling'',1)');
    setappdata(wb_handle,'canceling',0)
    tic;
end

if mparam.eitype == 1
    psel.gamma_ei = 0;
    psel.gamma_ie = 0;
end

ptype = ParamArray(mparam.ptype,psel);

% generate starting values
theta_p = ParamArray(param,psel);
sigma = ParamArray(dev,psel);


for n = (1:Ns)
    if mod(n,Nu)==0
    % Check for Cancel button press
        if getappdata(wb_handle,'canceling')            
            delete(wb_handle);
            wb_handle = [];
            toc
            return;
        end
        % Report number completed
        str = sprintf('Completed = %d',n-1);               
        waitbar(n/Ns,wb_handle,str);
    end
    param1 = UpdateParam(param,thk(:,n),psel);
    if mparam.eitype == 1
        param1.gamma_ei = param1.gamma_ee;
        param1.gamma_ie = param1.gamma_ii;
    end

     fk1 = MPDSpectrumD2(param1,freq,0);
     if ~isempty(fk1)     % skip if there are no stable solutions          
         sk1 = abs(fk1(1,:)).^2;            
         pk = PriorPDF(thk(:,n)',theta_p,sigma,ptype);
         cf(n) = log(pk) + LHLogValue(sk1,S,K);   
     else
         cf(n) = NaN;
     end              
end

if Ns > Nu-1
    delete(wb_handle);
    toc
end
wb_handle = [];


    
    
