
function K  = Kfunc(phi,r,theta,z,h)
K = (1i*r*cos(phi-theta)+ z - h)./((cos(phi)).^2);
end