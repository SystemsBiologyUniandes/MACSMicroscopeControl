function setLampStatus(val, intensity)
%SETLAMPSTATUS Turns the TI DiaLamp on or off and sets its intensity
%   SETLAMPSTATUS(val, intensity) The lamp is turned on if val == 1 and off
%   if val == 0. When turned on the intensity is set according to the value
%   of intensity (both are integers).
%   If val != 1 or val !=0 throws an error.

    global mmc

    if val == 1
        mmc.setProperty('TIDiaLamp','State','1');
        mmc.setProperty('TIDiaLamp','Intensity', intensity);
    elseif val == 0
        mmc.setProperty('TIDiaLamp','State','0');
    else
        error('val must be either 1 or 0 for on or off, respectively');
    end
end


