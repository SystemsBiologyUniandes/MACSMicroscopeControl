function cleanMilliq(n, tFill, tWait, tWaste, tptToW2, tChip)
%CLEANMILLIQ Does the cleaning protocol for Ethanol. 
%   CLEANMILLIQ(n, tFill, tWait, tWaste, tptToW2, tChip)
%       Sends MilliQ to PT with a time of tFill.
%       Waits for a time of tWait.
%       Sends from PT to W2 for a time of tWaste.
%       Repeats n times.
%       Sends MilliQ to PT with a time of tFill.
%       Waits for a time of tWait.
%       Sends from PT to W2 for a time of tCloser.
%       Sends from PT to Chip for a time of tChip/3.
%       cleanFov 5 times with 0.2 seconds each
%       Sends from PT to Chip with a time of 2*tChip/3.
%       Sends residual to W2 for a time of tWaste.
%       Turns all valves off.
        
    for i=1:n
        milliq(tFill);
        allOff();
        pause(tWait);
        ptToW2(tWaste);
        allOff();
        pause(2);
    end
    display('Cleaning MilliQ pt. 1 Done')
    milliq(tFill);
    allOff();
    pause(tWait);
    ptToW2(tptToW2);
    ptToChip(tChip/3);
    
    cleanFov(0.2, 5);
    
    ptToChip(2*tChip/3);
    ptToW2(tWaste);
    allOff();
    
    display('Cleaning MilliQ Done')
end


