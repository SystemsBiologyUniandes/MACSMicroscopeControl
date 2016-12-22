function Objective( val )
    global mmc

    if strcmp(val,'10x')
    mmc.setProperty('TINosePiece','Label','3-Plan Fluor 10x NA 0.30 Dry'); %10x Objective

    elseif strcmp(val,'40x')
    mmc.setProperty('TINosePiece','Label','4-Plan Fluor 40x NA 1.30 Oil'); %40x Objective

    elseif strcmp(val,'60x')
    mmc.setProperty('TINosePiece','Label','5-Apo TIRF 60x NA 1.49 Oil'); %60x Objective

    elseif strcmp(val,'100x')
    mmc.setProperty('TINosePiece','Label','6-Apo TIRF 100x NA 1.49 Oil'); %100x Objective
    end
end