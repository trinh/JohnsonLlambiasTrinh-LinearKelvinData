function mesh = makemesh(txmax, tymax, Nx, Ny)
    
[tx, ty] = meshgrid(linspace(0, txmax, Nx), linspace( tymax,0, Ny));

T1 = tx+1i*ty;

[tx, ty] = meshgrid(linspace( -txmax,0, Nx), linspace(tymax, 0, Ny));
T2  = tx+1i*ty;

[tx, ty] = meshgrid(linspace(-txmax,0, Nx), linspace(0,-tymax, Ny));

T3 = tx+1i*ty;

[tx, ty] = meshgrid(linspace(0, txmax, Nx), linspace(0, -tymax, Ny));

T4 = tx+1i*ty;

upper = [T2, T1(:,2:end)];
lower = [T3(2:end,:), T4(2:end,2:end)];
mesh  = [upper;lower];
end