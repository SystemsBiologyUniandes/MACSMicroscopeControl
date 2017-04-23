function preSnapping(tGcToPt, tPtToW2, tCellsCloser )
%PRESNAPPING Prepare cells before snapping. 
%   PRESNAPPING(tGcToPt, tPtToW2, tCellsCloser) Does the following:
%       Sends from GC to PT with a time of tGcToPt.
%       Turns all valves off with a time of 2 seconds.
%       Sends from PT to W2 with a time of tPtToW2.
%       Sends from PT to Chip with a time of tCellsCloser.
    display('Presnapping')
    gcToPt(tGcToPt);
    allOff();
    pause(4);
    ptToW2(tPtToW2);
    display(['    ', num2str(tCellsCloser/60), ' min remaining']);
    ptToChip(tCellsCloser);
    display('    Presnapping done');
end

