function Filter( val )
global mmc

if strcmp(val,'Analy')
mmc.setProperty('TIFilterBlock1','Label','1-ANALY') % Set BF

elseif strcmp(val,'UV')
mmc.setProperty('TIFilterBlock1','Label','2-UV2Ec') % Set UV

elseif strcmp(val,'BLUE')
mmc.setProperty('TIFilterBlock1','Label','3-B-2Ec') % Set BLUE

elseif strcmp(val,'GREEN')
mmc.setProperty('TIFilterBlock1','Label','4-G-2Ec') % Set GREEN

elseif strcmp(val,'89000')
mmc.setProperty('TIFilterBlock1','Label','5-89000') % Set 89000

end
end

