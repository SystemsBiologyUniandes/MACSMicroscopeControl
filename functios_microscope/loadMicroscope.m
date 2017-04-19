%LOADMICROSCOPE Loads the microscope.
%   LOADMICROSCOPE Loads the microscope according to the uncommented 
%   configuration file (default: config_filename_hama
config_filename_hama = 'C:\Program Files (x86)\Micro-Manager-1.4\MMConfigHamamatsu_May_24_2016.cfg';
%config_filename_andor = 'C:\Program Files (x86)\Micro-Manager-1.4\MMConfigAndor_August_25_2015.cfg';
global mmc;
import mmcorej.*;
mmc = CMMCore;
mmc.loadSystemConfiguration (config_filename_hama);
display('Nikon Eclipse Ti is ready to be used');
