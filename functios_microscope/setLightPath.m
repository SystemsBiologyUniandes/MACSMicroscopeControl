function setLightPath(val)
% SETLIGHTPATH Set the light path.
%   SETLIGHTPATH(val) Set the light path according to the value of val. The
%   correct values are 'Eye', 'Hamamatsu' and 'Andor' (case insensitive).
%   Throws error if other string is used.
    global mmc;

    if strcmpi(val,'Eye')
        mmc.setProperty('TILightPath','Label','1-Eye100'); % Eye LightPath

    elseif strcmpi(val,'Hamamatsu')
        mmc.setProperty('TILightPath','Label','2-Left100'); % Eye LightPath

    elseif strcmpi(val,'Andor')
        mmc.setProperty('TILightPath','Label','3-Right100'); % Eye LightPath
    else
        error('val must be Eye, Hamamatsu, or Andor');
    end
end

