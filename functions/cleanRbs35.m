function cleanRbs35(n, tFill, tWait, tWaste)
%CLEANRBS35 Does the cleaning protocol for Ethanol. 
%   CLEANRBS35(n, tFill, tWait, tWaste)
%       Sends Ethanol to PT with a time of tFill.
%       Waits for a time of tWait.
%       Sends from PT to W2 for a time of tWaste.
%       Repeats n times.
    display('Clean RBS 35');
    for i=1:n
        display(['    Cycle ', num2str(i),' of ',  num2str(n+1)]);
        rbs35(tFill);
        allOff();
        pause(tWait/5);
        ptToW2(tWaste);
        allOff();
    end
    display(['    Cycle ', num2str(n+1),' of ',  num2str(n+1)]);
    rbs35(tFill);
    allOff();
    pause(tWait);
    ptToW2(tWaste);
    allOff();
    display('    Clean RBS 35 Done')
end


