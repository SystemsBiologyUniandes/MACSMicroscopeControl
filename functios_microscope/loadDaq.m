% LOADDAQ Loads the NI-DAQ board.
%   LOADDAQ Loads the NI-DAQ board and the 10 of 12 pins available. They
%   are assigned as follows:
%       pump1 Bleach
%       pump2 Ethanol
%       pump3 MilliQ
%       pump4 GC pressure line
%       pump5 To be assigned
%       pump6 Control
%       pump7 PT pressure line
%       pump8 3 Way Valve between GC and PT
%       pump9 3 Way Valve between PT and CHIP
%       pump10 Ventilation GC
% On the matriz, 0 means OFF and 1 means ON. See the function allOff, for
% example.

daqreset;
global macs;
macs = daq.createSession('ni');
%daq.getDevices;
pumpset1 = addDigitalChannel(macs, 'dev1', 'Port0/Line0:7', 'OutputOnly');
pumpset2 = addDigitalChannel(macs, 'dev1', 'Port1/Line0:3', 'OutputOnly');

allOff();
display('DAQ is initialized.');
