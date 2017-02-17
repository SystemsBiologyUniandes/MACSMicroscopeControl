function setEpiShutter( val )
% SETEPISHUTTER Set the EPI shutter status.
%   SETEPISHUTTER(val) Turns the EPI shutter on or off if val == 1 or val
%   == 0, respectively.
%   Throws error if other value is used.
global mmc

if val == 1
    mmc.setProperty('TIEpiShutter','State','1');

elseif val == 0
    mmc.setProperty('TIEpiShutter','State','0');
else
    error('val must be either 0 or 1 for off or on, respectively');
end

end

