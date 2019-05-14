function [driftVec conditionIdx itemIdx] = contextualDrift(baselineC,boundaryC,WEtrials,ContextVecSize,ExpDur)

%This is the baseline rate of change
% baselineC = 1/5;
% boundaryC=1;
% WEtrials = 9; 
% ContextVecSize = 100;
% ExpDur = 1000;


driftModel = repmat([boundaryC ones(1,WEtrials)*baselineC],1,ContextVecSize);

Temporal_Drift_Start = randn(ContextVecSize,1);

for iDrift = 1:ExpDur
    
    noise = randn(ContextVecSize,1).*driftModel(iDrift);
    
    driftVec(:,iDrift) = Temporal_Drift_Start + noise;
    Temporal_Drift_Start = Temporal_Drift_Start + noise;
    
end

driftVec = driftVec - mean(driftVec(:,1));

conditionIdx = repmat([2 ones(1,WEtrials)],1,ContextVecSize);

itemIdx = 1:ExpDur;

end
