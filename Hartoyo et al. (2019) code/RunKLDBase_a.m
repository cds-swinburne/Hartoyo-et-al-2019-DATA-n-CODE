% RunKLDBase_a.m
%
%   Run a sequence of KLD calculations
%   for Agus data

global wb_handle;

Nsubj = length(indx_a);
Np = NumSel(psel);
kld = zeros(Np,Nsubj);

wb_handle = waitbar(0,'1','Name','Kullbeck-Leibler Algorithm...',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(wb_handle,'canceling',0)

tic
for n = (1:Nsubj)
    
    if getappdata(wb_handle,'canceling')
        break;                   
    end
    % Report current estimate in the waitbar's message field       
    str = sprintf('Subject = %d',n);         
    waitbar(n/Nsubj,wb_handle,str);

%     fnm = sprintf('C:\\MATLAB\\DH\\Agus\\ThetaFileBaseWN%d.mat',n);
%     load(fnm);
    th = th_a{n};
    kld(:,n) = CalcKLDBase(th,psel,prm,dev_a,mparam);   
end
    
delete(wb_handle);
wb_handle = [];
toc