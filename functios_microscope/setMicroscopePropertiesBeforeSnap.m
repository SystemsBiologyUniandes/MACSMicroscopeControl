% SETMICROSCOPEPROPERTIESBEFORESNAP Set the microscope properties just
% before start snapping.
%   SETMICROSCOPEPROPERTIESBEFORESNAP Set the microscope properties as
%   desired: The light path, the stage speed and the condenser. Turns off an emergent warning. 

%LIGHTPATH
%setLightPath('Eye');
setLightPath('Hamamatsu');
%setLightPath('Andor');

%STAGE SPEED 
setStageSpeed(1);

%INFORMATION
% mmc.getXPosition('TIXYDrive') 
% mmc.getYPosition('TIXYDrive') 
% mmc.setPosition('TIXYDrive',M.position(1))

%OBJECTIVE
%mmc.setProperty('TINosePiece','Label','3-Plan Fluor 10x NA 0.30 Dry'); %10x Objective
%mmc.setProperty('TINosePiece','Label','6-Apo TIRF 100x NA 1.49 Oil'); %100x Objective

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