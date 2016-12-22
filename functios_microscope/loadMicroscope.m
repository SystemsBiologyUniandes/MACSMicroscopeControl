function loadMicroscope(config_filename)
%LOADMICROSCOPE Loads the microscope.
%   LOADMICROSCOPE(config_filename) Loads the microscope according to the
%   configuration time with route config_filename.
    global mmc;
    import mmcorej.*;
    mmc = CMMCore;
    mmc.loadSystemConfiguration (config_filename);
    display('Nikon Eclipse Ti is ready to be used');

end

