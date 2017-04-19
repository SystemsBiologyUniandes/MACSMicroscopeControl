# MACSMicroscopeControl
MATLAB program to control the MACS device and the Nikon microscope

-Updates
  - 2016-SEP-2 
      - Created functions for the different valve states.
  - 2016-SEP-16
       - Improvements for the functions and definitions of variables and
       constants, a pause was added, the time enters as a parameter.
  - 2017-JAN-19 
      - Changed macs to global variable instead of setting it as a parameter.
      - Tested if the import statement in loadMicroscope can be called
      inside a function and the result was negative. It must be a script
      since the variable mmc is global.
      - Tested if for the function setStageSpeed the argument val must be
      integer or it can be float. It must be an integer between 1 and 9.
      - The exception was added to the function.
  - 2017-FEB-15 
      - Added ocumentation to the declareConstants script with explanations
      for all the constants.
      - Added a READ BEFORE USE section at the beginning with instructions
      and clarifications
      - Test of the new prompt and directory creation layout done it
      december 22. Succesful.
      - Test of all the microscope functions, their exception handling and
      their documentation. All were successfully tested except
      setObjective, loadDaq.
  - 2017-FEB-17
      - T_ INITIAL defined inside setExperimentInfo instead of in main
      after setMicroscopePropertiesBeforeSnap.
      - In setExperimentInfo there is another text box in the prompt with
      the label 'Time difference with LabView (min)' and this time
      difference is saved in the Info file.
      - Added M.date with hours, minutes and seconds. In the filenames and
      the directories created at the beginning of each experiment the
      time of the day is included to avoid overwriting of experiments
      done in the same day.
      - Added data files for each experiment, they are tdata and tanalysis.
      - Both contain four columns t_gc_pt_i, t_gc_pt_f, t_snaps_i and
      t_snaps_f. In tdata they are given in the format mm-ss-fff and in
      tanalysis in minutes.
      - Added data files for each time folder (set of snaps), they are
      snapdata and snapanalysis. They have four columns, t_rfp_snap,
      t_rfp_exp, t_gfp_snap, t_gfp_exp with the time for each rfp and gfp
      snap from the beginning of the experiment (exp) and from the
      beginning of the current snap series (snap). The format is
      mm-ss-fff for snapdata and in minutes for snapanalysis.
  - TODO
      - Test the remaining functions: setObjective and loadDaq
      - Write the documentation an organized document including the
      directory format and the data files format.
      - Test everything in the Microscope PC and with the MACS connected.
