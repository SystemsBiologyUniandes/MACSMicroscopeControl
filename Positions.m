% MULTIPLE POSITIONS


% Read the position list
Position = M.totalPositions;
M.rootDir=['C:\Users\Juan Arias\Desktop\MACS\Position List (DO NOT DELETE)\'];
M = readPositionList9(M);
%M = readPositionList10(M);
M.position(1) %check if the position list reading worked correctl

% Create directories for Image Storage

for i=1:Position
    
    mkdirRFP = mkdir(['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(i),'\RFP\']); %folder for the images RFP
    mkdirGFP = mkdir(['C:\Users\Juan Arias\Desktop\MACS\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(i),'\GFP\']);%folder for the images GFP
    %mkdirBF = mkdir(['C:\Users\Juan Arias\Desktop\MM\', M.user, '\', M.date, '\',M.experimentName,'\POS',num2str(i),'\BF\']);%folder for the images BFP

end