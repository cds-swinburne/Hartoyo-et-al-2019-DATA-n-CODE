function thk = MCMCBase(S,freq,param,dev,psel,mparam)
%
%   thk = MCMCBase(S,freq,param,dev,psel,mparam)
%
%   Generate a sampling of a sub-space of the parameter space
%   corresponding to the measured spectrum S at the frequencies freq (Hz)
%   In this version, proposal uses sequential updating
%   and the alpha is trteated as a MLE parameter - which is probably a mistake
%   and log likelihoods are used
%   
%
%   param(1) is the parameter structure at the initial point
%   param(2) is the parameter structure of mean values
%   dev is the deviation structure 
%   psel is the selection structure
%   mparam.K is the number of epochs used in pwelch
%   mparam.N is the number of trials to run (default 100000)
%   mparam.Nb length of burn-in sequence (default 20000)
%   mparam.eitype: 0 for independent gamma_xx, 1 for ee = e1 and ii = ie
%   mparam.fig is the base figure number for plotting 
%       (0 to suppress all plots,
%        <0 to suppress correlation plots)
%   mparam.ptype = is a prior distribution structure ( field = 0 => Gaussian, 1 => uniform, 2 => exponential, 3 => log-normal )
%   mparam.norm = 1 -> normalize parameters in optimisation (default = 0)
%
%   thk is the array of sampled parameter values
%

global wb_handle;

if (nargin <6)||isempty(mparam)
    mparam.K = 150;
    mparam.N = 100000;
    mparam.Nb = 20000;
    mparam.eitype = 1;
    mparam.fig = 1;
    mparam.ptype = PriorType(0);
    mparam.norm = 0;
end
K = mparam.K;
N = mparam.N;
Nb = mparam.Nb;

fig = abs(mparam.fig);

if mparam.eitype == 1
    psel.gamma_ei = 0;
    psel.gamma_ie = 0;
    param(1).gamma_ei = param(1).gamma_ee;
    param(1).gamma_ie = param(1).gamma_ii;
    param(2).gamma_ei = param(2).gamma_ee;
    param(2).gamma_ie = param(2).gamma_ii;
end

% generate starting values
fk = MPDSpectrumD2(param(1),freq,0);
if isempty(fk)
    error('MCMC must start from a stable solution');
end
sk = abs(fk(1,:)).^2;

if mparam.norm == 0
    theta = ParamArray(param(1),psel);
    theta0 = ParamArray(param(2),psel);
    sigma = ParamArray(dev,psel);
else
    theta = ParamArray(param(1),psel,dev);
    theta0 = ParamArray(param(2),psel,dev);
    sigma = ParamArray(dev,psel,dev);
end
L = length(theta);

sf = ones(1,L)*0.4/sqrt(K);% varied during burn-in, then fixed
ptype = ParamArray(mparam.ptype,psel);
pk = PriorPDF(theta,theta0,sigma,ptype);

% adjust counts to allow for burn-in and one-at-a-time proposal sequence
Nu = ceil(100/L)*L;
Nb = ceil(Nb/L)*L;
N = ceil(N/L)*L;
N = N + Nb;

% do the Metropolis algorithm
k = 0;
t = 0;
acc = zeros(1,L);
wb_handle = waitbar(0,'1','Name','Metropolis Algorithm...',...
            'CreateCancelBtn',...
            'setappdata(gcbf,''canceling'',1)');
setappdata(wb_handle,'canceling',0)

