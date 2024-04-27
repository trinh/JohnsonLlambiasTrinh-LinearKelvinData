% Generate the initial conditions from the singularity in the nonlinear
% source problem
function Y0 = RayODEIC(s, parampack)

y0sign = parampack.y0sign;
p0sign = parampack.p0sign; 
s0xshift = parampack.s0xshift; 
s0yshift = parampack.s0yshift;
SS = parampack.sstrength;
h = parampack.h;

UF = 1;

x0 = s + s0xshift;
y0 = y0sign*1i*sqrt(s^2 + h^2) + s0yshift;     % IC for y
y0s = -x0/y0;  % dy0/ds

%     gradphi0 = nlgradphi0(ufstrength,sstrength,x0,y0);
%     phi0x = gradphi0(1);
%     phi0y = gradphi0(2);
%     f10 = sstrength/(2*pi*(x0^2 + y0^2 + h^2)^(1/2));
singfunc = (x0^2+y0^2+h^2)^(1/2);
phi0 = UF*x0 + SS/(2*pi*singfunc); 
phi0x = UF - SS*x0/(2*pi*singfunc^3); 
phi0y = - SS*y0/(2*pi*singfunc^3);

p0 = p0sign*1i*y0s*sqrt(1 + y0s^2)/(y0s*phi0x - phi0y)^2;   % IC for p, q from Lustri (5.27)
q0 = -p0/y0s;                      

% Linear conditions
p0 = p0sign*1i*y0s*sqrt(1 + y0s^2)/(y0s)^2;
q0 = -p0/y0s;

Y0 = [ ...
        x0, ...
        y0, ...
        p0, ...
        q0, ...
        0, ...
        singfunc];
end