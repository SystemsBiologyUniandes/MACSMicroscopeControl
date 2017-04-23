function gcToW1(t)
%GCTOW1 Sends cells to W1.
%   GCTOW1(t) Sends cells to W1 for t seconds.
    global macs;
    outputSingleScan(macs,[0 0 0 1,  0 0 0 0,  0 1 0 0]);
    %display('W1');
    pause(t);
end