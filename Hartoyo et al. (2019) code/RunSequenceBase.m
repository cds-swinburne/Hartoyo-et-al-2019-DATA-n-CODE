function RunSequenceBase(S,freq,param,dev,psel,mparam)
%
%   RunSequenceBase(S,freq,param,dev,psel,mparam)
%
%   Run MCMCBase on the specra in S
%   S is the spectral array
%   freq is the array of frequencies
%   param is the starting parameter structure array (param(1) = starting
%   point; param(2) = mean value structure for priors)
%   dev is the dviation array
%   psel is the selection array
%   mparam uses ptype structure
%

global wb_handle;
[Ns,~] = size(S);

for n = (1:Ns)
    tfile = sprintf('ThetaFileBaseWN%d.mat',n+mparam.offset);
    th = MCMCBase(S(n,:),freq,param,dev,psel,mparam);
    if isempty(th)
        if ~isempty(wb_handle)
            delete(wb_handle);
            wb_handle = [];
        end        
        return;
    end
    save(tfile,'th');
end


