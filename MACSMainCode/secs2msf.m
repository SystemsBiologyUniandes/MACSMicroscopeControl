function t_str = secs2msf( t_full_seconds )
%SECS2MSF Converts a time in seconds into a minutes-seconds-thousandth of
%seconds format
%   SECS2MSF( t_full_seconds ) Converts a number representing a time in 
%   seconds into a string with the format minutes-seconds-thousandth. 
%   Returns the string.
    t_min_full = t_full_seconds/60;
    t_min = floor(t_min_full);
    
    t_min_r = t_min_full - t_min;
    t_sec_full = t_min_r*60;
    t_sec = floor(t_sec_full);
    
    t_sec_r = t_sec_full - t_sec;
    t_mill_full = t_sec_r*1000;
    t_mill = floor(t_mill_full);
    t_str = [num2str(t_min),'-', num2str(t_sec),'-',num2str(t_mill)];

end