function [ output_args ] = singleCells2Plots( singleCells,filterHigh,norm2baseline,controlCondition,plotCounts )
%singleCells2Plots generates a few plots to quickly look at singleCells
%dataset

%filterHigh discards outliers above thresh filterHigh


%   
global analysisParam;
% format time
lineWidth = 3;
mkdir(analysisParam.figDir);
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

preLigand = find(analysisParam.plotX(:)<0);


%% plot nuc2nucMeans normalized to preligand
if norm2baseline == 1 && controlCondition == 0
for iCon = 1:analysisParam.nCon;
normalizer = mean(nuc2nucMeans(iCon,preLigand));
nuc2nucMeans(iCon,:) = nuc2nucMeans(iCon,:)./normalizer;
end
% plot nuc2nucMeans
figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nuc2nucMeans(iCon,:),'Color',colors(iCon,:),'LineWidth',lineWidth);
end
legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc]);
title('mean signaling, normalized to preligand');
savefig('figures/Gfp2Rfp2Preligand.fig');
end






%% plot nuc2nucMeans gfp2rfp only
if norm2baseline == 0 && controlCondition == 0
figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nuc2nucMeans(iCon,:),'Color',colors(iCon,:),'LineWidth',lineWidth);
end
legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc]);
title('mean signaling, nuc gfp2rfp only');
savefig('figures/Gfp2Rfp.fig');

end
%% plot for norm to condition
if controlCondition >= 1 && norm2baseline == 0;
control = nuc2nucMeans(controlCondition,:)
control = medfilt1(control,13);

figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nuc2nucMeans(iCon,:)./control,'Color',colors(iCon,:),'LineWidth',lineWidth);
end
legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc]);
title('mean signaling, divided by control condition');
savefig('figures/Gfp2Rfp2NoTreatment.fig');
end




%% plot nuc2nucMeans normalized to preligand and controlCondition
if norm2baseline == 1 && controlCondition >= 1
for iCon = 1:analysisParam.nCon;
normalizer = mean(nuc2nucMeans(iCon,preLigand));
nuc2nucMeans(iCon,:) = nuc2nucMeans(iCon,:)./normalizer;
end

control = nuc2nucMeans(controlCondition,:)
control = medfilt1(control,13); %preserve noise
% plot nuc2nucMeans
figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nuc2nucMeans(iCon,:)./control,'Color',colors(iCon,:),'LineWidth',lineWidth);
end
legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc]);
title('mean signaling, normalized to preligand and control condition');
savefig('figures/Gfp2Rfp2PreLigand2NoTreatment.fig');
end




%% plotting detected cells
if plotCounts == 1;
figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nCells(iCon,:),'Color',colors(iCon,:),'LineWidth',lineWidth);
end
legend(analysisParam.conNames,'Location','eastoutside');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel('# of cells');
title('detected cells');
savefig('figures/#cells.fig');
end
end

