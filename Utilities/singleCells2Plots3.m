function [ output_args ] = singleCells2Plots3( singleCells,plotTrimmedMean,plotCounts)
%singleCells2Plots3 normalizes by mean(RFP(nuc)(condition))
%dataset
%   
global analysisParam;
colors = distinguishable_colors(analysisParam.nCon);
%% plot mean
for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,6)./mean(singleCells{iCon}{iTime}(:,5));
        
    nuc2nucMeans(iCon,iTime) = meannonan(R); % find means of ratios less than filterHigh
    nuc2nucStd(iCon,iTime) = stdnonan(R); % 
    nCells(iCon,iTime) = size(R,1);
    end
end
plotX = (0:length(singleCells{1})-1)*analysisParam.nMinutesPerFrame./60;
analysisParam.plotX = plotX-analysisParam.tLigandAdded;

% plot nuc2nucMeans
figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nuc2nucMeans(iCon,:),'Color',colors(iCon,:),'LineWidth',2);
end
legend(analysisParam.conNames,'Location','best');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc 'cellXcondition']);
title('mean signaling');




%% plot # of detected cells in each mean
if plotCounts ==1;
figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nCells(iCon,:),'Color',colors(iCon,:),'LineWidth',2);
end
legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel('# of cells');
title('detected cells');
end
%% plot trimmed mean
if plotTrimmedMean == 1;
trimPercent = 15;

for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,6)./mean(singleCells{iCon}{iTime}(:,5));
        
    nuc2nucMeans(iCon,iTime) = trimmean(R,10); % find means of ratios less than filterHigh
    nuc2nucStd(iCon,iTime) = stdnonan(R); % 
    nCells(iCon,iTime) = ((100-trimPercent)/100).*(size(R,1));
    end
end
% plot nuc2nucMeans
figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nuc2nucMeans(iCon,:),'Color',colors(iCon,:),'LineWidth',2);
end
legend(analysisParam.conNames,'Location','best');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc]);
title([int2str(trimPercent) '% trimmed mean signaling']);
end
%% plot # of detected cells in each trimmed mean
if plotCounts == 1;
figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nCells(iCon,:),'Color',colors(iCon,:),'LineWidth',2);
end
legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel('# cells');
title('detected cells - trimmed cells');

end

