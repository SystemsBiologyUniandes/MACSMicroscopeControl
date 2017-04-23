function macsingSnap(tPtToChip, tAccumulating, tMacsing )
%MACSINGSNAP Prepare cells before snapping. 
%   MACSINGSNAP(tPtToChip, tAccumulating, tMacsing ) Does the
%   following:
%       Sends from PT to CHIP with a time of tPtToChip.
%       Accumulates with a time of tAccumulating.
%       Trap cells with a time of tMacsing, which is the waiting time
%       before the snap
    ptToChip(tPtToChip);
    accumulate(tAccumulating);
    macsing(tMacsing);
    %display('Macsing for Snaps done');
end


