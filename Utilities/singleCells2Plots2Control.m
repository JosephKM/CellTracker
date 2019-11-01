function [ output_args ] = singleCells2Plots2Control( singleCells,controlCondition,filterHigh )
%singleCells2Plots generates a few plots to quickly look at singleCells
%dataset
%   
global analysisParam;
% format time


% get ratios
colors = distinguishable_colors(analysisParam.nCon);

for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,6)./singleCells{iCon}{iTime}(:,5);
        
    nuc2nucMeans(iCon,iTime) = meannonan(R(R<filterHigh)); % find means of ratios less than filterHigh
    nuc2nucStd(iCon,iTime) = stdnonan(R(R<filterHigh)); % 
    nCells(iCon,iTime) = size(R(R<filterHigh),1);
    end
end
% smooth control for use in normalizing
control = nuc2nucMeans(controlCondition,:)
control = medfilt1(control,13); %filtered control condition for normalization
y = nuc2nucMeans./control;

% mean is divided by control, err is std divided by control with error prop
ySE = nuc2nucStd./sqrt(nCells);
ySEnormal = QuotientError(nuc2nucMeans,control,ySE,ySE(controlCondition,:));
% plot nuc2nucMeans
figure; clf; hold on;
% for iCon = 1:analysisParam.nCon;
% plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nuc2nucMeans(iCon,:)./control,'Color',colors(iCon,:),'LineWidth',2);
% end

for iCon = 1:analysisParam.nCon;
    errorbar(analysisParam.plotX(1:size(nuc2nucMeans,2)),y(iCon,:),ySEnormal(iCon,:));

end

legend(analysisParam.conNames,'Location','best');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc]);
title('mean signaling');

% plot mean with cell STD
% figure; clf; hold on;
% for iCon = 1:analysisParam.nCon;
% errorbar(analysisParam.plotX(1:size(nuc2nucMeans,2)),nuc2nucMeans(iCon,:),nuc2nucStd(iCon,:),'Color',colors(iCon,:),'LineWidth',2);
% end
% legend(analysisParam.conNames,'Location','best');
% xlabel(['hours after ' analysisParam.ligandName ' added']);
% ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc]);
% title('mean signaling w/ cell std');

% plot # of cells in each mean
% figure; clf; hold on;
% for iCon = 1:analysisParam.nCon;
% plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nCells(iCon,:),'Color',colors(iCon,:),'LineWidth',2);
% end
% legend(analysisParam.conNames,'Location','eastoutside');
% xlabel(['hours after ' analysisParam.ligandName ' added']);
% ylabel('# of cells');
% title('detected cells');

end

