function sol = SolveRayLine(t0, t1, Y0, parampack)

mytol = 1e-6;
options = odeset('RelTol', mytol, 'AbsTol', mytol);

gam = @(u) t0 + u*(t1 - t0);
dgam = t1 - t0;

fwd = @(u, Y) dgam*RayODEfunc(gam(u), Y, parampack);

sol = ode45(fwd, [0, 1], Y0, options);
end
