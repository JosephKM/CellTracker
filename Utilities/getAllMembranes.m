function [ allMembranes ] = getAllMembranes(norm2preTreat)
%getAllPeaks reads peaks array in outfiles from a directory defined in analysisParam 
%            into allPeaks, an mxn cell where m is positions and n is conditions
%   
%%
global analysisParam;

allMembranes = cell(size(analysisParam.positionConditions,1),size(analysisParam.positionConditions,2));


%% for most andor live imaging datasets
iPos = 1;
file = dir([analysisParam.outMembraneDirec filesep '*pos' int2str(analysisParam.positionConditions(iPos+1)) '.mat']);
load([analysisParam.outMembraneDirec filesep file.name],'membrane');
plotX = (0:length(membrane)-1)*analysisParam.nMinutesPerFrame./60;
analysisParam.plotX = plotX-analysisParam.tLigandAdded;

  preLigand = find(analysisParam.plotX(:)<0);   
if  analysisParam.outDirecStyle == 1 || ~isfield(analysisParam,'outDirecStyle')
 
for iPos = 0:analysisParam.nPos-1;
   file = dir([analysisParam.outMembraneDirec filesep '*pos' int2str(analysisParam.positionConditions(iPos+1)) '.mat']);
    load([analysisParam.outMembraneDirec filesep file.name],'membrane');
    if norm2preTreat==1
    normalizer = mean(membrane(:,preLigand),2);
   allMembranes{iPos+1} = membrane ./ normalizer;
    else
        allMembranes{iPos+1} = membrane;
    end
    
    clear('membrane');
    
end



end
%%
i = find(cellfun(@isempty,allMembranes));
allMembranes(i)= {nan(1,9)};
end