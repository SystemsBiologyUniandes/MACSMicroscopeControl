function LightPath( val )
global mmc

if strcmp(val,'Eye')
mmc.setProperty('TILightPath','Label','1-Eye100') % Eye LightPath

elseif strcmp(val,'Hamamatsu')
mmc.setProperty('TILightPath','Label','2-Left100') % Eye LightPath

elseif strcmp(val,'Andor')
mmc.setProperty('TILightPath','Label','3-Right100') % Eye LightPath

end
end

