function cleanMilliq(n, tFill, tWait, tWaste, tPtToW2, tChip)
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
    display('Cleaning MilliQ');   
    for i=1:n
        display(['    Pt 1: Cycle ', num2str(i),' of ',  num2str(n+1)]);
        milliq(tFill);
        allOff();
        pause(tWait/5);
        ptToW2(tWaste);
        allOff();
    end
    
    display(['    Pt 1: Cycle ', num2str(n+1),' of ',  num2str(n+1)]);
    milliq(tFill);
    allOff();
    pause(tWait);
    ptToW2(tWaste);
    allOff();
    
    t_total = tFill + tWait+tPtToW2+tChip+5*1+5*0.2+tWaste;
    display('    Pt 2: Sending MilliQ through chip, ');
    display(['        ', num2str(t_total/60), ' min remaining']);
    milliq(tFill);
    allOff();
    pause(tWait);
    ptToW2(tPtToW2);
    ptToChip(tChip/3);
    %Define with Juan
    cleanFov(1, 5);
    cleanFov(0.2, 5);
    display(['    ', num2str((2*tChip/3+tWaste)/60), ' min remaining']);
    ptToChip(2*tChip/3);
    display(['    ', num2str(tWaste), ' sec remaining']);
    ptToW2(tWaste);
    allOff();
    display('    Cleaning MilliQ Done')
end


