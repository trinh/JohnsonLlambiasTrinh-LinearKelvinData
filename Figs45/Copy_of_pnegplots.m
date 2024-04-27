close all


%
load('../data/walks/linear/pneg/w0.001+1.01i_L6_N12000.mat');
figure(6);
hold on
plot(real(SS),imag(SS),'r')
xlabel('Re(s)')
ylabel('Im(s)')

figure(7);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'r')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

% figure(8);figshift
% hold on
% plot3(real(XX),real(YY),imag(CHICHI),'r')
% xlabel('Re(x)')
% ylabel('Re(y)')
% zlabel('imag(chi)')

%
load('../data/walks/linear/pneg/w0.001-1.01i_L6_N12000.mat');
figure(6);
hold on
plot(real(SS),imag(SS),'b')
xlabel('Re(s)')
ylabel('Im(s)')

figure(7);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'b')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

% figure(8);figshift
% hold on
% plot3(real(XX),real(YY),imag(CHICHI),'b')
% xlabel('Re(x)')
% ylabel('Re(y)')
% zlabel('imag(chi)')
%
load('../data/walks/linear/pneg/w1+0.001i_L6_N12000.mat');
figure(6);
hold on
plot(real(SS),imag(SS),'y')
xlabel('Re(s)')
ylabel('Im(s)')

figure(8);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'y')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

% figure(8);figshift
% hold on
% plot3(real(XX),real(YY),imag(CHICHI),'y')
% xlabel('Re(x)')
% ylabel('Re(y)')
% zlabel('imag(chi)')

%
load('../data/walks/linear/pneg/w1-0.001i_L6_N12000.mat');
figure(6);
hold on
plot(real(SS),imag(SS),'k')
xlabel('Re(s)')
ylabel('Im(s)')

figure(8);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'k')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

% figure(8);figshift
% hold on
% plot3(real(XX),real(YY),imag(CHICHI),'k')
% xlabel('Re(x)')
% ylabel('Re(y)')
% zlabel('imag(chi)')

%
load('../data/walks/linear/pneg/w-0.001+1.01i_L6_N12000.mat');
maroon=([0.6350, 0.0780, 0.1840]);
figure(6);
hold on
plot(real(SS),imag(SS),'color',maroon)
xlabel('Re(s)')
ylabel('Im(s)')

figure(7);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'color',maroon)
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

% figure(8);figshift
% hold on
% plot3(real(XX),real(YY),imag(CHICHI),'color',maroon)
% xlabel('Re(x)')
% ylabel('Re(y)')
% zlabel('imag(chi)')


%
load('../data/walks/linear/pneg/w-0.001-1.01i_L6_N12000.mat');
figure(6);
hold on
plot(real(SS),imag(SS),'c')
xlabel('Re(s)')
ylabel('Im(s)')

figure(7);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'c')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

% figure(8);figshift
% hold on
% plot3(real(XX),real(YY),imag(CHICHI),'c')
% xlabel('Re(x)')
% ylabel('Re(y)')
% zlabel('imag(chi)')

%
load('../data/walks/linear/pneg/w-1+0.001i_L6_N12000.mat');

figure(6);
hold on
plot(real(SS),imag(SS),'g')
xlabel('Re(s)')
ylabel('Im(s)')

figure(8);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'g')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

% figure(8);figshift
% hold on
% plot3(real(XX),real(YY),imag(CHICHI),'g')
% xlabel('Re(x)')
% ylabel('Re(y)')
% zlabel('imag(chi)')

%
load('../data/walks/linear/pneg/w-1-0.001i_L6_N12000.mat');
figure(6);
hold on
plot(real(SS),imag(SS),'m')
xlabel('Re(s)')
ylabel('Im(s)')

figure(8);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'m')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

% figure(8);figshift
% hold on
% plot3(real(XX),real(YY),imag(CHICHI),'m')
% xlabel('Re(x)')
% ylabel('Re(y)')
% zlabel('imag(chi)')