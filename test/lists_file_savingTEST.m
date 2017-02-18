setExperimentInfoTEST;

t_list_friendly = {};
t_list_analysis = {};

filename_tlist = [prefix, M.time,'_',M.media, '_', M.strain,'_tdata.csv'];
filename_tlist_analysis = [prefix, M.time,'_',M.media, '_', M.strain,'_tanalysis.csv'];

f_tlist = fopen(filename_tlist, 'w');
f_tlist_analysis = fopen(filename_tlist_analysis,'w');

t_list_header = {'t_gc_to_pt_i', 't_gc_to_pt_f', 't_snaps_i', 't_snaps_f'};

fprintf(f_tlist, '%s,', t_list_header{1:end-1});
fprintf(f_tlist, '%s\n', t_list_header{end});

fprintf(f_tlist_analysis, '%s,', t_list_header{1:end-1});
fprintf(f_tlist_analysis, '%s\n', t_list_header{end});
%% GENERAL SETTINGS BEFORE START SNAPPING
%setMicroscopePropertiesBeforeSnap;
%% Prepare MACS for snapping
t_i_gc_pt = etime(clock, T_INITIAL);
fprintf(f_tlist_analysis, '%s,', t_i_gc_pt/60);

t_i_gc_pt_str = secs2msf(t_i_gc_pt);
fprintf(f_tlist, '%s,', t_i_gc_pt_str);

%OJO
pause(1);
%preSnapping(T_FILL_GC_TO_PT, T_PT_TO_W2, T_CHIP_PRESNAP);

t_f_gc_pt = etime(clock, T_INITIAL);
fprintf(f_tlist_analysis, '%s,', t_f_gc_pt/60);

t_f_gc_pt_str = secs2msf(t_f_gc_pt);
fprintf(f_tlist, '%s,', t_f_gc_pt_str);
%% MACSing with snapping images
%Start Repeat for i times:   

M.t0 = clock;

t0_sec_full = etime(clock, T_INITIAL);
fprintf(f_tlist_analysis, '%s,', t0_sec_full/60);

t0_str = secs2msf(t0_sec_full);
fprintf(f_tlist, '%s,', t0_str);

prefix_img = [prefix, t0_str, '/'];
mkdir_message = mkdir(prefix_img);

f_snap = fopen([prefix_img, t0_str, '-snapdata.csv'], 'w');
f_snap_analysis = fopen([prefix_img, t0_str, '-snapanalysis.csv'], 'w');

snap_header = {'t_rfp_snap', 't_rfp_exp', 't_gfp_snap', 't_gfp_exp'};

fprintf(f_snap, '%s,', snap_header{1:end-1});
fprintf(f_snap, '%s\n', snap_header{end});

fprintf(f_snap_analysis, '%s,', snap_header{1:end-1});
fprintf(f_snap_analysis, '%s\n', snap_header{end});

N_SNAPS = 2;
for i=1:N_SNAPS
    
    display(['Snap ', num2str(i),' out of ', num2str(N_SNAPS)]) 
    tic
    
    %Moving stage
    %OJO
%     pn = 1;
%     X_n = M1.position(pn).X{1};
%     Y_n = M1.position(pn).Y{1};
%     mmc.setXYPosition('TIXYDrive', X_n, Y_n)
%     mmc.waitForDevice('TIXYDrive')
    
    pause(1);
    
    % TODO: SEE IF THAT IS THE ISSUE, CHANGING THE PFS AND POSITION BEFORE
    % EACH SNAP COULD BE CHANGING THE FOCUS AND THAT MAY BE THE CAUSE OF
    % THE PROBLEM WE WERE HAVING
    
    %OJO
%     mmc.setProperty('TIPFSOffset','Position',num2str(M1.position(pn).PFSOffset{1}));
%     mmc.waitForDevice('TIPFSOffset')
%     
%     mmc.isContinuousFocusEnabled();
%     mmc.setProperty('TIPFSStatus','State','On');
%     mmc.enableContinuousFocus(1);
%     mmc.waitForDevice('TIPFSStatus');
    %pause(5);
    
    %mmc.waitForDevice('TIPFSStatus')
    
    %UNCOMMENT HERE WHEN TESTS ARE COMPLETE
    %macsingSnap(T_PT_TO_CHIP, T_ACCUMULATING, T_MACSING );
    display('macsing test');
     
   %  mmc.enableContinuousFocus(1)
      
     %pause(0.1)
    
    %-------------------snap RFP
    %TODO ADD TIME (INDEX) SO THAT IT DOES NOT OVERWRITE FOLDER    
    
    M.imageDir = prefix_img; % change the directory
    
    %     for i=1:5 % this is for focus adjustment only
    %OJO
