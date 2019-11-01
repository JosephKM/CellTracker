function h5name = geth5nameMask3(filename)
%strip file extension and add .h5 index
[a b c] = fileparts(filename);
inds = strfind(b,'.');
h5name = [a filesep 'Mask3_' b '.h5'];
