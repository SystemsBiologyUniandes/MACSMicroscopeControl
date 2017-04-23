function gcToPt(t)
%GCTOPT Sends from GC to PT.
%   GCTOPT(t) Sends from GC to PT for t seconds.
    global macs;
    outputSingleScan(macs,[0 0 0 1,  0 0 0 1,  0 1 0 0]);
    %display('GC to PT');
    pause(t);
end