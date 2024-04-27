% Definition of Charpit equations + Stokes surface evolution for nonlinear
% source problem
%
%   This specifies differential equations for dx/dt, dy/dt, dp/dt ...
%   w = (x^2 + y^2 + h^2)^(1/2)
%   wt = x*xt/w + y*yt/w
function F = RayODEfunc(t, Y, parampack)        
    
    x = Y(1);
    y = Y(2);
    p = Y(3);
    q = Y(4);
    chi = Y(5);  
    w = Y(6);
    
    F = 0*Y;
    
    [phi0x, phi0y, phi0xx, phi0xy, phi0yy] = phi0func2(x, y, w, parampack);
    phi0x = 1;
    phi0y = 0;
    phi0xx = 0;
    phi0xy = 0;
    phi0yy = 0;

    Delta = p*phi0x + q*phi0y;
    chip = -2*(p^2 + q^2);    
    
    %Charpit's eqns  
    F = zeros(6, 1);
    F(1) = (2*p + 4*phi0x*Delta^3);
    F(2) = (2*q + 4*phi0y*Delta^3);
    F(3) = -4*Delta^3*(p*phi0xx + q*phi0xy);
    F(4) = -4*Delta^3*(p*phi0xy + q*phi0yy);
    F(5) = chip; 
    F(6) = x*F(1)/w + y*F(2)/w;
end