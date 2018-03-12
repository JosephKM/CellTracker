
function [ output_args ] = quickAnalysisFixed2( singlePlot )
% when singlePlot is true, everything is plot as a 1x2 panel figure



setAnalysisParam_this;
global analysisParam;
allPeaks = getAllPeaks;
x = [0,1,2,3,4,6,9,12];
mkdir('figures');
spn = 1;
if singlePlot;
    figure;
end
%% find and plot nuclear bCat
channels = [6 8 10];
for plotChannels = 1:3;
    
for ii = 1:size(allPeaks,1);
    for jj = 1:size(allPeaks,2);
        
dapiMean(ii,jj) = meannonan(allPeaks{ii,jj}(:,channels(plotChannels)));
dapiStd(ii,jj) = std(allPeaks{ii,jj}(:,channels(plotChannels)));
end
end
dapiMM = meannonan(dapiMean,2);
dapiSS = stdnonan(dapiMean,2);



if ~singlePlot;
figure;
else
    subplot(1,2,1); hold on;
end
spn = spn+1;

errorbar(x,dapiMM,dapiSS);
title([ analysisParam.channelNames{plotChannels} ])
ylabel('pixel intensity');
xlabel('hours Wnt');
if ~singlePlot
savefig(['figures/' analysisParam.channelNames{plotChannels} '.fig']);
end
%% find and plot nuc bCat / DAPI
for ii = 1:size(allPeaks,1);
    for jj = 1:size(allPeaks,2);
        
dapiMean(ii,jj) = meannonan(allPeaks{ii,jj}(:,channels(plotChannels))./allPeaks{ii,jj}(:,5));
dapiStd(ii,jj) = std(allPeaks{ii,jj}(:,channels(plotChannels))./allPeaks{ii,jj}(:,5));
end
end
dapiMM = meannonan(dapiMean,2);
dapiSS = stdnonan(dapiMean,2);



if ~singlePlot;
figure;
else
    subplot(1,2,2); hold on;
end
spn = spn+1;

errorbar(x,dapiMM,dapiSS);
title(['channel : dapi'])
ylabel('channel : dapi');
xlabel('hours Wnt');
if ~singlePlot
savefig(['figures/' analysisParam.channelNames{plotChannels} '2dapi.fig']);
end
end

if singlePlot;
savefig('figures/multiplots.fig');
end
%% find and plot dapi mean



for ii = 1:size(allPeaks,1);
    for jj = 1:size(allPeaks,2);
        
dapiMean(ii,jj) = meannonan(allPeaks{ii,jj}(:,5));
dapiStd(ii,jj) = std(allPeaks{ii,jj}(:,5));
end
end
dapiMM = meannonan(dapiMean,2);
dapiSS = stdnonan(dapiMean,2);

if ~singlePlot;
figure;
else
    subplot(1,2,1); hold on;
end
spn = spn+1;
errorbar(x,dapiMM,dapiSS);
title('pixel intensity values')
ylabel('mean nuc pixel intensity');
xlabel('hours Wnt');
legend([analysisParam.channelNames, 'DAPI']);
if ~singlePlot
savefig('figures/DAPI.fig');
end
end
%% as single cells
% singleCells = allPeaks2singleCells(allPeaks);
% figure;
% for ii = 1:8;
%     temp = mean(singleCells(ii));
% end
