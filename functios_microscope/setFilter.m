function setFilter(val)
% SETFILTER Set the filter.
%   SETFILTER(val) Set the microscope filter according to the name given by
%   the string val. The valid names are 'Analy', 'UV', 'BLUE', 'GREEN',
%   '89000' (case insensitive).
%   Throws error if other string is used.
    global mmc;

    if strcmpi(val,'Analy')
        mmc.setProperty('TIFilterBlock1','Label','1-ANALY'); % Set BF

    elseif strcmpi(val,'UV')
        mmc.setProperty('TIFilterBlock1','Label','2-UV2Ec'); % Set UV

    elseif strcmpi(val,'BLUE')
        mmc.setProperty('TIFilterBlock1','Label','3-B-2Ec'); % Set BLUE

    elseif strcmpi(val,'GREEN')
        mmc.setProperty('TIFilterBlock1','Label','4-G-2Ec'); % Set GREEN

    elseif strcmpi(val,'89000')
        mmc.setProperty('TIFilterBlock1','Label','5-89000'); % Set 89000
    else
        error('Invalid filter, the valid filters are Analy, UV, Blue, Green and 89000');
    end
end

