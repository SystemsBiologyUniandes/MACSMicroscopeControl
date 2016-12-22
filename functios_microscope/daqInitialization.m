%% Initialize the NI-DAQ board and the 10 of 12 pins available

daqreset
macs = daq.createSession('ni');
%daq.getDevices;
pumpset1 = addDigitalChannel(macs, 'dev1', 'Port0/Line0:7', 'OutputOnly');
pumpset2 = addDigitalChannel(macs, 'dev1', 'Port1/Line0:3', 'OutputOnly');

%pump1 Bleach
%pump2 Ethanol
%pump3 MilliQ
%pump4 GC pressure line
%pump5 TBA
%pump6 Control
%pump7 PT pressure line
%pump8 3 Way Valve between GC and PT
%pump9 3 Way Valve between PT and CHIP
%pump10 Ventilation GC

%TBA = TO BE ASSIGNED.
%On the matriz, 0 means OFF and 1 means ON. For example:

% ALL OFF
%[pump1 pump2 pump3 pump4,  pump5 pump6 pump7 pump8,  pump9 pump10 pummp11 pump12] = [0 0 0 0,  0 0 0 0,  0 0 0 0]
outputSingleScan(macs,[0 0 0 0,  0 0 0 0,  0 0 0 0]);

display('DAQ is initialized.')