tic;
thk = zeros(L,N);
while (k < N)
    if mod(k,Nu)==0
    % Check for Cancel button press
        if getappdata(wb_handle,'canceling')
            thk = [];            
            delete(wb_handle);
            wb_handle = [];
            toc
            return;
        end
        % Report current estimate in the waitbar's message field       
        if k < Nb
            str = sprintf('Acceptance(b) = %g',sum(acc)/Nu);   
            sf = sf + 0.1*sf.*(acc*L/Nu - 0.25);
            acc = zeros(1,L);
        else
            str = sprintf('Acceptance = %g',sum(acc)/(k-Nb));
        end
        waitbar(k/N,wb_handle,str);
    end
    
    theta1 = Proposal1(theta,sf.*sigma,t+1);    
    %lnr = log(rand(1,1));
    if mparam.norm == 0
        param1 = UpdateParam(param(1),theta1,psel);
    else
        param1 = UpdateParam(param(1),theta1,psel,dev);
    end
    if mparam.eitype == 1
        param1.gamma_ei = param1.gamma_ee;
        param1.gamma_ie = param1.gamma_ii;
    end

    fk1 = MPDSpectrumD2(param1,freq,0);      
    if ~isempty(fk1)     % skip if there are no stable solutions  
        sk1 = abs(fk1).^2; 
        k = k+1;        
        pp = LHLogRatio(sk1(1,:),sk(1,:),S,K);
        pk1 = PriorPDF(theta1,theta0,sigma,ptype);
        pr = pp + log(pk1) - log(pk);
        lnr = log(rand(1,1));
        if pr > lnr
            acc(t+1) = acc(t+1)+1;
            thk(:,k) = theta1';           
            theta = theta1;
            sk = sk1;
            pk = pk1;           
        else
            thk(:,k) = theta';            
        end
        if mparam.norm
            thk(:,k) = DeNormArray(thk(:,k),psel,[],dev);
        end
        t = mod(t+1,L);
    end
end
thk = thk(:,Nb+1:N);
delete(wb_handle);
wb_handle = [];
toc

% exit if no plotting required
if mparam.fig == 0  
    return;
end

% display result at mean
mthk = mean(thk,2);
param1 = UpdateParam(param(1),mthk,psel);
if mparam.eitype == 1
    param1.gamma_ei = param1.gamma_ee;
    param1.gamma_ie = param1.gamma_ii;
end
fkm = MPDSpectrumD2(param1,freq,0);

if ~isempty(fkm)
    skm = abs(fkm(1,:)).^2;
    alpha = sum(skm(1,:))/sum(S);%K/sum(S./skm(1,:));    
    figure(fig),clf,subplot(1,1,1),plot(freq,skm/alpha,'r',freq,S,'b');
    xlabel('Freq (Hz)')
    ylabel('PSD')
    legend('S_k(w|\theta)','S(w)');
end

if mparam.norm
    theta0 = ParamArray(param(2),psel);
    sigma = ParamArray(dev,psel);
end

% Display marginals of variable parameters
[L1,L2] = PlotShape(L);
m = 1;
np = 0;
for n = (1:L)
    if mod(n,L1*L2) == 1
        np = np+1;
        figure(fig+np);clf;
    end
    subplot(L1,L2,m-(np-1)*L1*L2);
    histogram(thk(n,:),100,'normalization','pdf','EdgeColor','none');
   
    th = linspace(theta0(n)-2*sigma(n),theta0(n)+2*sigma(n),101);
    if ptype(n) == 0
        f = (1/(sqrt(2*pi)*sigma(n)))*exp(-0.5*((th-theta0(n))/sigma(n)).^2);
    elseif ptype(n) == 1
        f = (th >= theta0(n)-sigma(n)*sqrt(3)).*(th <= theta0(n)+sigma(n)*sqrt(3))./(2*sigma(n)*sqrt(3));
    elseif ptype(n) == 2
        f = (th >= 0).*exp(-th/theta0(n))/theta0(n);
    else
        s2 = log(1 + sigma(n).^2./theta0(n).^2);
        m = log(theta0(n)) - 0.5*s2;
        f = (th > 0).*exp(-0.5*((log(th(n))-m)).^2./s2)./(sqrt(2*pi)*th(n).*sqrt(s2));
    end
    
    hold on;
    plot(th,f,'r');
    hold off;
    title(ParamName(psel,n));
    m = m+1;
end

if mparam.fig < 0
    return;
end

% display histograms for pairs of variables
M = L*(L-1)/2;
if (L > 1)
    [M1,M2] = PlotShape(M);
    
    m = 1;
    np1 = 0;    
    for m1 = (1:L-1)
        for m2 = (m1+1:L)
            if mod(m,M1*M2) == 1 
                np1 = np1+1;
                figure(fig+np+np1);clf;               
            end
            subplot(M1,M2,m-(np1-1)*M1*M2);
            histogram2(thk(m1,:),thk(m2,:),10,'DisplayStyle','tile','ShowEmptyBins','on');            
            s = sprintf('%s - %s',ParamName(psel,m1),ParamName(psel,m2));
            title(s);
            m = m+1;
        end
    end
end


    
    

