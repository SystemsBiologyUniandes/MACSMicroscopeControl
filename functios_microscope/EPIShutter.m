function EPIShutter( val )

global mmc

if strcmp(val,'Open')
 mmc.setProperty('TIEpiShutter','State','1')

elseif strcmp(val,'Close')
mmc.setProperty('TIEpiShutter','State','0')

end

