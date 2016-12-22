% MACS FILE INFO 
global M;

labels = {'User','Media','Strain','Positions','Objective Magnification (10, 40, 60, 100)x','Lens Magnification (1 or 1.5)x', 'Binning'};
outputfile = inputdlg(labels,'MACS Info', [1 30; 1 30; 1 30; 1 30 ; 1 30; 1 30; 1 30]); 
         
M.date = datestr(datenum([date]),'yyyymmdd'); %get the date in the form e.g. 20080205
M.user = cell2mat(outputfile(1)); %user name
M.media = cell2mat(outputfile(2)); %infirmation about the experiment
M.strain = cell2mat(outputfile(3));
M.totalPositions = str2num(cell2mat(outputfile(4)));%position per lane

cMount = 0.7;
cam_pixel_size = 0.0645;
%Info file
%TODO Save with good name (date, strain, etc)
fileID = fopen('MACS_info.txt','w');
formatSpec = '%s\t%s\n';

[ncols,nrows] = size(outputfile);
for row = 1:ncols
    fprintf(fileID,formatSpec,labels{row}, outputfile{row});
end

fprintf(fileID, formatSpec, 'cMount',num2str(cMount));
fprintf(fileID, formatSpec, 'Camera Pixel Size (um)',num2str(cam_pixel_size));
fclose(fileID);
open 'MACS_info.txt'
