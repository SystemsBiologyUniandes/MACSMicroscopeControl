function PFS( val )
global mmc

if strcmp(val,'On')
mmc.setProperty('TIPFSStatus','State','On');

elseif strcmp(val,'Off')
mmc.setProperty('TIPFSStatus','State','Off');

end

end

