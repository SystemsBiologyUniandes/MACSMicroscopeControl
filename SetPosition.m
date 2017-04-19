function SetPosition(n)
global mmc
global M1
global M
global filenamered
global filenamegreen
%     for pn = 1:Position
        
    X_n = M1.position(n).X{1};
    Y_n = M1.position(n).Y{1};
%     X_n = M1.position(n);
%     Y_n = M1.position(n);
    mmc.setXYPosition('TIXYDrive',X_n,Y_n)
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
    M.rootDirRFP = ['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(n),'\RFP\']; % change the directory
    M.imageDirRFP = [M.rootDirRFP];
    
    %     for i=1:5 % this is for focus adjustment only  
        
    filenamered = [M.imageDirRFP,'\RFP', num2str(n+10000), '.tif'];
    
     M.rootDirGFP = ['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(n),'\GFP\']; % change the directory
 
     M.imageDirGFP = [M.rootDirGFP];

    filenamegreen = [M.imageDirGFP, '\GFP', num2str(n+10000), '.tif'];
    
end