%     mmc.setProperty('TIFilterBlock1','Label','4-G-2Ec') % Set RED Filter
%     mmc.setProperty('TIEpiShutter','State','1') % Open Epi Shutter
    
    %TODO SUPERSEGGER NAME
    filename_1 = [M.imageDir, M.strain, '_t001xy', num2str(i), 'c1', '.tif'];
    filename_2 = [M.imageDir, M.strain, '_t001xy', num2str(i), 'c2', '.tif'];
    %OJO
%     mmc.setExposure(400); %in ms
%     mmc.snapImage; %acquire a single image

    %NEWWW  
    t_rfp_snap_sec = etime(clock, M.t0);
    t_rfp_exp_sec = etime(clock, T_INITIAL);
    
    fprintf(f_snap_analysis, '%s,', t_rfp_snap_sec/60);
    fprintf(f_snap, '%s,', secs2msf(t_rfp_snap_sec));
    
    fprintf(f_snap_analysis, '%s,', t_rfp_exp_sec/60);
    fprintf(f_snap, '%s,', secs2msf(t_rfp_exp_sec));
    
%     RFP = flipdim(rot90(reshape(typecast(mmc.getImage,'uint16'), [mmc.getImageWidth, mmc.getImageHeight])),1);
%     figure(),imshow(RFP,[]);
    ti_min = etime(clock, M.t0)/60; %calculate the timestamp in minutes
    display('timestamp');
    display(num2str(ti_min));
    
    
    
    
    %OJO
%     imwrite(RFP, filename_1, 'tiff','Compression','none','Description',...
%         ['Timestamp_min = ',num2str(ti_min),', Acquired at ',num2str(datestr(now))]);
%     imwrite(RFP, filename_2, 'tiff','Compression','none','Description',...
%         ['Timestamp_min = ',num2str(ti_min),', Acquired at ',num2str(datestr(now))]);
    pause(1);
    
    %OJO
%     mmc.setProperty('TIEpiShutter','State','0') % Close Epi Shutter
        %end  % this is for focus adjustment only
    
    pause(2);
    
    %-------------------snap GFP
%     
    %     for i=1:5 % this is for focus adjustment only
    
    %OJO
%     mmc.setProperty('TIFilterBlock1','Label','3-B-2Ec') % Set GREEN Filter
%     mmc.setProperty('TIEpiShutter','State','1')

    filename_3 = [M.imageDir, M.strain, '_t001xy', num2str(i), 'c3', '.tif'];
    %OJO
%     mmc.setExposure(800); %in ms
%     mmc.snapImage; %acquire a single image

    %NEWWW  
    t_gfp_snap_sec = etime(clock, M.t0);
    t_gfp_exp_sec = etime(clock, T_INITIAL);
    
    fprintf(f_snap_analysis, '%s,', t_gfp_snap_sec/60);
    fprintf(f_snap, '%s,', secs2msf(t_gfp_snap_sec));
    
    fprintf(f_snap_analysis, '%s\n', t_gfp_exp_sec/60);
    fprintf(f_snap, '%s\n', secs2msf(t_gfp_exp_sec));
    
%     GFP = flipdim(rot90(reshape(typecast(mmc.getImage,'uint16'), [mmc.getImageWidth, mmc.getImageHeight])),1);
%     figure(),imshow(GFP,[]);
%     imwrite(GFP, filename_3, 'tiff','Compression','none','Description',...
%         ['Timestamp_min = ',num2str(ti_min),', Acquired at ',num2str(datestr(now))]);
    
    pause(1)
    %OJO
%     mmc.setProperty('TIEpiShutter','State','0') % Close Epi Shutter
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
    
    %OJO
%     mmc.isContinuousFocusEnabled();
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

tf_sec_full = etime(clock, T_INITIAL);
fprintf(f_tlist_analysis, '%s\n', tf_sec_full/60);

tf_str = secs2msf(tf_sec_full);
fprintf(f_tlist, '%s\n', tf_str);
%UNCOMMENT HERE WHEN TESTS ARE COMPLETE
%ptToW2(T_WASTE_FINAL);
%allOff();
display('w2 test');
pause(3);

display('Snaps DONE')
%clearvars -except mmc
%To cancel process CONTROL+C

%NEWWWW
fclose(f_snap);
fclose(f_snap_analysis);
%% RUN ONLY AT THE END OF THE EXPERIMENT TO CLOSE FILES
fclose( f_tlist );
fclose( f_tlist_analysis );