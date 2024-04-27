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

figure(8);figshift
hold on
plot3(real(XX),real(YY),imag(CHICHI),'r')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('imag(chi)')

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

figure(8);figshift
hold on
plot3(real(XX),real(YY),imag(CHICHI),'b')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('imag(chi)')
%
load('../data/walks/linear/pneg/w1+0.001i_L6_N12000.mat');
figure(6);
hold on
plot(real(SS),imag(SS),'y')
xlabel('Re(s)')
ylabel('Im(s)')

figure(7);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'y')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

figure(8);figshift
hold on
plot3(real(XX),real(YY),imag(CHICHI),'y')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('imag(chi)')

%
load('../data/walks/linear/pneg/w1-0.001i_L6_N12000.mat');
figure(6);
hold on
plot(real(SS),imag(SS),'Color', [0.5 0.5 0.5])
xlabel('Re(s)')
ylabel('Im(s)')

figure(7);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'Color', [0.5 0.5 0.5])
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

figure(8);figshift
hold on
plot3(real(XX),real(YY),imag(CHICHI),'Color', [0.5 0.5 0.5])
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('imag(chi)')

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

figure(8);figshift
hold on
plot3(real(XX),real(YY),imag(CHICHI),'color',maroon)
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('imag(chi)')


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

figure(8);figshift
hold on
plot3(real(XX),real(YY),imag(CHICHI),'c')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('imag(chi)')

%
load('../data/walks/linear/pneg/w-1+0.001i_L6_N12000.mat');

figure(6);
hold on
plot(real(SS),imag(SS),'g')
xlabel('Re(s)')
ylabel('Im(s)')

figure(7);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'g')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

figure(8);figshift
hold on
plot3(real(XX),real(YY),imag(CHICHI),'g')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('imag(chi)')

%
load('../data/walks/linear/pneg/w-1-0.001i_L6_N12000.mat');
figure(6);
hold on
plot(real(SS),imag(SS),'m')
xlabel('Re(s)')
ylabel('Im(s)')

figure(7);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'m')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')

figure(8);figshift
hold on
plot3(real(XX),real(YY),imag(CHICHI),'m')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('imag(chi)')


%% Pretty

figure(6)
box on
xlabel('');
ylabel('');
export_fig 'ray_splane_plusmin.pdf'

figure(7)
view([-55, 40]);
grid on
box on
axis equal
xlabel('');
ylabel('');
zlabel('');
export_fig 'ray_xyrealchi_plusmin.pdf'

figure(8)
% view([-40, 10]);
view([-55, 40]);
grid on
box on
axis equal
xlabel('');
ylabel('');
zlabel('');
export_fig 'ray_xyimagchi_plusmin.pdf'
