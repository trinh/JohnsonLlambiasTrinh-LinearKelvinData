
function dK  = dKfunc(phi,r,theta,z,h)
dK = (1i*r*(sin(2*phi-theta)+3*sin(theta))+ 4*sin(phi)*(z - h))./(2*(cos(phi)).^3);
end