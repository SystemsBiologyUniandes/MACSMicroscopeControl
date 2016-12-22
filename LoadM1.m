global M1
global M

outputfile = inputdlg({'User','Experiment Name','Positions','Time Between Snaps(min)','Objective Magnification (10, 40, 60, 100)x','Lens Magnification (1 or 1.5)x', 'Binning', 'C Mount', 'Camera pixel size (um)'},...
              'MM DAT', [1 30; 1 30; 1 30; 1 30 ; 1 30; 1 30; 1 30; 1 30; 1 30]); 
         
M.date = datestr(datenum([date]),'yyyymmdd'); %get the date in the form e.g. 20080205
M.experimentName = cell2mat(outputfile(2)); %infirmation about the experiment
M.user = cell2mat(outputfile(1)); %user name
M.totalPositions = str2num(cell2mat(outputfile(3)));%position per lane
M.TimeBetweenSnaps =  str2num(cell2mat(outputfile(4))); %Time between consecutive snaps

% Read the position list
Position = M.totalPositions;
M.rootDir=['C:\Users\Juan Arias\Desktop\MACS\Position List (DO NOT DELETE)\'];
M1 = readPositionList9(M);
%M = readPositionList10(M);
M1.position(1) %check if the position list reading worked correctl

for i=1:Position
    
    mkdirRFP = mkdir(['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(i),'\RFP\']); %folder for the images RFP
    mkdirGFP = mkdir(['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(i),'\GFP\']);%folder for the images GFP
    %mkdirBF = mkdir(['C:\Users\Juan Arias\Desktop\MM\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(i),'\BF\']);%folder for the images BFP

end
