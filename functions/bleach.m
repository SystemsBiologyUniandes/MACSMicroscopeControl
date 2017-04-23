function bleach(t)
%BLEACH Sends bleach to PT.
%   BLEACH(t) Sends bleach to PT for t seconds.
    global macs;
    outputSingleScan(macs,[1 0 0 0,  0 0 0 0,  0 0 0 0]);
    %display('Bleach');
    pause(t);
end