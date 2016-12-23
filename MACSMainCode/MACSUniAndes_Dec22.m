%% First: initialize communication between hardware components and computer
% Initalize Micro-manager
% MACS ACDQUISITION PROGRAM
% AUTHOR:
% Juan Arias   -- ju-aria1@uniandes.edu.co
% Carlos Sanchez -- ca.sanchez1209@uniandes.edu.co
% Luis Gutierrez -- la.gutierrez1280@uniandes.edu.co
%% UPDATE
% Luis Alberto Gutierrez Lopez
% 2_SEP_2016 Functions for the different states
% 16_NOV_2016 Improvements for the functions and definitions of variables and constants.
% To abort press Ctrl C and run allOff(macs)
%
% Juan Arias - Luis Gutierrez
% 3_DEC_2016 Improvements for the functions and saving options.
%
% Luis Gutierrez
% (TO BE TESTED) 19_DEC_2016 Changed macs to global variable instead of 
% setting it as a parameter.
% (TBT) 22_DEC_2016 Changed microscope functions names, added documentation
% and exception handling.
%   TODO: Check if the import statement in loadMicroscope can be called 
%   inside a function or if it should be run as a script instead.
%   TODO: For setStageSpeed check if val must be integer or can be float
%   between 1 and 9.
% (TBT) 22_DEC_2016 Changed the prompt setup for the experiment info and
% the directory creation format to have less subdirectories.
%   TODO: Check if there is a problem having just one position and not ask
%   for it.
% %%%%%%%%%%%%%%%
% DATE: 2016-DEC-22
%% Declare constants
%TODO
%DEFINE TIME BETWEEN SNAPS AND USE IT TO DEFINE SNAPS TIMES, DECIDE IF IN
%THE DIALOG OR IN THE SCRIPT
declareConstants;
%% Microscope CORE
config_filename_hama = 'C:\Program Files (x86)\Micro-Manager-1.4\MMConfigHamamatsu_May_24_2016.cfg';
config_filename_andor = 'C:\Program Files (x86)\Micro-Manager-1.4\MMConfigAndor_August_25_2015.cfg';
loadMicroscopeHama(config_filename_hama);
%% Unload microscope
unloadMicroscope;
%% Set all microscope properties
setMicroscopePropertiesHama;
%% EYE BF
setFilter('Analy');
setLampStatus(1,3);
setLightPath('Eye');
%% EYE RFP
setFilter('GREEN');
setLampStatus(0);
setLightPath('Eye');
%%TODO see what to do with escape issue does not do PFS and set the objective 
setEpiShutter(0);
%% Perfect Focus ON
SetPfs(1);
%% Initialize the NI-DAQ board and the 10 of 12 pins available
loadDaq;
%% MACS FILE INFO about experiment, Read position list and create directory
setExperimentInfo;
%% GENERAL SETTINGS BEFORE START SNAPPING
setMicroscopePropertiesBeforeSnap;
%% Prepare MACS for snapping
preSnapping(macs, T_FILL_GC_TO_PT, T_PT_TO_W2, T_CHIP_PRESNAP);
%% MACSing with snapping images
%Start Repeat for i times:   

%preSnapping(macs, T_FILL_GC_TO_PT, T_PT_TO_W2, T_CHIP_PRESNAP);

