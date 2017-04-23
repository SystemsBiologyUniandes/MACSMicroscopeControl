function accumulate(t)
%ACCUMULATE Accumulates cells in FOV by turning on both control and flow
%valves
%   ACCUMULATE(t) Accumulates for t seconds.
    global macs;
    outputSingleScan(macs,[0 0 0 0,  0 1 1 0,  0 0 0 0]);
    %display('Accumulating');
    pause(t);
end