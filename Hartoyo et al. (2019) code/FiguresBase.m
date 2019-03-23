function FiguresBase(fp, figtype)
%
%   FiguresBase(fparam, figtype)
%
%   plot figure figtype 
%   using data in fparam
%
%   figtype = 1 -> spectral fits for selected subjects (default)
%   figtype = 2 -> single subject post and prior MCMC distributions
%   figtype = 3 -> KLD Box plots for all subjects
%   figtype = 4 -> parameter box plots for all subjects
%   figtype = 5 -> Hessian eigenvalues (selected subjects)
%   figtype = 6 -> Fisher Information eigenvalues (selected subjects)
%   figtype = 7 -> Hessian eigenvector kernel smoothed density plots (all subjects)
%   figtype = 8 -> Fisher matrix eigenvector angle density plots (all subjects)
%   figtype = 9 -> Prior estimation of Eigen-directions
%   figtype = 10 -> plot fitted spectra and spectra at points shifted in eigen directions
%   figtype = 11 -> plot the time domain eeg comparisons
%   figtype = 12 -> plot pairwise parameter histograms
%   figtype = 13 -> plot eigenvector components
%   figtype = 14 -> plot of derivatives of gaussain wrt its parameters
%   figtype = 15 -> plot of direction cosine magnitudes
%   figtype = 16 -? plot correlation coefficients
%
%   fparam.S = spectral data
%   fparam.subjects = array of subjects (indexes into indx_s)
%   fparam.indx_s = subject index array
%   fparam.indx_f = frequency index array   
%   fparam.freq =  frequencies (Hz)
%   fparam.prm: cell array of parameter structures
%   fparam.dev = standard deviation array for priors
%   fparam.psel = selection array for varianble parameters
%   fparam.mparam = miscellaneous parameter array
%   fparam.thk = ML fit parameters
%   fparam.th = selected subject MCMC parameters (cell array)
%   fparam.DKL = KL divergence array
%   fparam.figbase = base figure number (default 1)
%   fparam.le = cell array of eigenvectors
%   fparam.singsubj = index of the selected single subject into subjects array
%   fparam.dz =relative distance to move in eigen direction (default 1e-2)
%   fparam.evnum = index of eigen-direction 
%

if nargin < 1
    error('Missing figure parameter structure');
end
if (nargin < 2)||isempty(figtype)
    figtype = 1;
end

