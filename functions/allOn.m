function allOn()
%ALLON Turns all valves on.
%   ALLON() Turns all valves on.
    global macs;
    outputSingleScan(macs,[1 1 1 1,  1 1 1 1,  1 1 1 1]);
    %display('ON');
end