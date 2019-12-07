clc;
clear all;
%message frequency
fm=3; 
%carrier frequency
fc=100; %carrier frequency
wm=2*pi*fm;
wc=2*pi*fc;
t=-20:0.0001:20;  
%Amplitude of message wave
A=5;
%Message Signal
m=A*cos(wm*t);
%axis([-0.01 0.01 -2 2]);
%Carrier Signal
c=cos(wc*t);
%subplot(3,2,1);
plot(t,m);
grid on;
axis([-0.5 0.5 -6 6]);
xlabel('Time(s)');
ylabel('Amplitude');
title('Message Signal');
%subplot(3,2,2);
figure
plot(t,c);
grid on;
axis([-0.5 0.5 -6 6]);
xlabel('Time(s)');
ylabel('Amplitude');
title('Carrier Signal');


%Modulation
mod=c.*m;
%subplot(3,2,3);
figure
plot(t,m,'b');
hold on
plot(t,mod,'r');
hold on
plot(t,-m,'b');
grid on;
xlabel('Time(s)');
ylabel('Amplitude');
legend('m(t)','c(t)')
title('Modulated Signal');
axis([-0.5 0.5 -6 6]);


%Demodulation
dem=mod.*c;
%subplot(3,2,4);
figure
plot(t,dem);
grid on;
xlabel('Time(s)');
ylabel('Amplitude');
title('Demodulated Signal');
axis([-0.5 0.5 -6 6]);
%Passing through low pass filter
%Butterworth filter is used
[b,a]=butter(3,0.001);
y=filter(b,a,dem);
%subplot(3,2,5);
figure
plot(t,2*y);
grid on
xlabel('Time(s)');
ylabel('Amplitude');
title('Retrieved Message Signal');
axis([-0.5 0.5 -6 6]);
figure
plot(t,2*y);
grid on
xlabel('Time(s)');
ylabel('Amplitude');
title('Retrieved Message Signal');
axis([-20 -18 -6 6]);