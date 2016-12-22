% UNLOADMICROSCOPE Unloads the microscope.
%   UNLOADMICROSCOPE Unloads the microscope and cleans the workspace.
mmc.unloadAllDevices();
mmc.reset();
clear mmc;
%clear all;
display('MMCore is unloaded.');