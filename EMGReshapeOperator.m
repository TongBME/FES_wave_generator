function [CustomWave,t] = EMGReshapeOperator(EMG,subject)
% reshape algorithm
[m,n] = size(EMG);
EMG_P = zeros(m,n);
t.t1 = zeros(1,m);
t.t2 = zeros(1,m);
t.t3 = zeros(1,m);
t.t4 = zeros(1,m);

for i = 1:m
    EMG_temp = EMG(i,:)-min(EMG(i,:));
    list1 = find(EMG_temp >= 0.1*max(EMG(i,:)));
    list2 = find(EMG_temp >= 0.8*max(EMG(i,:)));
    list3 = find((EMG(i,:) >= (mean(EMG(i,end-50:end))+0.1*(max(EMG(i,:))-mean(EMG(i,end-50:end))))));
    t.t1(i) = max(list1(1)-10,2) * subject.movementTime;
    t.t2(i) = list2(1) * subject.movementTime;
    t.t3(i) = list2(end) * subject.movementTime;
    t.t4(i) = min(list3(end)+10,n) * subject.movementTime;
    EMG_P(i,1:t.t1(i)-1) = 0;
    EMG_P(i,t.t1(i):t.t2(i)) = 0:(max(EMG(i,:))/(t.t2(i)-t.t1(i))):max(EMG(i,:));
    EMG_P(i,t.t2(i):t.t3(i)) = max(EMG(i,:));
    EMG_P(i,t.t3(i):t.t4(i)) = max(EMG(i,:)):(0-max(EMG(i,:))/(t.t4(i)-t.t3(i))):0;
    EMG_P(i,t.t4(i):n * subject.movementTime) = 0;
end

[CH_NUM,~] = size(EMG_P);
for i = 1: CH_NUM
    emgTmep(i) = max(EMG_P(i,:));
end
% amplitude
gainVal = subject.painThreshold / max(emgTmep);
CustomWave = gainVal * EMG_P;
end