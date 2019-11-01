function setAnalysisParam_this
% for use with quickAnalysis function
fprintf(1, '%s called to define params\n',mfilename);
global analysisParam;

%% main analysis parameters
analysisParam.nPos = 200; %total number of positions in dataset
analysisParam.nCon = 8; %total number of separate conditions
analysisParam.ligandName = 'Wnt3a';
analysisParam.yMolecule = 'GFP-bCat';
analysisParam.yNuc = 'RFP-H2B';
analysisParam.conNames = ...
    {'-Control', '21h 300ng/ml Wnt3a', '6h 300ng/ml Wnt3a', '4h 300ng/ml Wnt3a',...
    '+SB+LDN', '21h 300ng/ml Wnt3a+SB+LDN','6h 300ng/ml Wnt3a+SB+LDN','4h 300ng/ml Wnt3a+SB+LDN'};  
%formatted by well image order
analysisParam.conditionGroups = [0,21,6,4;...
                                 0,21,6,4]; %conditionGroups is an MxN matrix whose values correspond to the 
                                             %treatment time (x axis). M = number of groups, N = timepoints in series
analysisParam.groupNames = {'mtesr','+SB+LDN'}; % corresponds to M of conditionGroups

%% shouldn't need to modify below
analysisParam.isFixedCells = 0;
analysisParam.isAndorMovie = 1;
analysisParam.figDir = 'figures';
analysisParam.outDirecStyle = 1;% 1 for Andor IQ style (i.e., posX.mat) % 2 for Out_ConditionPrefix_X.mat style
analysisParam.outDirec = 'Outfiles1'; %directory containing outfiles for each position 
analysisParam.nPosPerCon = analysisParam.nPos./analysisParam.nCon; %set how many positions per condition
positionConditions = zeros(analysisParam.nPosPerCon,analysisParam.nCon);
positionConditions(:) = 0:analysisParam.nPos-1;
analysisParam.positionConditions = positionConditions';
end