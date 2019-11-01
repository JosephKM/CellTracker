function [ singleCellsNoTimeDim allCells conditionArray ] = allPeaks2singleCells( allPeaks )
%allPeaks2singleCells reformats allPeaks so that it is position agnostic
%
%
global analysisParam;
%allPeaks = allPeaks';
if  analysisParam.isAndorMovie
    aC = 1;
    for iCon = 1:analysisParam.nCon;
        %for each position
        
        for iPos = 1:analysisParam.nPosPerCon;
            
            %for each timepoint
            % for iTime = 1:length(allPeaks{iCon,iPos})
            if iPos == 1;
                singleCellsNoTimeDim{iCon}=allPeaks{iCon,iPos}{1};
            else
                singleCellsNoTimeDim{iCon}=[singleCellsNoTimeDim{iCon};allPeaks{iCon,iPos}{1}];
            end
            if aC == 1;
                allCells = allPeaks{iCon,iPos}{1};
                conditions(1:size(allPeaks{iCon,iPos}{1},1)) = analysisParam.conNames(iCon);
                conditionArray = conditions;
                aC = 2;
            else
                allCells = [allCells; allPeaks{iCon,iPos}{1}];
                
                conditions(1:size(allPeaks{iCon,iPos}{1},1)) = analysisParam.conNames(iCon);
                conditionArray = [conditionArray, conditions];
            end
            clear conditions;
            
            
            % end
        end
    end
end

singleCellsNoTimeDim = singleCellsNoTimeDim';
save('singleCells.mat','singleCellsNoTimeDim','allCells','conditionArray');
end

