function setObjective(val)
% SETOBJECTIVE Set the filter.
%   SETOBJECTIVE(val) Set the microscope objective according to the value
%   of the integer val. The valid values are 10, 40, 60 and 100.
%   Throws error if other value is used.
    global mmc;

    if val == 10
        mmc.setProperty('TINosePiece','Label','3-Plan Fluor 10x NA 0.30 Dry'); %10x Objective

    elseif val == 40
        mmc.setProperty('TINosePiece','Label','4-Plan Fluor 40x NA 1.30 Oil'); %40x Objective

    elseif val == 60
        mmc.setProperty('TINosePiece','Label','5-Apo TIRF 60x NA 1.49 Oil'); %60x Objective

    elseif val == 100
        mmc.setProperty('TINosePiece','Label','6-Apo TIRF 100x NA 1.49 Oil'); %100x Objective
    else
        error('Invalid value for val, it must be 10, 40, 60 or 100');
    end
    
end