figure(1);
fir_10_data = csvread('freq_response_10.csv');
semilogx(fir_10_data(:,1), fir_10_data(:,2));
grid 'on';
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');

figure(2);
fir_15_data = csvread('freq_response_15.csv');
semilogx(fir_15_data(:,1), fir_15_data(:,2));
grid 'on';
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');

figure(3);
fir_20_data = csvread('freq_response_20.csv');
semilogx(fir_20_data(:,1), fir_20_data(:,2));
grid 'on';
xlabel('Frequency (Hz)');
ylabel('Gain (dB)');
xlim([5e3 25e3]);

figure(4);
timing_20 = csvread('timing_20.csv');
plot(timing_20(:,1), timing_20(:,2));
grid 'on';
xlabel('Time (s)');
ylabel('Amplitude (V)');
xlim([-2e-3 2e-3]);