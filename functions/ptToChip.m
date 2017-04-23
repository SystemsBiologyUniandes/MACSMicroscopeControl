function ptToChip(t)
%PTTOCHIP Sends from PT to Chip.
%   PTTOCHIP(t) Sends from PT to Chip for t seconds.
    global macs;
    outputSingleScan(macs,[0 0 0 0,  0 0 1 0,  0 0 0 0]);
    %display('PT to Chip');
    pause(t);
end