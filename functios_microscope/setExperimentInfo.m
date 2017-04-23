% SETEXPERIMENTINFO Prompt for experiment information.
%   SETEXPERIMENTINFO Prompt for experiment information and saves it in a
%   text file with name and directory defined in output_filename.
%   experimentInfo_'date'_'user'.txt.
%   After the user clicks OK, the experiment time starts to count. Keep in
%   mind to compare it with the time of the OD LabView program.
%   The directory where images are saved is created according to the
%   variable prefix.
global M;

% Uncomment and replace for multiple positions
%labels = {'User','Media (e.g. M3)','Strain (e.g. JAC33-12)','Positions','Objective Magnification (10, 40, 60, 100)x','Lens Magnification (1 or 1.5)x', 'Binning', 'Time difference with LabView (min)'};
%default_answer = {'Luis', 'M5', 'JAC51-0','1', '100','1.5','2', '0'};
%output_prompt = inputdlg(labels,'Experiment Info', [1 30; 1 30; 1 30; 1 30 ; 1 30; 1 30; 1 30], default_answer);
labels = {'User','Media (e.g. M3)','Strain (e.g. JAC33-12)','Objective Magnification (10, 40, 60, 100)x','Lens Magnification (1 or 1.5)x', 'Binning', 'Time difference with LabView (min)'};
default_answer = {'Luis', 'M3', 'JAC33-175', '100','1.5','2', '0'};
output_prompt = inputdlg(labels,'Experiment Info', [1 30; 1 30; 1 30 ; 1 30; 1 30; 1 30; 1 30], default_answer); 

% Set the initial time of the experiment. 
global T_INITIAL;
T_INITIAL = clock;

M.time = datestr(now,'yyyy-mm-dd_HH-MM-SS');
M.user = cell2mat(output_prompt(1));
M.media = cell2mat(output_prompt(2));
M.strain = cell2mat(output_prompt(3));
% Uncomment and replace for multiple positions
%M.totalPositions = str2double(cell2mat(output_prompt(4)));
M.totalPositions = 1;%  le cambie esto pq lo deshabilitaron en la interfaz...
M.time_difference = cell2mat(output_prompt(7));
cMount = 0.7;
cam_pixel_size = 0.0645;

% Info file saving
system_prefix = 'C:/Users/Juan Arias/Desktop/MACS/'; %(Microscope PC)
%system_prefix = '~/Desktop/MACS/'; % (Ubuntu)

% Creates directory for the images
global prefix;
prefix = [system_prefix, M.user,'/', M.strain, '/',M.time, '/'];

mkdir_message = mkdir(prefix);
output_filename = strcat(prefix, 'experimentInfo_',M.time,'_',M.user,'_', M.strain,'.txt');
output_file = fopen(output_filename,'w');
output_format = '%s\t%s\n';
[ncols,nrows] = size(output_prompt);
for row = 1:ncols
    fprintf(output_file,output_format,labels{row}, output_prompt{row});
end
fprintf(output_file, output_format, 'cMount',num2str(cMount));
fprintf(output_file, output_format, 'Camera Pixel Size (um)',num2str(cam_pixel_size));
fclose(output_file);

%open(output_filename);

% Read the position list
global M1;
Position = M.totalPositions;
M.rootDir='C:\Users\Juan Arias\Desktop\MACS\Position List (DO NOT DELETE)\';
M1 = readPositionList9(M);
%M1 = readPositionList10(M);
M1.position(1) %check if the position list reading worked correctly

