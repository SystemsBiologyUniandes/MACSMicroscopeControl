function ptToW2(t)
%PTTOW2 Sends from PT to W2.
%   PTTOW2(t) Sends from PT to W2 for t seconds.
    global macs;
    outputSingleScan(macs,[0 0 0 0,  0 0 1 0,  1 0 0 0]);
    display('PT to W2');
    pause(t);
end