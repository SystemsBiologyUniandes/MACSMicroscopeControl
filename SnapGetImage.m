function SnapGetImage(val,n,OD)
global M
global mmc
global filenamered
global filenamegreen

if strcmp(val,'RFP')
filenamered = [M.imageDirRFP,'\RFP', num2str(n+10000),'_',OD, '.tif'];
mmc.snapImage; %acquire a single image
    RFP = flipdim(rot90(reshape(typecast(mmc.getImage,'uint16'), [mmc.getImageWidth, mmc.getImageHeight])),1);
    figure(),imshow(RFP,[]);
    imwrite(RFP, filenamered, 'tiff','Compression','none','Description',...
        ['Timestamp_min = ',num2str(5),', Acquired at ',num2str(datestr(now))]);
    
elseif strcmp(val,'GFP')    
    filenamegreen = [M.imageDirGFP, '\GFP', num2str(n+10000),'_',OD, '.tif'];
    mmc.snapImage; %acquire a single image
     GFP = flipdim(rot90(reshape(typecast(mmc.getImage,'uint16'), [mmc.getImageWidth, mmc.getImageHeight])),1);
     figure(),imshow(GFP,[]);
     imwrite(GFP, filenamegreen, 'tiff','Compression','none','Description',...
         ['Timestamp_min = ',num2str(5),', Acquired at ',num2str(datestr(5))]);
end
close all
end