switch(figtype)
    case 1 % Spectral fits for selected subjects
        Ns = length(fp.subjects);
        switch(Ns) 
            case 1; Nx =1;Ny = 1;
            case 2; Nx =1;Ny = 2;
            case 3; Nx =1;Ny = 3;
            case 4; Nx =2;Ny = 2;
            case 5; Nx =2;Ny = 3;
            case 6; Nx =2;Ny = 3;
            case 7; Nx =3;Ny = 3;
            case 8; Nx =3;Ny = 3;
            case 9; Nx =3;Ny = 3;    
            otherwise
                for n = (1:Ns)            
                    S = fp.S(fp.indx_s(fp.subjects(n)),fp.indx_f);
                    freq = fp.freq(fp.indx_f);
                    th = fp.th{n};
                    param = fp.prm(1);
                    psel = fp.psel;
                    mparam = fp.mparam;
                    mparam.fig = fp.figbase + (n-1);
                    mparam.subj = fp.indx_s(fp.subjects(n));
                    thk = fp.thk(:,fp.subjects(n));
                    PlotFitBase(S,freq,th,param,psel,mparam,thk);

                    xlabel('Frequency (Hz)');
                    ylabel('PSD');
                    title(sprintf('Subject %d',fp.indx_s(fp.subjects(n))));            
                end
                return;
        end
        figure(fp.figbase);clf;
        for n = (1:Ns)            
            S = fp.S(fp.indx_s(fp.subjects(n)),fp.indx_f);
            freq = fp.freq(fp.indx_f);
            th = fp.th{n};
            param = fp.prm(1);
            psel = fp.psel;
            mparam = fp.mparam;
            mparam.fig = fp.figbase;% + (n-1);
            mparam.subj = fp.indx_s(fp.subjects(n));
            thk = fp.thk(:,fp.subjects(n));
            subplot(Ny,Nx,n);
            PlotFitBase(S,freq,th,param,psel,mparam,thk);

            xlabel('Frequency (Hz)');
            ylabel('PSD');
            xl = xlim;
            yl = ylim;
            sn = sprintf('Subject %d',fp.indx_s(fp.subjects(n)));
            text(xl(2)*0.7,yl(2)*0.9,sn);
            xlim(xl);ylim(yl);           
        end
    case 2 % MCMC prior and posterior distributions for single subject
        th = fp.th{1};
        prm = fp.prm;
        psel = fp.psel;
        mparam = fp.mparam;
        mparam.fig = fp.figbase;
        fig = mparam.fig;
        mparam.subj = fp.indx_s(fp.subjects(1)); 
        dev = fp.dev;
        PlotParamHistBase(th,psel,fig,2,prm,dev,mparam);    
    case 3 % DKL Box plots for all subjects
        kld = fp.KLD';
        [~,Np] = size(kld);
        tl = cell(1,Np);
        mkld = mean(kld);
        [~,indx] = sort(mkld,'descend');
        for n = (1:Np)
            tl{n} = ParamNameBase(fp.psel,indx(n));
        end
        figure(fp.figbase),clf;
        MyBoxPlot(kld(:,indx),tl);
        hold on;
        plot((1:Np),mkld(indx),'or');
        hold off;
        ylabel('D_K_L (nats)');
    case 4 % ML Parameter Box plots for all subjects
        thk = fp.thk';
        mthk = mean(thk);
        dev = ParamArray(fp.dev,fp.psel)*sqrt(3);
        [Ns,Np] = size(thk);
        y = (thk - repmat(mthk,Ns,1))*diag(1./dev);
        mkld = mean(fp.KLD');
        [~,indx] = sort(mkld,'descend');
        tl = cell(1,Np);       
        for n = (1:Np)
            tl{n} = ParamNameBase(fp.psel,indx(n));
        end
        figure(fp.figbase),clf;
        MyBoxPlot(y(:,indx),tl); 
        hold on
        plot([0 Np+1],[0 0],':k');
        hold off
        xlim([0 Np+1]);
        ylim([-1 1]);
        ylabel('Relative deviation');
        xlabel('Parameter');
        title('Deviation of ML parameter estimates relative to prior limits');
    case 5 % Hessian eigenvalue distributions (selected subjects)    
        Ns = length(fp.subjects);
        tl = cell(1,Ns);       
        for n = (1:Ns)
            tl{n} = sprintf('%d',fp.indx_s(fp.subjects(n)));
        end
        th = fp.thk(:,fp.subjects);
        freq = fp.freq(fp.indx_f);
        param = fp.prm(1);
        dev = fp.dev;
        psel = fp.psel;
        fig = fp.figbase;
        mparam = fp.mparam;      
        DKYHessianSeqBase(th,freq,param,dev,psel,fig,mparam);
        yl = ylim;
        xlim([0.5 Ns+0.5]);
        hold on;
        for n = (1:Ns-1)
            plot([n+0.5 n+0.5],yl,':k')
        end
        hold off;        
        ax = gca;
        ax.XTick = (1:Ns);
        ax.XTickLabel = tl;
        ax.XTickLabelMode = 'manual';
        xlabel('Subject number');
        ylabel('Dimensionless eigenvalue');
        title('Distributions of leading eigenvalues of Hessians');
    case 6 % Fisher information matrix eigenvalue distributions (selected subjects)    
        Ns = length(fp.subjects);
        if Ns <= 30
            dn = 1;
        else
            dn = 10;
        end
        tl = cell(1,floor(Ns/dn));       
        k = 0;
        for n = (1:dn:Ns)
            k = k + 1;
            tl{k} = sprintf('%d',fp.indx_s(fp.subjects(n)));
        end
        th = fp.thk(:,fp.subjects);
        freq = fp.freq(fp.indx_f);
        param = fp.prm(1);
        dev = fp.dev;
        psel = fp.psel;
        fig = fp.figbase;
        mparam = fp.mparam;       
        FisherSeqBase(th,freq,param,dev,psel,fig,mparam);
        yl = ylim;
        xlim([0.5 Ns+0.5]);
        hold on;
        for n = (1:Ns-1)
            plot([n+0.5 n+0.5],yl,':k')
        end
        plot([0 Ns+1],[1 1],':b','LineWidth',2);
        hold off;        
        ax = gca;
        ax.XTick = (1:dn:Ns);
        ax.XTickLabel = tl;
        ax.XTickLabelMode = 'manual';
        xlabel('Subject number');
        ylabel('Dimensionless eigenvalue');
        title('Distributions of leading eigenvalues of Fisher Information matrix');        
        ylim([1e-10 2e10]);
        
    case 7 % Hessian eigenvector angle density plots (all subjects)
        kld = fp.KLD';
        [~,Np] = size(kld);
        tl = cell(1,Np);
        mkld = mean(kld);
        [~,indx] = sort(mkld,'descend');
        for n = (1:Np)
            tl{n} = ParamNameBase(fp.psel,indx(n));
        end
        ss = cell(1,10);
        ss{1} = '^s^t';ss{2} = '^n^d';ss{3} = '^r^d';
        for k = (4:10)
            ss{k} = '^t^h';
        end
        
        t = linspace(0,pi,181);
        p = 0.5*sin(t).^20;
        td = 180*t/pi;
        for n = (1:fp.mparam.Ne)
            figure(fp.figbase+(n-1));clf;
            le = 180*acos(fp.le{n}')/pi;           
            MyDistPlot(le(:,indx),tl,p,td);            
            hold on;
            plot([0 Np+1],[90 90],':k');
            hold off;
            ylabel('Angle (deg)');
            xlabel('Parameter')
            ylim([0 180]);
            xlim([0 Np+1]);
            title(sprintf('Angle of %d%s Hessian eigenvector w.r.t. normalized parameter axis',n,ss{mod(n,10)}));
        end
    case 8 % Fisher matrix eigenvector angle density plots (all subjects)
        kld = fp.KLD';
        [~,Np] = size(kld);
        tl = cell(1,Np);
        mkld = mean(kld);
        [~,indx] = sort(mkld,'descend');
        for n = (1:Np)
            tl{n} = ParamNameBase(fp.psel,indx(n));
        end
        ss = cell(1,10);
        ss{1} = '^s^t';ss{2} = '^n^d';ss{3} = '^r^d';
        for k = (4:10)
            ss{k} = '^t^h';
        end
        
        t = linspace(0,pi,181);
        p = 0.5*sin(t).^20;
        td = 180*t/pi;
       figure(fp.figbase);clf;        
        for n = (1:fp.mparam.Ne)
            subplot(fp.mparam.Ne,1,n);
%             figure(fp.figbase+(n-1));clf;
            le = 180*acos(fp.le_f{n}')/pi;           
            MyDistPlot(le(:,indx),tl,p,td);            
            hold on;
            plot([0 Np+1],[90 90],':k');
            hold off;
            ylabel('Angle (deg)');
            if n == fp.mparam.Ne
                xlabel('Parameter')
            end
            ylim([0 180]);
            xlim([0 Np+1]);            
        end
     case 9 % combined-parameter MCMC posterior marginal distributions for a single subject
         if isfield(fp,'singsubj')
             ss = fp.singsubj;
         else
             ss = 4;
         end
         if ss > length(fp.subjects)
             ss = length(fp.subjects);
         end
        subj = fp.subjects(ss);
        th = fp.th{ss};
        thk = fp.thk(:,subj);
        prm = fp.prm;
        psel = fp.psel;       
        fig = fp.figbase;      
        dev = fp.dev;
        [Np,~] = size(fp.le_f{1});
        ev = zeros(Np,Np);
        for n = (1:Np)
            ev(:,n) = fp.le_f{n}(:,subj);
        end
        PlotCParamHistBase(ev,th,thk,psel,fig,prm,dev,fp.mparam.Ne);   
    case 10 % directional derivative type plot (selected subjects)
        freq = fp.freq(fp.indx_f);
        subj = fp.subjects; Ns = length(subj);
        evnum = fp.evnum; Nev = length(evnum);
        K = fp.mparam.K;
        if (Ns < 1)||(Nev < 1) 
            return
        end
        dz = fp.dz;
        param = fp.prm(1);
        delta = ParamArray(fp.dev,fp.psel);
        dth = dz*diag(delta);                
        figure(fp.figbase);clf;          
        
        for ns = (1:Ns)
            th0 = fp.thk(:,subj(ns));
            p0 = UpdateParam(param,th0,fp.psel);
            sk0 = GenIdealSpectra(th0,p0,fp.psel,freq,K);          
            
            for nev = (1:Nev)
                le = fp.le_f{evnum(nev)}(:,subj(ns));
                [~,ind] = max(abs(le));
                if le(ind) < 0
                    le = -le;
                end   
                if fp.invert(nev,ns)
                    le = -le;
                end
                th1 = th0 + dth*le;
                p1 = UpdateParam(param,th1,fp.psel);
                sk1 = GenIdealSpectra(th1,p1,fp.psel,freq,K);
                k = (nev-1)*Ns + ns;
                subplot(Nev,Ns,k);
                dsdz = (sk1-sk0)/dz;
                plot(freq,dsdz/max(abs(dsdz)),'k',freq,sk0/max(sk0),'r');%,freq,sk1,'r');
                ylim([-1 1]);
                if nev == Nev
                    xlabel('Freq (Hz)');
                end
                if ns == 1
                    ylabel(sprintf('dS/de_%d',evnum(nev)));
                end
                if nev == 1
                    title(sprintf('Subj %d',fp.indx_s(subj(ns))));
                end
            end
        end    
    case 11 % time series eeg plots
        PlotEEGBase2(fp);       
        
    case 12 % pairwise histogram plots
        PlotPairDist(fp);
    case 13 % plot synoptic eigendirection components
        PlotEigenDirn(fp,4,0.20);
    case 14 % Gaussian derivatives
        A = 1;
        f0 = 10;
        a = 1;
        freq =  fp.freq(fp.indx_f);
        S = A*exp(-0.5*a*(freq-f0).^2);
        dSdf0 = a*(freq - f0).*S;
        dSdA = S/A;
        dSda = -0.5*S.*(freq - f0).^2;
        dsdf0 = dSdf0/max(abs(dSdf0));
        dsdA = dSdA/max(abs(dSdA));
        dsda = dSda/max(abs(dSda));
        figure(fp.figbase),clf;
        subplot(3,1,1);
        plot(freq,S/A,'--r','LineWidth',2); hold on;plot(freq,dsdf0,'k');hold off;       
        hold off;
        ylabel('dS/df0');
        subplot(3,1,2);
        plot(freq,S/A,'--r','LineWidth',2); hold on;plot(freq,dsdA,'k');hold off;
        %plot(freq,dsdA,'k',freq,S/A,'--r');
        ylabel('dS/dA');
        subplot(3,1,3);
        plot(freq,S/A,'--r','LineWidth',2); hold on;plot(freq,dsda,'k');hold off;        
        ylabel('dS/da');
        xlabel('Frequency (Hz)');
    case 15 % direction cosine magnitudes
        PlotEigenDirn(fp,6);
    case 16 % correlation coefficients
        pairs = PlotCorrCoeff(fp,4);
        Ns = length(fp.subjects);
        fb = fp.figbase + Ns;
        subjs = fp.subjects;
        for n = (1:Ns)
            fp.pairs = pairs{n};
            fp.figbase = fb + (n-1);
            fp.subjects = subjs(n);
            PlotPairDist(fp);            
        end
            
        
end

        
        
        
        

