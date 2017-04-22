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
T_FILL_GC_TO_PT = 3.5;
%% Preparation before snapping
% Time to send from PT to W2 to bring the cells closer to the chip.
T_PT_TO_W2 = 0.7;
% Time to send from PT to CHIP before snapping to ensure that the cells
% reach the FOV:
T_CHIP_PRESNAP = 300;
%% Macsing and snapping
% Time to send from PT to Chip
T_PT_TO_CHIP = 10;
% Time to accumulate cells in the FOV
T_ACCUMULATING = 4;
% Time to press the cells (and wait for the first snap)
T_MACSING = 4;
%% Cleaning
% Number of cleaning steps
%N_CLEAN_BLEACH = 2;
N_CLEAN_RBS_35 = 2;
N_CLEAN_MILLIQ = 2;
N_CLEAN_FINAL = 4;
% Time to fill the PT on cleaning steps
%   By default it is the same for all. This can be changed.
T_FILL_CLEANING_TO_PT = 5;
%T_FILL_BLEACH = T_FILL_CLEANING_TO_PT;
T_FILL_RBS_35 = T_FILL_CLEANING_TO_PT;
T_FILL_MILLIQ = T_FILL_CLEANING_TO_PT;
%Time to wait before wasting on each cleaning step
%   By default it is the same for all. This can be changed.
T_WAIT = 45;
%T_WAIT_BLEACH = T_WAIT;
T_WAIT_RBS_35 = T_WAIT;
T_WAIT_MILLIQ = T_WAIT;
T_WAIT_GC_TO_PT = T_WAIT;
% Time to send to W2 on each cleaning step
%   By default it is the same for all. This can be changed.
T_WASTE = 45;
%T_WASTE_BLEACH = T_WASTE;
T_WASTE_RBS_35 = T_WASTE;
T_WASTE_MILLIQ = T_WASTE;
T_WASTE_FINAL = T_WASTE;
%Time for sending to Chip on MilliQ cleaning step
T_CHIP_CLEANING = 400;
%Time for sending from GC to W1 on final cleaning process
T_W1 = 20;