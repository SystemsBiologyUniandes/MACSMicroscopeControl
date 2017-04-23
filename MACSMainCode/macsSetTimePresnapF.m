%MACSSETTIMEPRESNAPF
%   MACSSETTIMEPRESNAPF Set the intial times for a presnapping.
t_gc_pt_f = etime(clock, T_INITIAL);
fprintf(file_ta, '%s,', t_gc_pt_f/60);
fprintf(file_tf, '%s,', secs2msf(t_gc_pt_f));