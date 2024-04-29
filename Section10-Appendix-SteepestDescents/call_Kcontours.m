% Generation of steepest descent contours used in the analysis of the
% Kelvin integral problem

clear
close all


h = 1;
ph1lim = 10;
ph2lim = 4;
Nph1 = 2000;
Nph2 = 2000;
ph1 = linspace(-4,ph1lim, Nph1);%make sure to miss x = 0
ph2 = linspace(-ph2lim,ph2lim,Nph2);
% x = 0.1;
x = 0.1;
y = 1;
rcrit  = abs(x+1i*y);
thcrit = angle(x+1i*y);
theta = pi/2+0.1;
r = 1;
thth = pi/2 + linspace(-0.1,0.1,5);
rr = r*ones(size(thth));

[PH1,PH2] = meshgrid(ph1,ph2);
PH2=-PH2;
phimesh = PH1+1i*PH2;
z=0;

 
%%
guesss(1) = -0.0854143 - 1.61364*1i;
guess(2) = -0.0145857 + 0.401327*1i;
guess(3) = 3.05618 + 1.61364*1i;
guess(4) = 3.12701 - 0.401327*1i;

opts = optimset('Diagnostics','off', 'Display','off');
sad(1) = fsolve(@(phi) dKfunc(phi,r,theta,z,h),guess(1), opts);
sad(2) = fsolve(@(phi) dKfunc(phi,r,theta,z,h),guess(2),opts);
sad(3) = fsolve(@(phi) dKfunc(phi,r,theta,z,h),guess(3),opts);
sad(4) = fsolve(@(phi) dKfunc(phi,r,theta,z,h),guess(4),opts);
%%

K = Kfunc(PH1+1i*PH2,r, theta, z, h);

K0 = Kfunc(0,r, theta, z, h)*ones(size(K));
K2pi = Kfunc(2*pi,r, theta, z, h)*ones(size(K));
for ii = 1:length(sad)
Ksad{ii} = Kfunc(sad(ii),r, theta, z, h)*ones(size(K));
Csad{ii} = contourc(real(phimesh(1,:)), imag(phimesh(:,1)), imag(K-Ksad{ii}), [0 0]);
end
C0 = contourc(real(phimesh(1,:)), imag(phimesh(:,1)), imag(K-K0), [0 0]);

% C2pi = contourc(real(phimesh(1,:)), imag(phimesh(:,1)), imag(K-K2pi), [0 0]);

%%
C0 = cleancont(C0,4);
for ii = 1:length(sad)
Csad{ii} = cleancont(Csad{ii},4);
end
% C2pi = cleancont(C2pi,4);

%%

C0c = cleancont(C0,20);

%%
reK0 = Kfunc(C0(1,:)+1i*C0(2,:),r, theta, z, h);
for ii = 1:length(sad)
resad{ii} = Kfunc(Csad{ii}(1,:)+1i*Csad{ii}(2,:),r, theta, z, h);
end
absI = abs(Ifunc(C0(1,:)+1i*C0(2,:),r,theta,z,h,0.3));
%%
%contour isn't very good near phi = pi/2, so let's just throw out those
%values which aren't on the true contour

for ii = size(reK0,2):-1:1
    %     if ii == 3589
    %         keyboard
    %     end
    if abs(imag(reK0(1,ii)-K0(ii)))>0.0001
        C0(:,ii) = [];
        reK0(ii) = [];
        absI(ii) = [];
    end
end

for jj = 1:length(sad)
for ii = size(resad{jj},2):-1:1
    %     if ii == 3589
    %         keyboard
    %     end
    if abs(imag(resad{jj}(1,ii)-Ksad{jj}(ii)))>0.01
        Csad{jj}(:,ii) = [];
        resad{jj}(ii) = [];
    end
end
end

% for ii = size(reK0,2):-1:1
% %     if ii == 3589
% %         keyboard
% %     end
%     if abs(absI(ii))>1e5
%         C0(:,ii) = [];
%         reK0(ii) = [];
%         absI(ii) = [];
%     end
% end


