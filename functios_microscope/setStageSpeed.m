function setStageSpeed(val)
% SETSTAGESPEED Set the speed of the stage.
%   SETSTAGESPEED(val) Set the speed of the stage according to the value of
%   val. Stage speed in X and Y default is 1 (max), 9 is min.
%   Throws an error if val is not an integer between 1 and 9
    global mmc;
    if ismember(val,1:9)
        mmc.setProperty('TIXYDrive','SpeedX',val); 
        mmc.setProperty('TIXYDrive','SpeedY',val);
    else
        error('val must be an integer between 1 and 9');
    end
end
