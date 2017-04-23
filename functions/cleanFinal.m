function cleanFinal(n, tW1, tFill, tWait, tWaste)
%CLEANFINAL Does the cleaning protocol after completing the measurements. 
%   CLEANFINAL(n, tW1, tFill, tWait, tWaste)
%       Sends from GC to W1 with a time of tW1.
%       Sends from GC to PT with a time of tFill.
%       Waits for a time of tWait.
%       Sends from PT to W2 for a time of tWaste.
%       Turns all valves off.
%       Repeats n times.
    display('Cleaning final');
    for i=1:n
        display(['    Cycle ', num2str(i),' of ',  num2str(n+1)]);
        gcToW1(tW1);
        allOff();
        gcToPt(tFill);
        allOff();
        pause(tWait/5);
        ptToChip(tWaste);
        allOff();
    end
    
    display(['    Cycle ', num2str(n+1),' of ',  num2str(n+1)]);
    gcToW1(tW1);
    allOff();
    gcToPt(tFill);
    allOff();
    pause(tWait);
    ptToChip(tWaste);
    allOff();
    display('    Cleaning Final Done')
end




