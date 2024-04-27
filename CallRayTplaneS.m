%Computes Complex-ray on the rectangle [-txmax,txmax]x[-tymax,tymax]
%first solve out from orgin and along horizontal strip
%[-txmax,txmax]x[-tymax], then along vertical strips

clear
% close all

mytol = 1e-9;

% branch choice of y0 and p0 -- different signs corresponds
% to a wedge shape Stokes line, which in Lustri linear gave
% transverse waves, while same sign provides almost straight
% line, which in Lustri linear gave longitudinal waves

% Definition of phi0
sstrength = -1;
h = 0.5;
y0sign = 1;
p0sign = 1;

%%%%%%%%%%%% Choose S %%%%%%%%%%%%%%%%%%
s0 = 1e-3 + 1.01*1i;
seps = 0.0015;
s0xshift = seps;
s0yshift = seps;

% Parameter pack
parampack.y0sign = y0sign;
parampack.p0sign = p0sign;
parampack.s0xshift = s0xshift;
parampack.s0yshift = s0yshift;
parampack.sstrength = sstrength;
parampack.h = h;

%%%%%%%%%%%% Choose and mesh domain in t  %%%%%%%%%%%%%%%%%%
txmax = 50;
tymax = 50;
Nx = 100;
Ny = 120;
tmesh = makemesh(txmax, tymax, Nx, Ny);
tzero_index = floor(Nx+1/2);

% outerpath1 = [];
% outerpath2 = [];
% outerpath3 = [];
%
%
% outerpath{1} = tmesh(Nmesh:end,Nmesh).';
% outerpath{2} = tmesh(end,Nmesh:end);
% outerpath{3} = fliplr(tmesh(end,1:Nmesh));


% for i = 1:size(tmesh,2)
%     innerpath{i} = tmesh(1:end,i)';
% end
%
% total = 3*length(outerpath{1})+size(tmesh,2)*length(innerpath{1});

%%%%%%%%%%%%%%%%% prepare matrices for storage %%%%%%%%%%%%%%%%%%%%%%%%%
Nsys = 6;
xmat = 0*tmesh;
ymat = 0*tmesh;
pmat = 0*tmesh;
qmat = 0*tmesh;
chimat = 0*tmesh;
wmat = 0*tmesh;

%% Solve t-plane from (0, 0) to lower left then along bottom edge
Y0 = RayODEIC(s0, parampack);
soldiag = SolveRayLine(0, tmesh(end,1), Y0, parampack);

Y0 = soldiag.y(:, end);
t0 = tmesh(end,1);
t1 = tmesh(end,end);
solbottom = SolveRayLine(t0, t1, Y0, parampack);

Y0bottom = zeros(Nsys, size(tmesh, 2));
gaminv = @(t) (t - t0)/(t1 - t0);
for j = 1:size(tmesh,2)
    yy = deval(solbottom, gaminv(tmesh(end,j)));
    Y0bottom(:, j) = yy;
end

%% Solve along vertical strips
parfor ix = 1:size(tmesh,2)    
    t0 = tmesh(end, ix);
    t1 = tmesh(1, ix);
    Y0 = Y0bottom(:, ix);
    sol = SolveRayLine(t0, t1, Y0, parampack);    
    
    gaminv = @(t) (t - t0)/(t1 - t0);
    yy = deval(sol, gaminv(tmesh(:,ix)));
    
    xmat(:,ix) = yy(1,:);
    ymat(:,ix) = yy(2,:);
    pmat(:,ix) = yy(3,:);
    qmat(:,ix) = yy(4,:);
    chimat(:,ix) = yy(5,:);    
    wmat(:,ix) = yy(6,:);
end

%% Plot

[Cx, hx] = contour(real(tmesh), imag(tmesh), imag(xmat), 'b','LineWidth', 2); 
hold on;
[Cy, hy] = contour(real(tmesh), imag(tmesh), imag(ymat), [0 1], 'r','LineWidth', 2); 
[Cchi, hchi] = contour(real(tmesh), imag(tmesh), imag(chimat), [0 0], 'k','LineWidth', 2); 



tt = InterX(Cx(:,2:end),Cy(:,2:end));
tt1 = tt(1);
tt2 = tt(2);
xx = interp2(real(tmesh),imag(tmesh),xmat,tt1,tt2);
yy = interp2(real(tmesh),imag(tmesh),ymat,tt1,tt2);
chichi = interp2(real(tmesh),imag(tmesh),chimat,tt1,tt2);


resultpack.d = sstrength;
resultpack.s = s0;
resultpack.t = tt1+1i*tt2;
resultpack.x = xx;
resultpack.y = yy;
resultpack.chi = chichi;
resultpack
%%%%%%%%%%%%%%%%% plot %%%%%%%%%%%%%%%%%%%%%%%%%
% plot_brutefigs



