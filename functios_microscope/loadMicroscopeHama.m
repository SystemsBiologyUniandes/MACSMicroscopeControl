%Microscope CORE
global mmc;
import mmcorej.*;
mmc = CMMCore;
mmc.loadSystemConfiguration ('C:\Program Files (x86)\Micro-Manager-1.4\MMConfigHamamatsu_May_24_2016.cfg');
%mmc.loadSystemConfiguration ('C:\Program Files (x86)\Micro-Manager-1.4\MMConfigAndor_August_25_2015.cfg');
display('Nikon Eclipse Ti is ready to be used');