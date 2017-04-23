%% MACS ACQUISITION PROGRAM
% Juan Carlos Arias Castro - ju-aria1@uniandes.edu.co
% Luis Alberto Gutierrez Lopez - la.gutierrez1280@uniandes.edu.co
% Carlos Arturo Sanchez isaza - ca.sanchez1209@uniandes.edu.co
%% PA RECORDARLES
% Pa darle allOff() por si alguna emergencia solo hay que correr aaa y
% listo

% unloadMicroscope esta al final del main
%% 1. Declare constants
declareConstants;
%% 2. Microscope core
loadMicroscope;
%% 3. Set all microscope properties
setMicroscopePropertiesHama;
%% 4. Initialize NI-DAQ board
loadDaq;
%% 5. General settings before start snapping
setMicroscopePropertiesBeforeSnap;
RFP_EXPOSURE = 250; %ms
GFP_EXPOSURE = 800; %ms
%% 6a. Test Pt 1: Set info
setExperimentInfoTest;
macsSetTime;
%% 6b. Test Pt 2: Snaps
macsSetTimePresnapI;
macsSetTimePresnapF;
N_SNAPS = 1;
macsSnaps;
%% 6c. Test Pt 3: Cleaning
ptToW2(T_WASTE_FINAL);
allOff();
cleanRbs35(N_CLEAN_RBS_35, T_FILL_RBS_35, T_WAIT_RBS_35, T_WASTE_RBS_35);
cleanMilliq(N_CLEAN_MILLIQ, T_FILL_MILLIQ, T_WAIT_MILLIQ, T_WASTE_MILLIQ, T_PT_TO_W2, T_CHIP_CLEANING);
%% 7. Set experiment information
setExperimentInfo;
macsSetTime;
%% 8. Measure
gcToW1(T_MEASURE); %Cleaning pressure line 10 psi
allOff();
%% 9. Prepare MACS for snapping
macsSetTimePresnapI;
preSnapping(T_FILL_GC_TO_PT, T_PT_TO_W2, T_CHIP_PRESNAP);
macsSetTimePresnapF;
%% 10. MACSing with snapping images
N_SNAPS = 2;
macsSnaps;
%% 11. Cleaning protocols 
ptToW2(T_WASTE_FINAL);
allOff();
cleanRbs35(N_CLEAN_RBS_35, T_FILL_RBS_35, T_WAIT_RBS_35, T_WASTE_RBS_35);
cleanMilliq(N_CLEAN_MILLIQ, T_FILL_MILLIQ, T_WAIT_MILLIQ, T_WASTE_MILLIQ, T_PT_TO_W2, T_CHIP_CLEANING);
%% 12. Cleaning protocol 3 final
cleanFinal(N_CLEAN_FINAL, T_W1, T_FILL_GC_TO_PT, T_WAIT_GC_TO_PT, T_WASTE_FINAL);
%% 13. Close files
fclose( file_ta );
fclose( file_tf );
%% 14. Unload Microscope
unloadMicroscope;