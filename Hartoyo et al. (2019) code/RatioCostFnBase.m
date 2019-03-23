function cf = RatioCostFnBase(S,freq,thk,psel,mparam)
%
%   cf = RatioCostFnBase(S,freq,thk,psel,mparam)
%
%   Calculate the ratio of the observed LS cost fn to the expected LS cost
%   fn for the spectrum S sampled at the frequencies in freq (Hz)
%   with the MCMC2 parameter arrays in thk (Num param x num samples)
%   corresponding to the selection parameter structure
%   
%   cf is an array of ratio cost function values 
%   the sequence of values corresponds to the sequence of sampled points in
%   thk
%

global wb_handle;

param = AgusParam();
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
    fk = MPDSpectrumD2(param1,freq,0);
    
%    [sc,sdc] = IdealSpect0(param1,freq,K);
    if ~isempty(fk)
        sc = abs(fk(1,:)).^2;
        sdc = sc/sqrt(K);
%         alpha1 = sum(sc)/sum(S(n,:));
%         cf(1,n) = mean((S(n,:)*alpha1 - sc).^2)/mean(sdc.^2);   
        alpha2 = sum(sc.*S)/sum(S.^2);
        cf(n) = mean((S*alpha2 - sc).^2)/mean(sdc.^2);    
    else
        cf(n) = NaN;
    end
end

if Ns > Nu-1
    delete(wb_handle);
    toc
end
wb_handle = [];


    
    
