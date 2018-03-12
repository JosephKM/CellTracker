function [ output_args ] = singleCells2Hist( singleCells,hourPostLigand )
%singleCells2Hist generates a histogram from singleCells at the specified
%hour and condition
%   
global analysisParam;
% format time

timepoint = find(analysisParam.plotX==hourPostLigand);
% get ratios
colors = distinguishable_colors(analysisParam.nCon);

for iCon = 1:analysisParam.nCon;
timepointCellRatios{iCon}=singleCells{iCon}{timepoint}(:,6)./singleCells{iCon}{timepoint}(:,5);
end
figure; clf; hold on;
for ii = 1:analysisParam.nCon;
    subplot(2,4,ii);
    
nhist(timepointCellRatios{ii},'numbers','noerror');
%legend(analysisParam.conNames,'Location','eastoutside');
xlabel([analysisParam.yMolecule ' : ' analysisParam.yNuc]);
ylabel('# of cells');
title(['distribution at ' int2str(hourPostLigand) ' hours ' analysisParam.conNames{ii}]);
end
savefig(['figures/hist ' int2str(hourPostLigand) ' hours']);
end
