Fs = SamplingFrequency;
M = size(Window_num,1);
Hdr = 0;

k = 0:N-1;
f = k/N;
f(N/2+2:end) = f(N/2+2:end)-1;
F = f .* Fs; 

for a = 1:2:(size(PassBands,2))     %Create the desiored peace wise function to approximate with.
Hdr = Hdr + (abs(F) > PassBands(a) & abs(F) < PassBands(a+1))*10.^(PassGain(a+1)/20);
end

%%

Hd = Hdr.*exp(-j*2*pi*f*((M-1)/2));     %Adding a constant delay to make impulse responce symmetric.
hd = ifft(Hd);

assert(max(imag(hd)) == 0,'The design dose not have linear phase');

h = hd(1:M).*Window_num';   %Apply the chosen windowing function. 

H = fft(h,N);       %Calculate the approximated result and plot it for varification.

%%

figure; clf;
hold on;
plot(F,20*log10(abs(H)));
title('Actual Frequency Responce');
xlabel('Frequency (Hz)');
ylabel('Magnitude H(f)');

for a = 1:2:(size(PassBands,2))
    patch([PassBands(a+1) PassBands(a) PassBands(a) PassBands(a+1)],[PassGain(a+1) PassGain(a+1) PassGain(a) PassGain(a)], 0.7*[1,1,1]);
end

for b = 1:2:(size(StopBands,2))
    patch([StopBands(b+1) StopBands(b) StopBands(b) StopBands(b+1)],[StopGain(b+1) StopGain(b+1) StopGain(b) StopGain(b)], 0.7*[1,1,1]);
end
axis([0 Fs/2 min(StopGain) max(20*log10(abs(H)))+10]);

figure; clf;
hold on;
stem(0:M-1,h);
title('Impulse Responce h[n]');
xlabel('Steps [n]');
ylabel('Magnitude h[n]');

