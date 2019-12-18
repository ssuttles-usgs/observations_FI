function sf=iwaveslp(s,fs,Tpass)
%function sf=iwaveslp(s,fs)
%
%m-fcn to lowpass filter waves 
%
%INPUT
% s = signal input (u,v,w, or press);
% fs = sampling frequency (Hz)
% Tpass = shortest wave period to pass (s)
%
%OUTPUT
% sf - bandpass filtered signal (same units as input)

N= 2; %filter order
Ny=fs/2; %Nyquist Freq (Hz)

Wn=[1/(Tpass*Ny)]; %bandpass frequencies normalized by Nyquist

[b,a]=butter(N,Wn);

sf=filtfilt(b,a,s);
