function PlotEEGBase2(fp)
%
%   PlotEEGBase2(fparam)
%
%   Plot the model and data time series
%   filtered between 2 and 20 Hz
%
%   uses the array fp.subjects to determine the subject numbers (1 to 82) to plot
%

Hd = BPFilterBase;
param = fp.prm(1);
psel = fp.psel;
record_c = fp.record_c;
thk = fp.thk;
subjs = fp.subjects;

Ns = length(subjs);
Npages = floor(Ns/6)+1;
Nxtra = mod(Ns,6);
if Nxtra == 0
    Npages = Npages-1;
end

for pg = (1:Npages)
    figure(fp.figbase+pg-1),clf;
    for plt = (1:6)
        ss = (Npages-1)*6 + plt;
        if ss > Ns
            break;
        end
        p = UpdateParam(param,thk(:,subjs(ss)),psel);
        p.gamma_ie = p.gamma_ii;
        p.gamma_ei = p.gamma_ee;
        [x,t] = IdealEEG(p,160,10,Hd);
        y = record_c{fp.indx_s(subjs(ss))}(1:length(t));%/std(record_c{fp.indx_s(subjs(ss))}(1:length(t)));
        
        subplot(3,2,plt);        
        plot(t-4,2+y/std(y),'r');%record_c{fp.indx_s(subjs(ss))}(1:length(t))/std(record_c{fp.indx_s(subjs(ss))}(1:length(t))),'r')
        hold on;
        plot(t-4,-2+x/std(x),'k');
        hold off;
        axis([0 4 -5 5]); % display the signals from 4 to 8 sec to avoid filter artefacts
        if plt > 4
            xlabel('Time (s)');
        end
        if mod(plt,2)
            ylabel('EEG');
        end
        title(sprintf('Subject %d',fp.indx_s(subjs(ss))));        
    end
end
