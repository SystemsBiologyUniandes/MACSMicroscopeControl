%% MACSing with snapping images

M.t0 = clock;
%Start Repeat for i times:   

for i=1:50
    tic
    %Moving stage

    %pn = 1;
    for pn = 1:Position
        
    X_n = M.position(pn).X{1};
    Y_n = M.position(pn).Y{1};
    mmc.setXYPosition('TIXYDrive', X_n, Y_n)
    mmc.waitForDevice('TIXYDrive')
    
    pause(1);
    
   % mmc.setProperty('TIPFSOffset','Position',num2str(M.position(pn).PFSOffset{1}));
    %mmc.waitForDevice('TIPFSOffset')
     
    mmc.isContinuousFocusEnabled();
    mmc.setProperty('TIPFSStatus','State','On');
    mmc.enableContinuousFocus(1);
    mmc.waitForDevice('TIPFSStatus');
    %pause(5);
    
    %mmc.waitForDevice('TIPFSStatus')
    
    PTtoCHIP(MACS);
    pause(2) 
    ACCUMULATE(MACS);
    pause(2)       
    TRAP_CELLS(MACS);      
    pause(2) 
     
   %  mmc.enableContinuousFocus(1)
      
     %pause(0.1)
    
    %-------------------snap RFP
            
    M.rootDirRFP = ['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(pn),'\RFP\']; % change the directory

    M.imageDirRFP = [M.rootDirRFP];
    
    %     for i=1:5 % this is for focus adjustment only  
        
    mmc.setProperty('TIFilterBlock1','Label','4-G-2Ec') % Set RED Filter
    mmc.setProperty('TIEpiShutter','State','1') % Open Epi Shutter
    filename = [M.imageDirRFP,'\RFP', num2str(i+10000), '.tif'];
    mmc.setExposure(50); %in ms
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
%     M.rootDirGFP = ['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(pn),'\GFP\']; % change the directory
% 
%     M.imageDirGFP = [M.rootDirGFP];
% 
%     %     for i=1:5 % this is for focus adjustment only
%     
%     mmc.setProperty('TIFilterBlock1','Label','3-B-2Ec') % Set GREEN Filter
%     mmc.setProperty('TIEpiShutter','State','1')
%     filename = [M.imageDirGFP, '\GFP', num2str(i+10000), '.tif'];
%     mmc.setExposure(100); %in ms
%     mmc.snapImage; %acquire a single image
%     GFP = flipdim(rot90(reshape(typecast(mmc.getImage,'uint16'), [mmc.getImageWidth, mmc.getImageHeight])),1);
%     figure(),imshow(GFP,[]);
%     ti_min = etime(clock, M.t0)/60; %calculate the timestamp in minutes
%     imwrite(GFP, filename, 'tiff','Compression','none','Description',...
%         ['Timestamp_min = ',num2str(ti_min),', Acquired at ',num2str(datestr(now))]);
%     pause(1)
%     mmc.setProperty('TIEpiShutter','State','0') % Close Epi Shutter
%     %     end  % this is for focus adjustment only
%    
%     pause(2);
    
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
%     ti_min = etime(clock, M.t0)/60; %calculate the timestamp in minutes
%     imwrite(BF, filename, 'tiff','Compression','none','Description',...
%         ['Timestamp_min = ',num2str(ti_min),', Acquired at ',num2str(datestr(now))]);
%     pause(1)
%     mmc.setProperty('TIEpiShutter','State','0') % Close Epi Shutter
%     %     end  % this is for focus adjustment only
%    
%     pause(5);
    
    mmc.isContinuousFocusEnabled();
    %mmc.setProperty('TIPFSStatus','State','Off');
    %mmc.enableContinuousFocus(0); 
%     
%    ACCUMULATE(MACS);     
%   pause(3)         
%    PTtoCHIP(MACS);
%    pause(2)   
%    ALL_OFF(MACS);
%       
    close all
    num2str(i),toc
    x=2;
    %x = (M.TimeBetweenSnaps*60-toc);
    pause(x); 
    end
end
ALL_OFF(MACS);
display('Snaps DONE')
%clearvars -except mmc
%To cancel process CONTROL+C