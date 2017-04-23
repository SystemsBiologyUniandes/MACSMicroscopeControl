function allOff()
%ALLOFF Turns all valves off.
%   ALLOFF() Turns all valves off.
    global macs
    outputSingleScan(macs,[0 0 0 0,  0 0 0 0,  0 0 0 0]);
    %display('OFF');
end