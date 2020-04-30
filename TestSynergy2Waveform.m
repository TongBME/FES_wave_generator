clear;
clc;
close all;
%% exp info
task = 'FR';
% input subject customization para:
subject.painThreshold = 25;
subject.movementTime = 2;
%% load synergy
load([pwd '\Synergy_Control.mat']);
switch task
    case 'FR'
        Synergy_Task = Synergy(1,2);
    case 'LR'
        Synergy_Task = Synergy(2,2);
end
%% reconstruct and reshape
Ch_name = { 'Tlt', 'BR', 'Tlh', 'BI', 'DP', 'DA', 'PC'};
[M,N] = size(Synergy_Task);
EMG = cell(M,N);
for i = 1:M
    for j = 1:N
        [EMG{i,j},Synergy_Task] = Synergy2EMGOperator(Synergy_Task(i,j),Ch_name,subject);
    end
end
%% plotting
for i = 1:1
    for j = 1:N
        Syn_num = [num2str(j) '_Synergy_pattens_'];
        PlotSynergy(EMG{i,j},Synergy_Task,Ch_name,Syn_num);
    end
end