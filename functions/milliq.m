function milliq(t)
%MILLIQ Sends MilliQ to PT.
%   MILLIQ(t) Sends MilliQ to PT for t seconds.
    global macs;
    outputSingleScan(macs,[0 0 1 0,  0 0 0 0,  0 0 0 0]);
    display('MilliQ'); 
    pause(t);
end