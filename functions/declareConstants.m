%% Constants
%Cleaning FOV
N_CLEAN_FOV = 8;
T_CLEAN_FOV = 0.2;

%Time to fill the GC
T_FILL_GC_TO_PT = 15;

%Preparation before snapping
T_PT_TO_W2 = 0.8;
T_CHIP_PRESNAP = 240;

%Macsing and snapping
T_PT_TO_CHIP = 2;
T_ACCUMULATING = 2;
T_MACSING = 2;

%Number of cleaning steps
N_CLEAN_BLEACH = 3;
N_CLEAN_ETHANOL = 2;
N_CLEAN_MILLIQ = 4;

%Time for filling the PT on cleaning steps
T_FILL_CLEANING_TO_PT = 17;
T_FILL_BLEACH = T_FILL_CLEANING_TO_PT;
T_FILL_ETHANOL = T_FILL_CLEANING_TO_PT;
T_FILL_MILLIQ = T_FILL_CLEANING_TO_PT;

%Time for waiting before wasting on each cleaning step
T_WAIT = 45;
T_WAIT_BLEACH = T_WAIT;
T_WAIT_ETHANOL = T_WAIT;
T_WAIT_MILLIQ = T_WAIT;
T_WAIT_GC_TO_PT = T_WAIT;

%Time for sending to W2 on each cleaning step
T_WASTE = 45;
T_WASTE_BLEACH = T_WASTE;
T_WASTE_ETHANOL = T_WASTE;
T_WASTE_MILLIQ = T_WASTE;
T_WASTE_FINAL = T_WASTE;

%Time for sending to Chip on MilliQ cleaning step
T_CHIP_CLEANING = 300;

%Time for sending from GC to W1 on final cleaning process
T_W1 = 40;

%TODO
%DEFINE TIME BETWEEN SNAPS AND USE IT TO DEFINE SNAPS TIMES, DECIDE IF IN
%THE DIALOG OR IN THE SCRIPT