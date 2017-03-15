% DECLARECONSTANTS Declares the constants for the fluidics control.
%   DECLARECONSTANTS Declares the constants for the fluidics control
%   including the sending times, waiting times and number of repetitions.
%   All the times are in seconds.
%   A brief description of the constants is given, for more details see the
%   documentation of the related function (e.g. cleanMilliq, cleanEthanol, etc.).

%% Cleaning  Field Of View (FOV)
% Number of times the FOV is cleaned
N_CLEAN_FOV = 8;
% Time that the FOV is cleaned on each repetition
T_CLEAN_FOV = 0.2;
%% Time to fill the PT from the GC
T_FILL_GC_TO_PT = 8;
%% Preparation before snapping
% Time to send from PT to W2 to bring the cells closer to the chip.
T_PT_TO_W2 = 1.5;
% Time to send from PT to CHIP before snapping to ensure that the cells
% reach the FOV:
T_CHIP_PRESNAP = 240;
%% Macsing and snapping
% Time to send from PT to Chip
T_PT_TO_CHIP = 2;
% Time to accumulate cells in the FOV
T_ACCUMULATING = 1;
% Time to press the cells (and wait for the first snap)
T_MACSING = 3;
%% Cleaning
% Number of cleaning steps
N_CLEAN_BLEACH = 2;
N_CLEAN_ETHANOL = 2;
N_CLEAN_MILLIQ = 4;
% Time to fill the PT on cleaning steps
%   By default it is the same for all. This can be changed.
T_FILL_CLEANING_TO_PT = 8;
T_FILL_BLEACH = T_FILL_CLEANING_TO_PT;
T_FILL_ETHANOL = T_FILL_CLEANING_TO_PT;
T_FILL_MILLIQ = T_FILL_CLEANING_TO_PT;
%Time to wait before wasting on each cleaning step
%   By default it is the same for all. This can be changed.
T_WAIT = 45;
T_WAIT_BLEACH = T_WAIT;
T_WAIT_ETHANOL = T_WAIT;
T_WAIT_MILLIQ = T_WAIT;
T_WAIT_GC_TO_PT = T_WAIT;
% Time to send to W2 on each cleaning step
%   By default it is the same for all. This can be changed.
T_WASTE = 45;
T_WASTE_BLEACH = T_WASTE;
T_WASTE_ETHANOL = T_WASTE;
T_WASTE_MILLIQ = T_WASTE;
T_WASTE_FINAL = T_WASTE;
%Time for sending to Chip on MilliQ cleaning step
T_CHIP_CLEANING = 400;
%Time for sending from GC to W1 on final cleaning process
T_W1 = 40;