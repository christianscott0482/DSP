N = 1024;
Fs = 50e+3;
n = 0:N-1;
f_0 = 20e+3;
theta = 2;
input_re = cos(2.*pi.*(f_0./Fs).*(n + theta));
input_im = 0.*n;

input = input_re + 1j.*input_im;
output = fft(input, N);

figure(1);
clf;
plot(n, output);