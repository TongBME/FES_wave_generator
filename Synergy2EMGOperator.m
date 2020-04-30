function [EMG,Synergy] = Synergy2EMGOperator(Synergy,Ch_name,subject)
% - Input:  
%          synergy of filtered sEMG
%          subject customized value: painThreshold, movementTime
%   Output: 
%         ReconstructEMG: sum(Wi*Hi)
%         ReshapeWave: Linear Waveform 
%% reconstruct EMG
[m,n] = size(Synergy.W);
l = length(Synergy.H(1,:));
EMG.ReconstructEMG = zeros(m,l);
EMG_temp = 0;
for i = 1:n
    EMG_temp = Synergy.W(:,i)*Synergy.H(i,:);
    EMG.ReconstructEMG = EMG.ReconstructEMG + EMG_temp;
end
%% reshape EMG
R = length(EMG.ReconstructEMG(:,1));
N_ch = length(Ch_name);
N_trial = R/N_ch;

if N_trial == 1
    EMG.ReconstructMean = EMG.ReconstructEMG;
    Synergy.W_ave = Synergy.W;
else
    for j = 1:N_ch
        EMG.ReconstructMean(j,:) = mean( EMG.ReconstructEMG(N_ch*((1:N_trial)-1)+j,:) );
        Synergy.W_ave(j,:) = mean( Synergy.W(N_ch*((1:N_trial)-1)+j,:) );
    end
end

% reshape waveform
[EMG.CustomWave,t] = EMGReshapeOperator(EMG.ReconstructMean,subject);

for i = 1:N_ch
    display(Ch_name(i));
    display(['t1: ' num2str((t.t1(i))/100) 's, EMG: 0mA']);
    display(['t2: ' num2str((t.t2(i))/100) 's, EMG: ' num2str(max(EMG.CustomWave(i,:))) 'mA']);
    display(['t3: ' num2str((t.t3(i))/100) 's, EMG: ' num2str(max(EMG.CustomWave(i,:))) 'mA']);
    display(['t4: ' num2str((t.t4(i))/100) 's, EMG: 0mA']);
end
end