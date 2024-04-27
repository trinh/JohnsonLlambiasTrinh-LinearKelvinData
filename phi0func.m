function [phi0x, phi0y, phi0xx, phi0xy, phi0yy] = phi0func(x, y, parampack)

ufstrength = 1;
sstrength = parampack.sstrength;
h = parampack.h;

%     gradphi0 = nlgradphi0(ufstrength,sstrength,x,y);
%     phi0x = gradphi0(1);
%     phi0y = gradphi0(2);
%     grad2phi0 = nlgrad2phi0(sstrength,x,y);
%     phi0xx = grad2phi0(1);
%     phi0xy = grad2phi0(2);
%     phi0yy = grad2phi0(3);
%     f1x = -x*f1/(x^2+y^2+h^2);
%     f1y = -y*f1/(x^2+y^2+h^2);
singfunc = (x^2+y^2+h^2)^(1/2);
phi0x = ufstrength - x*sstrength/(2*pi*singfunc^3);%+ f1x;
phi0y = - y*sstrength/(2*pi*singfunc^3);%f1y;

phi0xx = -sstrength/(2*pi*singfunc^3) + 3*sstrength*x^2/(2*pi*singfunc^5);%-f1/(x^2+y^2+h^2) + 3*f1*x^2/((x^2+y^2+h^2)^2);
phi0xy = 3*sstrength*x*y/(2*pi*singfunc^5);%3*f1*x*y/((x^2+y^2+h^2)^2);
phi0yy = -sstrength/(2*pi*singfunc^3) + 3*sstrength*y^2/(2*pi*singfunc^5);%-f1/(x^2+y^2+h^2) + 3*f1*y^2/((x^2+y^2+h^2)^2);