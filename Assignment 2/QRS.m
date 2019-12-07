function [bpm,nob] = QRS(s)
%clear all;
load(s);
syms z;
Fs=360;%sampling frequency
T=1/Fs;%sampling period
base=0;
gain=200;
val=(val-base)/gain;
data=val(1,:);
l=length(data);
t=0:T:(l-1)*T;
data=data./max(data);%Normalisation
figure
subplot(6,1,1);
xlabel('t(s)');
plot(t,data);
title(s);
grid on;
xlim([0,10]);
%% Low pass
Hzlp= ((1-z^(-6))/(1-z^(-1)))^2;%Transfer function of low pass used
blp=[1 0 0 0 0 0 -2 0 0 0 0 0 1];
alp=[1 -2 1];
lpf=filter(blp,alp,data);
% figure
% plot(t,lpf);

%% High pass
Hzhp= ((-1+32*z^(-16)+z^(-32))/(1+z^(-1)));%Transfer function of high pass used
bhp([1,2,17,33])=[-1,0,32,1];
ahp=[1 1];
hpf=filter(bhp,ahp,lpf);
hpf=hpf./max(hpf);%Normalisation
%figure
subplot(6,1,2)
plot(t,hpf);
xlabel('t(s)');
title('BandPass')
grid on;
xlim([0,10]);

%% Derivative
Hzd=(0.1)*(2+z^(-1)-z^(-3)-2*z^(-4));%Transfer function differentiator
% d=zeros(1,l);
% for i=3:l-2
%     d(i)=(1/(8*T))*(-hpf((i-2))-2*hpf((i-1))+2*hpf((i+1))+hpf((i+2)));
% end
bd=0.1*[2,1,0,-1,-2];
ad=1;
d=filter(bd,ad,hpf);
d=d./max(d);%Normalisation
subplot(6,1,3);
%figure
plot(t,d);
xlabel('t(s)');
title('Derivative')
grid on;
xlim([0,10]);
%% Squaring Function
sq=d.^2;
sq=sq./max(sq);%Normalisation
subplot(6,1,4);
%figure
plot(t,sq);
title('Squaring function')
xlabel('t(s)');
grid on
xlim([0,10]);

%% Moving Window Integrator
N=(3*Fs)/20;
% y=zeros(1,l);
% for j=N:l
%     for k=0:N-1
%         y(j)=y(j)+sq(j-k);
%     end
% end
bi=(1/N).*ones(1,N);
ai=1;
y=filter(bi,ai,sq);
y=y./max(y);%Normalisation
subplot(6,1,5);
%figure
plot(t,y);
xlabel('t(s)');
title('Moving Window Integration')
grid on;
xlim([0,10]);
%% Threshold
subplot(6,1,6);
m=max(y(1:40000));
findpeaks(y,t,'MinPeakHeight',0.045*m,'MinPeakProminence',0.0145);
title('Peaks')
axis([0 10 0 0.4]);
xlabel('t(s)');
[pks,locs]=findpeaks(y,t,'MinPeakHeight',0.045*m,'MinPeakProminence',0.0145);
avg=mean(diff(locs));
bpm=60/avg;
nob=length(locs);
%fprintf('Beats per minute: %f\n', bpm);
%fprintf('No. of Beats: %d\n',nob);
end