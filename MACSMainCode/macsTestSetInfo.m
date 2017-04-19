%MACSTESTSETINFO
%   MACSTESTSETINFO Set the experiment info for a test of snaps.
setExperimentInfoTest;

filename_tf = [prefix, M.time,'_',M.media, '_', M.strain,'_tfriendly.csv'];
filename_ta = [prefix, M.time,'_',M.media, '_', M.strain,'_tanalysis.csv'];

file_tf = fopen(filename_tf, 'w');  % times in a friendly format (mm-ss-fff)
file_ta = fopen(filename_ta, 'w');  % times for analysis (mins)

t_header = {'t_gc_pt_i', 't_gc_pt_f', 't_snaps_i', 't_snaps_f'};

fprintf(file_tf, '%s,', t_header{1:end-1});
fprintf(file_tf, '%s\n', t_header{end});

fprintf(file_ta, '%s,', t_header{1:end-1});
fprintf(file_ta, '%s\n', t_header{end});

setMicroscopePropertiesBeforeSnap;

t_gc_pt_i = etime(clock, T_INITIAL);
fprintf(file_ta, '%s,', t_gc_pt_i/60);
fprintf(file_tf, '%s,', secs2msf(t_gc_pt_i));

t_gc_pt_f = etime(clock, T_INITIAL);
fprintf(file_ta, '%s,', t_gc_pt_f/60);
fprintf(file_tf, '%s,', secs2msf(t_gc_pt_f));

display('starting snapping in 2')
pause(1);
display('starting snapping 1')
pause(1);
display('starting snapping')

