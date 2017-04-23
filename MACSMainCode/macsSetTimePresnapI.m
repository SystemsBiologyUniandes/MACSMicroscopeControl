%MACSSETTIMEPRESNAPI
%   MACSSETTIMEPRESNAPI Set the intial times for a presnapping.
t_gc_pt_i = etime(clock, T_INITIAL);
fprintf(file_ta, '%s,', t_gc_pt_i/60);
fprintf(file_tf, '%s,', secs2msf(t_gc_pt_i));
