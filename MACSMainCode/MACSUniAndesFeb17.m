%% First: initialize communication between hardware components and computer
% Initalize Micro-manager
% MACS ACQUISITION PROGRAM
% AUTHORS:
% Juan Arias   -- ju-aria1@uniandes.edu.co
% Luis Gutierrez -- la.gutierrez1280@uniandes.edu.co
% Carlos Sanchez -- ca.sanchez1209@uniandes.edu.co
%% READ BEFORE USE
% 1. Calibrate the constants in the script declareConstants with the manual
% program first, especially the T_FILL_GC_TO_PT and the times of flow from
% the cleaning tubes to the PT.
% 2. The pressures MUST be kept fixed throughout the experiment after the
% calibration.
% 3. When you call a function for MACS control, you must call allOff() after
% it if you want the valves to be turned off after the time you entered.
% 4. If you want to abort a valve status before the entered time, press
% Ctrl+C and run allOff() immediately.
% 5. The order in which the cells are run is the following
%   a. declareConstants
%   b. loadMicroscope
%   c. setMicroscopePropertiesHama
%   d. loadDaq.
%   e. setExperimentInfo().
%   f. setMicroscopePropertiesBeforeSnap;
%      T_INITIAL = clock;
%       This starts the clock, so it must be run when the GC measurement is
%       started, or record the time at which the GC is when this cell is
%       run.
%   g. Presnapping
% After these steps, the setup is ready for the image taking.
% When you run the cell 
%% Luis Gutierrez Updates
%   2016-SEP-2 
%       Created functions for the different valve states.
%   2016-SEP-16
%        Improvements for the functions and definitions of variables and
%        constants, a pause was added, the time enters as a parameter.
%   2017-JAN-19 
%       Changed macs to global variable instead of setting it as a parameter.
%       Tested if the import statement in loadMicroscope can be called
%       inside a function and the result was negative. It must be a script
%       since the variable mmc is global.
%       Tested if for the function setStageSpeed the argument val must be
%       integer or it can be float. It must be an integer between 1 and 9.
%       The exception was added to the function.
%   2017-FEB-15 
%       Added ocumentation to the declareConstants script with explanations
%       for all the constants.
%       Added a READ BEFORE USE section at the beginning with instructions
%       and clarifications
%       Test of the new prompt and directory creation layout done it
%       december 22. Succesful.
%       Test of all the microscope functions, their exception handling and
%       their documentation. All were successfully tested except
%       setObjective, loadDaq.
%   2017-FEB-17
%       T_ INITIAL defined inside setExperimentInfo instead of in main
%       after setMicroscopePropertiesBeforeSnap.
%       In setExperimentInfo there is another text box in the prompt with
%       the label 'Time difference with LabView (min)' and this time
%       difference is saved in the Info file.
%       Added M.date with hours, minutes and seconds. In the filenames and
%       the directories created at the beginning of each experiment the
%       time of the day is included to avoid overwriting of experiments
%       done in the same day.
%       Added data files for each experiment, they are tdata and tanalysis.
%       Both contain four columns t_gc_pt_i, t_gc_pt_f, t_snaps_i and
%       t_snaps_f. In tdata they are given in the format mm-ss-fff and in
%       tanalysis in minutes.
%       Added data files for each time folder (set of snaps), they are
%       snapdata and snapanalysis. They have four columns, t_rfp_snap,
%       t_rfp_exp, t_gfp_snap, t_gfp_exp with the time for each rfp and gfp
%       snap from the beginning of the experiment (exp) and from the
%       beginning of the current snap series (snap). The format is
%       mm-ss-fff for snapdata and in minutes for snapanalysis.
%   TODO
%       Test the remaining functions: setObjective and loadDaq
%       Write the documentation an organized document including the
%       directory format and the data files format.
%       Test everything in the Microscope PC and with the MACS connected.
%% DATE: 2017-FEB-17
%% Declare constants
declareConstants;
%% Microscope CORE
loadMicroscope;
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
setEpiShutter(0);
%% Perfect Focus ON
setPfs(1);
%% Initialize the NI-DAQ board and the 10 of 12 pins available
loadDaq;
%% MACS FILE INFO about experiment, Read position list and create directory
% WHEN YOU CLICK OK, THE EXPERIMENT TIME STARTS COUNTING.
setExperimentInfo;

filename_tf = [prefix, M.time,'_',M.media, '_', M.strain,'_tfriendly.csv'];
filename_ta = [prefix, M.time,'_',M.media, '_', M.strain,'_tanalysis.csv'];

