function cleanBleach(n, tFill, tWait, tWaste)
%CLEANBLEACH Does the cleaning protocol with Bleach. 
%   CLEANBLEACH(n, tFill, tWait, tWaste)
%       Sends Bleach to PT with a time of tFill.
%       Waits for a time of tWait.
%       Sends from PT to W2 for a time of tWaste.
%       Repeats n times.
    for i=1:n
        bleach(tFill);
        allOff();
        pause(tWait);
        ptToW2(tWaste);
        allOff();
        pause(2);
    end
    %display('Cleaning Bleach Done')
end