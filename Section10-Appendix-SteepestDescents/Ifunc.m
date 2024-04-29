
function I  = Ifunc(phi,r,theta,z,h,ep)
K = (1i*r*cos(phi-theta)+ z - h)./((cos(phi)).^2);

I = 1./(cos(phi).^2).*exp(K/ep);
end