%% MACSing with snapping images
%Start Repeat for i times:   
%preSnapping(macs, T_FILL_GC_TO_PT, T_PT_TO_W2, T_CHIP_PRESNAP);
infoTest;
M.t0 = clock;
N_SNAPS = 5;
for i=1:N_SNAPS
    tic
    
    %-------------------snap RFP
    %TODO ADD TIME (INDEX) SO THAT IT DOES NOT OVERWRITE FOLDER    
    M.rootDir = prefix; % change the directory
    M.imageDir = [M.rootDir];
    %TODO SUPERSEGGER NAME
    
    filename = [M.imageDir,M.strain,'_t001xy',num2str(i),'c1.txt'];
    Segmentation = strcat('Segmentation',num2str(i));
    ti_min = etime(clock, M.t0)/60; %calculate the timestamp in minutes
    fileID = fopen(filename, 'w');
    fprintf(fileID, '%s\n', Segmentation);
    fclose(fileID);
    
    filename = [M.imageDir,M.strain,'_t001xy',num2str(i),'c2.txt'];
    RFP = strcat('RFP',num2str(i));
    fileID = fopen(filename, 'w');
    fprintf(fileID, '%s\n', RFP);
    fclose(fileID);
      
    %-------------------snap GFP
    %TODO SUPERSEGGER NAME
    filename = [M.imageDir,M.strain,'_t001xy',num2str(i),'c3.txt'];
    display(filename);
    GFP = strcat('GFP',num2str(i));
    fileID = fopen(filename, 'w');
    fprintf(fileID, '%s\n', GFP);
    fclose(fileID);
   
    num2str(i),toc
    x=2;
    %x = (M.TimeBetweenSnaps*60-toc);
    %pause(x);
end
display('Snaps DONE')
%clearvars -except mmc
%To cancel process CONTROL+C