function SetStageSpeed(n)
global mmc
mmc.setProperty('TIXYDrive','SpeedX',n); %Stage Speed in X default is 1 (max), 9 is min.
mmc.setProperty('TIXYDrive','SpeedY',n)
end