file_tf = fopen(filename_tf, 'w');  % times in a friendly format (mm-ss-fff)
file_ta = fopen(filename_ta, 'w');  % times for analysis (mins)

t_header = {'t_gc_pt_i', 't_gc_pt_f', 't_snaps_i', 't_snaps_f'};

fprintf(f_tf, '%s,', t_header{1:end-1});
fprintf(f_tf, '%s\n', t_header{end});

fprintf(f_ta, '%s,', t_header{1:end-1});
fprintf(f_ta, '%s\n', t_header{end});
%% GENERAL SETTINGS BEFORE START SNAPPING
setMicroscopePropertiesBeforeSnap;
%% Prepare MACS for snapping
t_gc_pt_i = etime(clock, T_INITIAL);
fprintf(file_ta, '%s,', t_gc_pt_i/60);
fprintf(file_tf, '%s,', secs2msf(t_gc_pt_i));

preSnapping(T_FILL_GC_TO_PT, T_PT_TO_W2, T_CHIP_PRESNAP);

t_gc_pt_f = etime(clock, T_INITIAL);
fprintf(file_ta, '%s,', t_gc_pt_f/60);
fprintf(file_tf, '%s,', secs2msf(t_gc_pt_f));
%% MACSing with snapping images 
M.t0 = clock; % Initial time of the snap series.

t_snaps_i = etime(clock, T_INITIAL);
fprintf(file_ta, '%s,', t_snaps_i/60);
t_snaps_i_str = secs2msf(t_snaps_i);
fprintf(file_tf, '%s,', t_snaps_i_str);

prefix_img = [prefix, t_snaps_i_str, '/'];
mkdir_message = mkdir(prefix_img);

filename_sf = [prefix_img, t_snaps_i_str, '_snapfriendly.csv'];
filename_sa = [prefix_img, t_snaps_i_str, '_snapanalysis.csv'];

file_sf = fopen(filename_sf, 'w'); %Times for each snap in a friendly format
file_sa = fopen(filename_sa, 'w'); %Times for each snap in minutes

s_header = {'t_rfp_snap', 't_rfp_exp', 't_gfp_snap', 't_gfp_exp'};

fprintf(file_sf, '%s,', s_header{1:end-1});
fprintf(file_sf, '%s\n', s_header{end});

fprintf(file_sa, '%s,', s_header{1:end-1});
fprintf(file_sa, '%s\n', s_header{end});

N_SNAPS = 2;
for i=1:N_SNAPS
    
    display(['Snap ', num2str(i),' out of ', num2str(N_SNAPS)]) 
    tic
    %Moving stage
    pn = 1;
    X_n = M1.position(pn).X{1};
    Y_n = M1.position(pn).Y{1};
    mmc.setXYPosition('TIXYDrive', X_n, Y_n)
    mmc.waitForDevice('TIXYDrive')
    
    pause(1);
    
    % TODO: SEE IF THAT IS THE ISSUE, CHANGING THE PFS AND POSITION BEFORE
    % EACH SNAP COULD BE CHANGING THE FOCUS AND THAT MAY BE THE CAUSE OF
    % THE PROBLEM WE WERE HAVING
    
    mmc.setProperty('TIPFSOffset','Position',num2str(M1.position(pn).PFSOffset{1}));
    mmc.waitForDevice('TIPFSOffset')
    
    mmc.isContinuousFocusEnabled();
    mmc.setProperty('TIPFSStatus','State','On');
    mmc.enableContinuousFocus(1);
    mmc.waitForDevice('TIPFSStatus');
    %pause(5);
    
    %mmc.waitForDevice('TIPFSStatus')
    
    %UNCOMMENT HERE WHEN TESTS ARE COMPLETE
    %macsingSnap(T_PT_TO_CHIP, T_ACCUMULATING, T_MACSING );
    
   %  mmc.enableContinuousFocus(1)
      
     %pause(0.1)
    
    %-------------------snap RFP 
    
    M.imageDir = prefix_img; % change the directory
    
    %     for i=1:5 % this is for focus adjustment only
    mmc.setProperty('TIFilterBlock1','Label','4-G-2Ec') % Set RED Filter
    mmc.setProperty('TIEpiShutter','State','1') % Open Epi Shutter
    
    filename_1 = [M.imageDir, M.strain, '_t001xy', num2str(i), 'c1', '.tif'];
    filename_2 = [M.imageDir, M.strain, '_t001xy', num2str(i), 'c2', '.tif'];
    mmc.setExposure(400); %in ms
    mmc.snapImage; %acquire a single image
    
    t_rfp_snap = etime(clock, M.t0);
    t_rfp_exp = etime(clock, T_INITIAL);
    fprintf(file_sa, '%s,', t_rfp_snap/60);
    fprintf(file_sf, '%s,', secs2msf(t_rfp_snap));
    
    fprintf(file_sa, '%s,', t_rfp_exp/60);
    fprintf(file_sf, '%s,', secs2msf(t_rfp_exp));
    
    RFP = flipdim(rot90(reshape(typecast(mmc.getImage,'uint16'), [mmc.getImageWidth, mmc.getImageHeight])),1);
    figure(),imshow(RFP,[]);
    ti_min = etime(clock, M.t0)/60; %calculate the timestamp in minutes
    display('timestamp');
    display(num2str(ti_min));
    imwrite(RFP, filename_1, 'tiff','Compression','none','Description',...
        ['Timestamp_min = ',num2str(ti_min),', Acquired at ',num2str(datestr(now))]);
    imwrite(RFP, filename_2, 'tiff','Compression','none','Description',...
        ['Timestamp_min = ',num2str(ti_min),', Acquired at ',num2str(datestr(now))]);
    pause(1);
    mmc.setProperty('TIEpiShutter','State','0') % Close Epi Shutter
        %end  % this is for focus adjustment only
    
    pause(2);
    
    %-------------------snap GFP
