function rbs35(t)
%ETHANOL Sends ethanol to PT.
%   ETHANOL(t) Sends ethanol to PT for t seconds.
    global macs;
    outputSingleScan(macs,[0 1 0 0,  0 0 0 0,  0 0 0 0]);
    display('rbs35');
    pause(t);
end