function [ output_args ] = singleCells2NormPlots3( singleCells,controlCondition,plotTrimmedMean,plotCounts)
%singleCells2Plots3 normalizes by mean(RFP(nuc)(condition))
%dataset
%   
global analysisParam;
colors = distinguishable_colors(analysisParam.nCon);
%% find mean(nuc)(timepoint)

for iCon = 1:analysisParam.nCon;
    
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,5);
    if iCon == 1;    
    Y =R; % find means of ratios less than filterHigh
    else
     Y =[Y ;R];
    end
    nucAll(iTime) = mean(Y);
    end
    
end




%% plot mean
for iCon = 1:analysisParam.nCon;
    for iTime = find(~cellfun('isempty', singleCells{iCon}))
        R = singleCells{iCon}{iTime}(:,6)./nucAll(iTime);
        
    nuc2nucMeans(iCon,iTime) = meannonan(R); % find means of ratios less than filterHigh
    nuc2nucStd(iCon,iTime) = stdnonan(R); % 
    nCells(iCon,iTime) = size(R,1);
    end
end
plotX = (0:length(singleCells{1})-1)*analysisParam.nMinutesPerFrame./60;
analysisParam.plotX = plotX-analysisParam.tLigandAdded;

% find mean of signaling prior to t = 0 (when ligand is added)
preLigand = find(analysisParam.plotX(:)<0);
%preLigand = preLigand(3:length(preLigand)-2);
% for iCon = 1:analysisParam.nCon;
% normalizer = mean(nuc2nucMeans(iCon,preLigand));
% nuc2nucMeans(iCon,:) = nuc2nucMeans(iCon,:)./normalizer;
% end
% smooth control for use in normalizing
control = nuc2nucMeans(controlCondition,:)
control = medfilt1(control,13);
% plot nuc2nucMeans
figure; clf; hold on;
for iCon = 1:analysisParam.nCon;
plot(analysisParam.plotX(1:size(nuc2nucMeans,2)),nuc2nucMeans(iCon,:)./control,'Color',colors(iCon,:),'LineWidth',2);
end
legend(analysisParam.conNames,'Location','best');
xlabel(['hours after ' analysisParam.ligandName ' added']);
ylabel([analysisParam.yMolecule ' : ' analysisParam.yNuc ' cellXtime']);
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

end