%     
    %     for i=1:5 % this is for focus adjustment only
    
    mmc.setProperty('TIFilterBlock1','Label','3-B-2Ec') % Set GREEN Filter
    mmc.setProperty('TIEpiShutter','State','1')
    filename_3 = [M.imageDir, M.strain, '_t001xy', num2str(i), 'c3', '.tif'];
    mmc.setExposure(800); %in ms
    mmc.snapImage; %acquire a single image
    
    t_gfp_snap = etime(clock, M.t0);
    t_gfp_exp = etime(clock, T_INITIAL);
    
    fprintf(file_sa, '%s,', t_gfp_snap/60);
    fprintf(file_sf, '%s,', secs2msf(t_gfp_snap));
    
    fprintf(file_sa, '%s\n', t_gfp_exp/60);
    fprintf(file_sf, '%s\n', secs2msf(t_gfp_exp));
    
    GFP = flipdim(rot90(reshape(typecast(mmc.getImage,'uint16'), [mmc.getImageWidth, mmc.getImageHeight])),1);
    figure(),imshow(GFP,[]);
    imwrite(GFP, filename_3, 'tiff','Compression','none','Description',...
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
  
    %UNCOMMENT HERE WHEN TESTS ARE COMPLETE
    %cleanFov(T_CLEAN_FOV, N_CLEAN_FOV);
    display('clean fov test');
    
    
    close all
    toc
    x=2;
    %x = (M.TimeBetweenSnaps*60-toc);
    pause(x);
end

t_snaps_f = etime(clock, T_INITIAL);
fprintf(file_ta, '%s\n', t_snaps_f/60);
fprintf(file_tf, '%s\n', secs2msf(t_snaps_f));

%UNCOMMENT HERE WHEN TESTS ARE COMPLETE
%ptToW2(T_WASTE_FINAL);
%allOff();
pause(3);

display('Snaps DONE')
%clearvars -except mmc
fclose(file_sf);
fclose(file_sa);
%% Cleaning Protocol 0 Bleach
cleanBleach(N_CLEAN_BLEACH, T_FILL_BLEACH, T_WAIT_BLEACH, T_WASTE_BLEACH);
%% Cleaning Protocol 1 Ethanol
cleanEthanol(N_CLEAN_ETHANOL, T_FILL_ETHANOL, T_WAIT_ETHANOL, T_WASTE_ETHANOL);
%% Cleaning Protocol 2 MilliQ
cleanMilliq(N_CLEAN_MILLIQ, T_FILL_MILLIQ, T_WAIT_MILLIQ, T_WASTE_MILLIQ, T_PT_TO_W2, T_CHIP_CLEANING);
%% Cleaning Protocol 3 Final
cleanFinal(4, T_W1, 20, 2, T_WASTE_FINAL);
%% RUN ONLY AT THE END OF THE EXPERIMENT TO CLOSE FILES
fclose( f_ta );
fclose( f_tf );