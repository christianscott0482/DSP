OOKdata = csvread('ECE486-L4T3-OOK-scope-.csv');
%treal = OOKdata(:,1);
%t = 1:40000;
took = 1:16000;
%y = data(:,2);
ook = OOKdata(11501:27500,2);

figure(1);
hold on;
plot(took,ook);
title('OOK modulation');
xticks([0 3200 6400 9600 12800 16000]);
xticklabels({'0','4','8','12','16','20'});
xlabel('Time (ms)');
ylabel('Output (Volts)');
%xlim([1100 40000]);

ASKdata = csvread('ECE486-L4T3-ASK-scope-.csv');
task = 1:20000;
ask = ASKdata(68001:88000,2);

figure(2);
hold on;
plot(task./1000,ask);
title('ASK modulation');
xlabel('Time (ms)');
ylabel('Output (Volts)');


BPSKdata = csvread('ECE486-L4T3-BPSK-scope-.csv');
tbpsk = 1:20000;
bpsk = BPSKdata(55001:75000,2);

figure(3);
hold on;
plot(tbpsk./1000,bpsk);
title('BPSK modulation');
xlabel('Time (ms)');
ylabel('Output (Volts)');


QPSKdata = csvread('ECE486-L4T3-QPSK-scope-.csv');
tqpsk = 1:20000;
qpsk = QPSKdata(55001:75000,2);

figure(4);
hold on;
plot(tqpsk./1000,qpsk);
title('QPSK modulation');
xlabel('Time (ms)');
ylabel('Output (Volts)');