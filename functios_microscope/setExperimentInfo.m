% SETEXPERIMENTINFO Prompt for experiment information.
%   SETEXPERIMENTINFO Prompt for experiment information and saves it in a
%   text file in the current directory with name format
%   experimentInfo_'date'_'user'.txt.
global M;

labels = {'User','Media','Strain','Positions','Objective Magnification (10, 40, 60, 100)x','Lens Magnification (1 or 1.5)x', 'Binning'};
default_answer = {'Luis', 'M5', 'JAC51-0','1', '100','1.5','2'};
output_prompt = inputdlg(labels,'Experiment Info', [1 30; 1 30; 1 30; 1 30 ; 1 30; 1 30; 1 30], default_answer); 
         
M.date = datestr(datenum(date),'yyyymmdd');
M.user = cell2mat(output_prompt(1));
M.media = cell2mat(output_prompt(2));
M.strain = cell2mat(output_prompt(3));
M.totalPositions = str2double(cell2mat(output_prompt(4)));

cMount = 0.7;
cam_pixel_size = 0.0645;

%Info file
output_filename = strcat('experimentInfo_',M.date,'_',M.user,'.txt');
output_file = fopen(output_filename,'w');
output_format = '%s\t%s\n';

[ncols,nrows] = size(output_prompt);
for row = 1:ncols
    fprintf(output_file,output_format,labels{row}, output_prompt{row});
end

fprintf(output_file, output_format, 'cMount',num2str(cMount));
fprintf(output_file, output_format, 'Camera Pixel Size (um)',num2str(cam_pixel_size));
fclose(output_file);

open(output_filename);

global M1;
% Read the position list
Position = M.totalPositions;
M.rootDir=['C:\Users\Juan Arias\Desktop\MACS\Position List (DO NOT DELETE)\'];
M1 = readPositionList9(M);
%M = readPositionList10(M);
M1.position(1) %check if the position list reading worked correctly

% Create directories for Image Storage
%TODO PROMPT TO DEFINE NAME OF THE CHANNELS, AND NUMBER OF CHANNELS IN
%FILE_INFO
%V1: Created directories for each channel
%prefix_v1_rfp = ['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.media,'\',...
%    M.strain,'\POS',num2str(i),'\RFP\'];
%prefix_v1_gfp = ['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.media,'\',...
%    M.strain,'\POS',num2str(i),'\GFP\'];
%for i=1:Position
    %TODO CHECK DIRECTORY HIERARCHY AND SELECT SEGMENTATION AND SIGNAL
    %1,2,3, ETC
    %mkdirRFP = mkdir(prefix_v1_rfp);
    %mkdirGFP = mkdir(prefix_v1_gfp); 
%end

% Creates directory for the images
system_prefix = 'C:/Users/Juan Arias/Desktop/MACS/';
prefix = [system_prefix, M.user, M.date, M.media, M.strain, '/'];
mkdir_message = mkdir(prefix);


