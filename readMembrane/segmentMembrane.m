function [ membrane ] = segmentMembrane( fimg, mask )
%segmentMembrane evaluates mean pixel intensity of the membrane based on ilastik
%mask.
%   Detailed explanation goes here
membrane = mean(fimg(mask));


end

