function cfm = PlotFitBase(S,freq,th,param,psel,mparam,thk)
%
%   cfm = PlotFitBase(S,freq,param,th,psel,mparam,thk)

%   Plot a subset of the fitted spectra
%

Np = 75;
Ns = size(th,2);
dn = floor(Ns/Np);
nn = 1 + (0:Np-1)*dn;
if mparam.fig == 0
    fig = 1;
else
    fig = round(abs(mparam.fig));
end
if ~isfield(mparam,'flg')
    mparam.flg = 1;
end
Nf = length(freq);
fr = interp1((1:Nf),freq,(1:0.25:Nf));

if (nargin < 7)||isempty(thk)
    cf = RatioCostFnBase(S,freq,th(:,nn),psel,mparam);
    [~,indx] = sort(cf,'ascend');
    m = indx(1);%floor(Np/2));
    cfm = cf(m);
    p = UpdateParam(param,th(:,nn(m)),psel);
else
    cfm = RatioCostFnBase(S,freq,thk,psel,mparam);
    p = UpdateParam(param,thk,psel);
end

if mparam.eitype == 1
    p.gamma_ei = p.gamma_ee;
    p.gamma_ie = p.gamma_ii;
end  
[~,S0,~] = IdealSpect(p,fr,mparam.K);
% sf1 = sum(S)/sum(S0(1:4:end));
sf = sum(S.*S0(1:4:end))/sum(S0(1:4:end).^2);
S0 = sf*S0;

skL = gaminv(0.16,mparam.K,S0/mparam.K);
skU = gaminv(0.84,mparam.K,S0/mparam.K);
    
figure(fig);%clf;
hold on;
if mparam.flg
    for n = nn        
        p = UpdateParam(param,th(:,n),psel);
        if mparam.eitype == 1
            p.gamma_ei = p.gamma_ee;
            p.gamma_ie = p.gamma_ii;
        end

        [~,Sn,~] = IdealSpect(p,fr,mparam.K);        
        sf = sum(S)/sum(Sn(1:4:end));        
        Sn = sf*Sn;
        plot(fr,Sn,'c');    
    end    
end
plot(fr,S0,':b','LineWidth',2);
plot(fr,skL,'k','LineWidth',1);
plot(fr,skU,'k','LineWidth',1);
plot(freq,S,'r','LineWidth',2);
hold off

xlabel('frequency (Hz)');
ylabel('PSD');
% title(sprintf('Subject %d',mparam.subj));

