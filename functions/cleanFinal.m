function cleanFinal(n, tW1, tFill, tWait, tWaste)
%CLEANFINAL Does the cleaning protocol after completing the measurements. 
%   CLEANFINAL(n, tW1, tFill, tWait, tWaste)
%       Sends from GC to W1 with a time of tW1.
%       Sends from GC to PT with a time of tFill.
%       Waits for a time of tWait.
%       Sends from PT to W2 for a time of tWaste.
%       Turns all valves off.
%       Repeats n times.

    gcToW1(tW1);
    allOff();
    for i=1:n
        gcToPt(tFill);
        allOff();
        pause(tWait);
        ptToW2(tWaste);
        allOff();
    end
    
    display('Cleaning Final Done')
end




