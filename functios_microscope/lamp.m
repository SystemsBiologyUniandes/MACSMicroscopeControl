function lamp( val, intensity )
%LAMP Turns the TI DiaLamp ON or OFF
%   LAMP(val, intensity) If val == 'on' turns on the lamp, otherwise it
%   goes off.
global mmc

if strcmp(val, 'on')
    mmc.setProperty('TIDiaLamp','State','1')
    mmc.setProperty('TIDiaLamp','Intensity', intensity)
else
    mmc.setProperty('TIDiaLamp','State','0')

end


