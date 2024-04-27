function sol = ShootSingleS(s0)


mytol = 1e-9;

% branch choice of y0 and p0 -- different signs corresponds
% to a wedge shape Stokes line, which in Lustri linear gave
% transverse waves, while same sign provides almost straight
% line, which in Lustri linear gave longitudinal waves

% Definition of phi0
sstrength = -0.3;
h = 1;
y0sign = 1;
p0sign = -1;

%%%%%%%%%%%% Choose S %%%%%%%%%%%%%%%%%%

seps = 0.000015;
s0xshift = seps;
s0yshift = seps;

%% Parameter pack
parampack.y0sign = y0sign;
parampack.p0sign = p0sign;
parampack.s0xshift = s0xshift;
parampack.s0yshift = s0yshift;
parampack.sstrength = sstrength;
parampack.h = h;

%% Choose and mesh domain in t

txmax = 100;
tymax = 100;
Nx = 30;
Ny = 30;
tmesh = makemesh(txmax, tymax, Nx, Ny);
tzero_index = floor(Nx+1/2);



ndone = 0;
% total = Ns1*Ns2;


%% prepare matrices for storage
Nsys = 6;


%% Solve t-plane from (0, 0) to lower left then along bottom edge
Y0 = RayODEIC(s0, parampack);
soldiag = SolveRayLine(0, tmesh(end,1), Y0, parampack);

Y0 = soldiag.y(:, end);
t0 = tmesh(end,1);
t1 = tmesh(end,end);
solbottom = SolveRayLine(t0, t1, Y0, parampack);

Y0bottom = zeros(Nsys, size(tmesh, 2));
gaminv = @(t) (t - t0)/(t1 - t0);
for jj = 1:size(tmesh,2)
    yy = deval(solbottom, gaminv(tmesh(end,jj)));
    Y0bottom(:, jj) = yy;
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

%% get contour data
[Cx, ~] = contour(real(tmesh), imag(tmesh), imag(xmat), [0 0], 'b','LineWidth', 2);
hold on;
[Cy, ~] = contour(real(tmesh), imag(tmesh), imag(ymat), [0 0], 'r','LineWidth', 2);

%% Store real-space intersection results

tt = InterX(Cx(:,2:end),Cy(:,2:end));
if isempty(tt) == 0 %intersection found
    
    tt1 = tt(1);
    tt2 = tt(2);
    tt = tt1+1i*tt2;
    xx = interp2(real(tmesh),imag(tmesh),xmat,tt1,tt2);
    yy = interp2(real(tmesh),imag(tmesh),ymat,tt1,tt2);
    chichi = interp2(real(tmesh),imag(tmesh),chimat,tt1,tt2);
    if imag(xx)<1e-5 && imag(yy)<1e-5
        xx = real(xx);
        yy = real(yy);
    else
        tt = NaN;
        xx = NaN;
        yy = NaN;
        chichi = NaN;
    end
    
else
    tt = NaN;
    xx = NaN;
    yy = NaN;
    chichi = NaN;
end
sol.t = tt;
sol.x = xx;
sol.y = yy;
sol.chi = chichi;

end




