function h5name = geth5nameOIF(filename)
%strip file extension and add .h5 index
inds = strfind(filename,'.');
h5name = [filename(1:(inds(end)-1)) '.oif.files.h5'];