M.t0 = clock;
N_SNAPS = 50;
for i=1:N_SNAPS
    tic
    %Moving stage
    %pn = 1;
    for pn = 1:Position
        
    X_n = M1.position(pn).X{1};
    Y_n = M1.position(pn).Y{1};
    mmc.setXYPosition('TIXYDrive', X_n, Y_n)
    mmc.waitForDevice('TIXYDrive')
    
    pause(1);
    
    mmc.setProperty('TIPFSOffset','Position',num2str(M.position(pn).PFSOffset{1}));
    mmc.waitForDevice('TIPFSOffset')
    
    mmc.isContinuousFocusEnabled();
    mmc.setProperty('TIPFSStatus','State','On');
    mmc.enableContinuousFocus(1);
    mmc.waitForDevice('TIPFSStatus');
    %pause(5);
    
    %mmc.waitForDevice('TIPFSStatus')
    
    macsingSnap( macs, T_PT_TO_CHIP, T_ACCUMULATING, T_MACSING )
     
   %  mmc.enableContinuousFocus(1)
      
     %pause(0.1)
    
    %-------------------snap RFP
    %TODO ADD TIME (INDEX) SO THAT IT DOES NOT OVERWRITE FOLDER    
    M.rootDirRFP = ['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(pn),'\RFP\']; % change the directory
    M.imageDirRFP = [M.rootDirRFP];
    
    %     for i=1:5 % this is for focus adjustment only  
        
    mmc.setProperty('TIFilterBlock1','Label','4-G-2Ec') % Set RED Filter
    mmc.setProperty('TIEpiShutter','State','1') % Open Epi Shutter
    %TODO SUPERSEGGER NAME
    filename = [M.imageDirRFP,'\RFP', num2str(i+10000), '.tif'];
    mmc.setExposure(400); %in ms
    mmc.snapImage; %acquire a single image
    RFP = flipdim(rot90(reshape(typecast(mmc.getImage,'uint16'), [mmc.getImageWidth, mmc.getImageHeight])),1);
    figure(),imshow(RFP,[]);
    ti_min = etime(clock, M.t0)/60; %calculate the timestamp in minutes
    imwrite(RFP, filename, 'tiff','Compression','none','Description',...
        ['Timestamp_min = ',num2str(ti_min),', Acquired at ',num2str(datestr(now))]);
    pause(1);
    mmc.setProperty('TIEpiShutter','State','0') % Close Epi Shutter
        %end  % this is for focus adjustment only
    
    pause(2);
    
    %-------------------snap GFP
%     
    M.rootDirGFP = ['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(pn),'\GFP\']; % change the directory

    M.imageDirGFP = [M.rootDirGFP];

    %     for i=1:5 % this is for focus adjustment only
    
    mmc.setProperty('TIFilterBlock1','Label','3-B-2Ec') % Set GREEN Filter
    mmc.setProperty('TIEpiShutter','State','1')
    filename = [M.imageDirGFP, '\GFP', num2str(i+10000), '.tif'];
    mmc.setExposure(800); %in ms
    mmc.snapImage; %acquire a single image
    GFP = flipdim(rot90(reshape(typecast(mmc.getImage,'uint16'), [mmc.getImageWidth, mmc.getImageHeight])),1);
    figure(),imshow(GFP,[]);
    imwrite(GFP, filename, 'tiff','Compression','none','Description',...
        ['Timestamp_min = ',num2str(ti_min),', Acquired at ',num2str(datestr(now))]);
    pause(1)
    mmc.setProperty('TIEpiShutter','State','0') % Close Epi Shutter
    %     end  % this is for focus adjustment only
   
    pause(2);
    
%     %-------------------snap BF
%     
%     M.rootDirBF = ['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(pn),'\BF\']; % change the directory
% 
%     M.imageDirBF = [M.rootDirBF];
%     
%     %     for i=1:5 % this is for focus adjustment only
%     
%     mmc.setProperty('TIFilterBlock1','Label','1-ANALY') % Set Bright Field Filter
%     %mmc.setProperty('TIFilterBlock1','Label','2-UV2Ec') % Set RED Filter
%     mmc.setProperty('TIDiaLamp','State','1')% Turn ON lamp
%     mmc.setProperty('TIDiaLamp','Intensity','5') % Lamp intensity
%     mmc.setProperty('TIEpiShutter','State','1')% Open Epi Shutter
%     filename = [M.imageDirBF,'\BF_', num2str(i),'_POS_',num2str(pn),'_Time',num2str((i-1)*M.TimeBetweenSnaps), 'min', '.tif'];
%     mmc.setExposure(50); %in ms
%     mmc.snapImage; %acquire a single image
%     mmc.setProperty('TIDiaLamp','State','0')
%     BF = flipdim(rot90(reshape(typecast(mmc.getImage,'uint16'), [mmc.getImageWidth, mmc.getImageHeight])),1);
%     figure(),imshow(BF,[]);
%     %imwrite(BF, filename, 'tiff','Compression','none','Description',...
%         ['Timestamp_min = ',num2str(ti_min),', Acquired at ',num2str(datestr(now))]);
%     pause(1)
%     mmc.setProperty('TIEpiShutter','State','0') % Close Epi Shutter
%     %     end  % this is for focus adjustment only
%    
%     pause(5);
    
    mmc.isContinuousFocusEnabled();
    %mmc.setProperty('TIPFSStatus','State','Off');
    %mmc.enableContinuousFocus(0); 
  
    cleanFov(macs, T_CLEAN_FOV, N_CLEAN_FOV);
    
    close all
    num2str(i),toc
    x=2;
    %x = (M.TimeBetweenSnaps*60-toc);
    pause(x); 
    end
end
ptToW2(macs, T_WASTE_FINAL);
allOff(macs);
display('Snaps DONE')
%clearvars -except mmc
%To cancel process CONTROL+C
%%
%% Cleaning Protocol 0 Bleach
cleanBleach(macs, N_CLEAN_BLEACH, T_FILL_BLEACH, T_WAIT_BLEACH, T_WASTE_BLEACH);
%% Cleaning Protocol 1 Ethanol
cleanEthanol(macs, N_CLEAN_ETHANOL, T_FILL_ETHANOL, T_WAIT_ETHANOL, T_WASTE_ETHANOL);
%% Cleaning Protocol 2 MilliQ
cleanMilliq(macs, N_CLEAN_MILLIQ, T_FILL_MILLIQ, T_WAIT_MILLIQ, T_WASTE_MILLIQ, T_PT_TO_W2, T_CHIP_CLEANING);
%% Cleaning Protocol 3 Final
cleanFinal(macs, 4, T_W1, 20, 2, T_WASTE_FINAL);
%% Cleaning Protocol 3 Final
milliq(macs,12)
allOff(macs)
ptToW2(macs,30)
allOff(macs)