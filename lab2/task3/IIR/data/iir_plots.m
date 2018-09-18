figure(1);
fir_6_data = csvread('freq_response_6.csv');
semilogx(fir_6_data(:,1), fir_6_data(:,2));
grid 'on';
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');

figure(2);
fir_10_data = csvread('freq_response_10.csv');
semilogx(fir_10_data(:,1), fir_10_data(:,2));
grid 'on';
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');
xlim([1e3 20e3]);

figure(3);
timing_6 = csvread('timing_6.csv');
plot(timing_6(:,1), timing_6(:,2));
grid 'on';
xlabel('Time (s)');
ylabel('Amplitude (V)');
xlim([-2e-3 2e-3]);