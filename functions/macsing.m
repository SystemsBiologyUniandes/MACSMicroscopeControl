function macsing(t)
%MACSING Turns the control pressure on.
%   MACSING(t) Sends from GC to PT for t seconds.
    global macs;
    outputSingleScan(macs,[0 0 0 0,  0 1 0 0,  0 0 0 0]);
    display('Macsing');
    pause(t);
end
    