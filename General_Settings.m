% GENERAL SETTINGS BEFORE START SNAPPING

%LIGHTPATH
%mmc.setProperty('TILightPath','Label','1-Eye100') % Eye LightPath
mmc.setProperty('TILightPath','Label','2-Left100'); % Hamamatsu Camera LightPath
%mmc.setProperty('TILightPath','Label','3-Right100'); % Andor Camera LightPath


%STAGE SPEED 
mmc.setProperty('TIXYDrive','SpeedX',1); %Stage Speed in X default is 1 (max), 9 is min.
mmc.setProperty('TIXYDrive','SpeedY',1); %Stage Speed in Y default is 1 (max), 9 is min.
%mmc.setProperty('TIXYDrive','SpeedY',9) %Stage Speed in Z default is 1 (max), 9 is min.
% mmc.setXYPosition('TIXYDrive',0,0)

%INFORMATION
% mmc.getXPosition('TIXYDrive') 
% mmc.getYPosition('TIXYDrive') 
% mmc.setPosition('TIXYDrive',M.position(1))

%OBJECTIVE
%mmc.setProperty('TINosePiece','Label','3-Plan Fluor 10x NA 0.30 Dry'); %10x Objective

mmc.setProperty('TINosePiece','Label','6-Apo TIRF 100x NA 1.49 Oil'); %100x Objective

%CONDENSER

%mmc.setProperty('TICondenserCassette','Label','2-DICN1'); %10x Objective
mmc.setProperty('TICondenserCassette','Label','3-DICN2'); %100x Objective

% Turn off this warning "Warning: Image is too big to fit on screen; displaying at 33% "
% To set the warning state, you must first know the message identifier for the one warning you want to enable. 
% Query the last warning to acquire the identifier.  For example: 
% warnStruct = warning('query', 'last');
% messageID = warnStruct.identifier
% messageID =
%    MATLAB:concatenation:integerInteraction
warning('off', 'Images:initSize:adjustingMag');