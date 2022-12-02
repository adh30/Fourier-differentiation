% Use Fourier ananlysis to calculate wave intensity
% import pressure as p and velocity as u (ind does this for testing)
t=0.05*(1:length(p));
subplot(4,2,1), plot(t,p)

% Pressure
% Calculate fourier transform
% fftshift reorders the resulting vector to represent negative
% frequencies in the first half of the vector
% plotting only magnitude, not phase
fftp=fftshift(fft(p));
%f=-99:1:100
fp=(-length(p)/2+1:1:length(p)/2)';
subplot(4,2,3), plot(fp,abs(fftp));

% Time derivative in the frequency domain
w=2*pi*fp;
fftdp=fftp.*(1i*w);
subplot(4,2,5), plot(fp,abs(fftdp));

% Inverse FFT
% Although the result should be real ideally, there will be
% small imaginery parts due to numeric inaccuracies, thus plotting
% only the real part
dp=ifft(ifftshift(fftdp));
subplot(4,2,7), plot(t,real(dp));

% Velocity
subplot(4,2,2), plot(t,u)
% Calculate fourier transform
% fftshift reorders the resulting vector to represent negative
% frequencies in the first half of the vector
% plotting only magnitude, not phase
fftu=fftshift(fft(u));
%f=-99:1:100
fu=(-length(u)/2+1:1:length(u)/2)';
subplot(4,2,4), plot(fu,abs(fftu));

% Time derivative in the frequency domain
w=2*pi*fu;
fftdu=fftu.*(1i*w);
subplot(4,2,6), plot(fu,abs(fftdu));

% Inverse FFT
% Although the result should be real ideally, there will be
% small imaginery parts due to numeric inaccuracies, thus plotting
% only the real part
du=ifft(ifftshift(fftdu));
subplot(4,2,8), plot(t,real(du));

% dI
di=real(du).*real(dp);
figure, plot(t,real(di));
