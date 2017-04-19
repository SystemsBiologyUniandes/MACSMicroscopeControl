function M = readPositionList9(M)
%
% READPOSITIONLIST8 works with version 3 of the Micro-manager XY-position
% list. DL 08/16/2010
%
% Edit this file again to implement changes of MM 1.3.46_20100817
%
% READPOSITIONLIST6 reads the Micro-Manager position list file and extracts 
% all relevant parameters about the different positions (e.g. XYZ 
% coordinates and PFSOffset). The values are stored in the position field of the
% structure M. 
% Each position has a status flag. The position is active if M.position.status = 1. 
% This allows to stop imaging positions if certain conditions are meet or not meet
% (e.g. position is drifting too much).
% DL 06/25/2009
%
% READPOSITIONLIST7 checks if M.totalpositions and the number of postions in the Micro-manager
% position list file are the same. Matlab throws an error if this is not true.
% DL 09/10/2009
%
% READPOSITIONLIST7 reads the Z value and the PFS offset correct. Something
% changed here. Pretty wired!!!! DL 09/10/2009
%
%update for 9 (Nate):  added a break command in the second 'i' loop to make sure that we 
%don't double write a position-- i.e., that we don't accidentally write the
%pos19 data into pos1. 

M.positionFile = [M.rootDir,'PositionList.pos']; 

%Throw error if position list file is not there
if exist(M.positionFile,'file') == 0 
   display('PositionList.pos file does not exist or is in the wrong directory.');
end


fid = fopen(M.positionFile,'r'); %open file in read-only mode

%Read line-by-line into the cell data
a = 1;
tline = 0;
%clear data ;
while 1
    tline = fgetl(fid); %returns the next line of the read file
    if (tline) == -1 %end of file
        break
    end
    data{a} = tline; %data contains content of MMPositonList.pos file
    %every entry corresponds to one line of the position list file
    a = a +1; %next line
end
data(end) = []; %get rid of the last line
fclose(fid) ; %closes the open file

%Determine the number of different positions
text_pos='"LABEL":';
p=1;

%Get the postion label
for i=1:size(data,2) %loop through the lines of the data cell
    if ( findstr(char(cellstr(data(i))),text_pos) )  
        pos_line = strread(char(cellstr(data(i))),'%s') ;
        pos(p).label = char(cellstr(pos_line(2))) ; %gets the position label
        pos(p).label = pos(p).label(2:end-2); %eliminates the quotation marks
        
        %include a flag for every position
        pos(p).status = 1; %all positions start in the active status
        
        p=p+1; %update the postion index
        %ZPositionMatrix = [ ZPositionMatrix ; Z ];       
    end
end

%Get all values for the first position
for k=1:length(pos) %loop over all positions
    
    for i=1:size(data,2)                
        if findstr(char(cellstr(data(i))),pos(k).label)
           pos_line = strread(char(cellstr(data(i))),'%s') ;
           pos(k).X = strread(char(cellstr(data(i-6))),'%s') ;
           pos(k).X = {str2double(pos(k).X(2))};
           pos(k).Y = strread(char(cellstr(data(i-7))),'%s') ;
           pos(k).Y = {str2double(pos(k).Y(2))};
           %pos(k).Z = strread(char(cellstr(data(i-20))),'%s') ; %Comment for MACS
           %pos(k).Z = {str2double(pos(k).Z(2))}; %Comment for MACS
           pos(k).PFSOffset = strread(char(cellstr(data(i-13))),'%s') ;
           pos(k).PFSOffset = {str2double(pos(k).PFSOffset(2))}; 
           break; %makes sure we don't double write a position (NL). 
        end
    end
end

M.position = pos;

%Check if M.totalPositons equals the number of positions in the Micro-manager position list file
if length(M.position) ~= M.totalPositions
   error('M.totalPositions is not correct. The number of postions in the postion file has to equal M.totalPostions.');
end


