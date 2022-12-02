% Generate 10Hz-sinus sampled with 100Hz
t=0:0.01:1;
a=sin(2*pi*10*t);
subplot(4,1,1), plot(t,a)

% Calculate fourier transform
% fftshift reorders the resulting vector to represent negative
% frequencies in the first half of the vector
% plotting only magnitude, not phase
b=fftshift(fft(a));
f=-50:1:50;
subplot(4,1,2), plot(f,abs(b));

% Time derivative in the frequency domain
w=2*pi*f;
c=b.*(1i*w);
subplot(4,1,3), plot(f,abs(c));

% Inverse FFT
% Although the result should be real ideally, there will be
% small imaginery parts due to numeric inaccuracies, thus plotting
% only the real part
d=ifft(ifftshift(c));
subplot(4,1,4), plot(t,real(d));