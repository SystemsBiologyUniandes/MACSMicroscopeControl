function cleanFov(t, n )
%CLEANFOV Cleans the FOV 
%   CLEANFOV(t, n) Switches n times between PtToChip and accumulating
%   with intervals of t. Then turns all valves off.
    for i=1:n
        accumulate(t);
        ptToChip(t);
    end
    allOff();
end

