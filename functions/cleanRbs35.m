function cleanRbs35(n, tFill, tWait, tWaste)
%CLEANETHANOL Does the cleaning protocol for Ethanol. 
%   CLEANETHANOL(n, tFill, tWait, tWaste)
%       Sends Ethanol to PT with a time of tFill.
%       Waits for a time of tWait.
%       Sends from PT to W2 for a time of tWaste.
%       Repeats n times.
    for i=1:n
        rbs35(tFill);
        ptToW2(tWaste);
        allOff();
        pause(2);
    end
    display('Cleaning RBS 35 Done')
    rbs35(tFill);
    allOff();
    pause(tWait);
    ptToW2(tWaste);
    allOff();
    pause(2);
end


