% SETMICROSCOPEPROPERTIESHAMA Set all microscope properties.
%   SETMICROSCOPEPROPERTIESHAMA Set all microscope properties to the
%   following values:
%       Camera: Hamamatsu.
%       Shutter: TIEpiShutter.
%       TIRF mirror: Out.
%       Binning: 2x2.
%       Contrast gain: 0.
% Note: do this only at the beginnig of the experiment; set later as few
% properties as possible to keep the code fast.

%mmc.setProperty('Core','Camera','Andor')%default camera is the Andor iXon Ultra | DU897_BV | 7876 |
mmc.setProperty('Core','Camera','HamamatsuHam_DCAM')%Camera Hamamatsu ORCA-R2
mmc.setProperty('Core','Shutter','TIEpiShutter') %default shutter is TIEpiShutter
%mmc.setProperty('Core','AutoShutter','1')
%mmc.setProperty('TITIRF','Mirror','In') %Epi Out - TIRF In
mmc.setProperty('TITIRF','Mirror','Out') %Epi In - TIRF Out

%For Hamamatsu

mmc.setProperty('HamamatsuHam_DCAM','Binning','2x2') %set binning
mmc.setProperty('HamamatsuHam_DCAM','CONTRAST GAIN','0') %set gain
%mmc.setProperty('HamamatsuHam_DCAM','CCDTemperatureSetPoint','-90') %set temp of camera chip to -90

display('Hamamatsu is Ready');
display('Hamamatsu Binning 2x2');
display('Hamamatsu CONTRAST GAIN 0');