%%
% figure(1)
% hold on
% plot(C0(1,:),C0(2,:),'.')
% % plot(C2pi(1,:),C2pi(2,:),'.')
% for i = 1:4
% plot(real(sad(i)),imag(sad(i)),'k*')
% end
% plot(0,0,'b*')
% plot(2*pi,0,'b*')
% % contourf(ph1,ph2,real(K))
% Log modulus transform
  

figure(2)
hold on

tmp1 = real(reK0);
    logre1 = sign(tmp1).*log10(abs(tmp1) + 1);
plot3(C0(1,:),C0(2,:),logre1,'g*', 'Markersize' , 2)
for ii = 1:length(sad)
    tmp2 = real(resad{ii});
    logre2 = sign(tmp2).*log10(abs(tmp2) + 1);
 plot3(Csad{ii}(1,:),Csad{ii}(2,:),logre2,'r.');
end

% pointsize = 10;
% scatter(C0(1,:), C0(2,:), pointsize, real(reK0));
% colorbar
tmp3 = real(Kfunc(0,r, theta, z, h));
    logre3 = sign(tmp3).*log10(abs(tmp3) + 1);
plot3(0,0,logre3,'ko', 'Markersize',10)
tmp4 = real(Kfunc(0,r, theta, z, h));
    logre4 = sign(tmp4).*log10(abs(tmp4) + 1);
plot3(2*pi,0,logre4, 'ko', 'Markersize',10,'HandleVisibility','off')


ksad(1) =  Kfunc(sad(1),r, theta, z, h);
plot(real(sad(1)),imag(sad(1)),'r*', 'Markersize',8)
for i = 1:4
    tmp5 = real(Kfunc(sad(i),r, theta, z, h));
    logre5 = sign(tmp5).*log10(abs(tmp5) + 1);
    plot3(real(sad(i)),imag(sad(i)),logre5,'r*', 'Markersize' , 9,'HandleVisibility','off')
end
plot((-2+1/2)*pi,0,'b*', 'Markersize' , 8)
for i = -1:2
    plot((i+1/2)*pi,0,'b*', 'Markersize' , 8,'HandleVisibility','off')
end
title('r = 1, theta = pi/2+0.1')
xlabel('real(phi)')
ylabel('imag(phi)')
zlabel('log(real(K))')
legend('descent contour','endpoints','saddles', 'branch singularities')
%%


figure(3)
hold on
plot3(C0(1,:),C0(2,:),real(reK0),'g*', 'Markersize' , 2)
for ii = 1:length(sad)
 plot3(Csad{ii}(1,:),Csad{ii}(2,:),real(resad{ii}),'r.');

end

% pointsize = 10;
% scatter(C0(1,:), C0(2,:), pointsize, real(reK0));
% colorbar
plot3(0,0,real(Kfunc(0,r, theta, z, h)),'ko', 'Markersize',10)
plot3(2*pi,0,real(Kfunc(2*pi,r, theta, z, h)), 'ko', 'Markersize',10,'HandleVisibility','off')

ksad(1) =  Kfunc(sad(1),r, theta, z, h);
plot(real(sad(1)),imag(sad(1)),'r*', 'Markersize',8)
for i = 1:4
    ksad(i) =  Kfunc(sad(i),r, theta, z, h);
    plot3(real(sad(i)),imag(sad(i)),real(ksad(i)),'r*', 'Markersize' , 9,'HandleVisibility','off')
end
plot((-2+1/2)*pi,0,'b*', 'Markersize' , 8)
for i = -1:2
    plot((i+1/2)*pi,0,'b*', 'Markersize' , 8,'HandleVisibility','off')
end
title('r = 1, theta = pi/2+0.1')
xlabel('real(phi)')
ylabel('imag(phi)')
zlabel('real(K)')
legend('descent contour','endpoints','saddles', 'branch singularities')

%%


% figure(3)
% hold on
% plot3(C0(1,:),C0(2,:),absI,'*', 'Markersize' , 2)
% plot(0,0,'k*')
% plot(2*pi,0,'k*')
% for i = 1:4
% plot(real(sad(i)),imag(sad(i)),'r*', 'Markersize' , 8)
% end
% title('abs(integrand)')
%
% for i = -2:2
% plot((i+1/2)*pi,0,'b*', 'Markersize' , 8)
% end