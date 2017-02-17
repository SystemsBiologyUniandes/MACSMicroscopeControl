function setPfs(val)
% SETPFS Set the perfect focus status.
%   SETPFS(val) Turns the perfect focus on or off if val == 1 or 
%   val == 0, respectively.
%   Throws error if other value is used.
    global mmc
    if val == 1
        mmc.setProperty('TIPFSStatus','State','On');

    elseif val == 0
        mmc.setProperty('TIPFSStatus','State','Off');
    else
        error('val must be either 0 or 1 for off or on, respectively');
    end

end

