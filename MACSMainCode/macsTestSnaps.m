%MACSTESTSNAPS
%   MACSTESTSNAPS Starts the snaps for testing.

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

N_SNAPS = 5;
for i=1:N_SNAPS
    
    display(['Snap ', num2str(i),' out of ', num2str(N_SNAPS)]) 
    tic
    %Moving stage
    
    %UNCOMMENT MAR 14
%     pn = 1;
%     X_n = M1.position(pn).X{1};
%     Y_n = M1.position(pn).Y{1};
%     mmc.setXYPosition('TIXYDrive', X_n, Y_n)
%     mmc.waitForDevice('TIXYDrive')
    
    pause(1);
    
    % TODO: SEE IF THAT IS THE ISSUE, CHANGING THE PFS AND POSITION BEFORE
    % EACH SNAP COULD BE CHANGING THE FOCUS AND THAT MAY BE THE CAUSE OF
    % THE PROBLEM WE WERE HAVING
    
    %mmc.setProperty('TIPFSOffset','Position',num2str(M1.position(pn).PFSOffset{1}));
    %mmc.waitForDevice('TIPFSOffset')
    
    %mmc.isContinuousFocusEnabled();
    
    %%NCOMMENTED MAR 14
    %mmc.setProperty('TIPFSStatus','State','On');
    
    %mmc.enableContinuousFocus(1);
    %mmc.waitForDevice('TIPFSStatus');
    %pause(5);
    
    %mmc.waitForDevice('TIPFSStatus')
    
    %UNCOMMENT HERE WHEN TESTS ARE COMPLETE
    macsingSnap(T_PT_TO_CHIP, T_ACCUMULATING, T_MACSING );
    
   %  mmc.enableContinuousFocus(1)
      
    pause(4)
    
    %-------------------snap RFP 
    
    M.imageDir = prefix_img; % change the directory
    
    %     for i=1:5 % this is for focus adjustment only
    mmc.setProperty('TIFilterBlock1','Label','4-G-2Ec') % Set RED Filter
    mmc.setProperty('TIEpiShutter','State','1') % Open Epi Shutter
    
    filename_1 = [M.imageDir, M.strain, '_t001xy', num2str(i), 'c1', '.tif'];
    filename_2 = [M.imageDir, M.strain, '_t001xy', num2str(i), 'c2', '.tif'];
    mmc.setExposure(250); %in ms
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
    cleanFov(T_CLEAN_FOV, N_CLEAN_FOV);
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
display('Snaps DONE')
%clearvars -except mmc
fclose(file_sf);
fclose(file_sa);