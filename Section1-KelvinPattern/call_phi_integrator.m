% Code to compute the source problem by direct integration
%
% Dates: 2019-05-08 original writing
%        2020-22: updates to include depth implementation

clear
close all

regen = 0;

if regen == 1

    x = linspace(0.1, 15, 30);
    y = linspace(0.1, 7, 30);
    [X, Y] = meshgrid(x, y);
    [TH, R] = cart2pol(X, Y);


    h = 1;
    ep = 0.5;
    umax = 50;
    myeps = 1e-5;
    mytol = 1e-4;

    Z = linspace(0,-1,10);

    for jz = 1:length(Z)
        z = Z(jz);
        XItmp = 0*R;
        for jx = 1:length(x)
            disp(['z:', num2str(jz), 'of', num2str(length(Z)) 'x:', num2str(jx), 'of', num2str(length(x))])
            for jy = 1:length(y)

                r = R(jy, jx);
                th = TH(jy, jx);

                G = @(u, ph) -1/(4*pi^2)*u*ep ...
                    .*exp((1i*u.*r.*cos(th-ph) + u.*(z-h))./(cos(ph).^2)) ...
                    ./((1 - ep*u).*cos(ph).^2);

                [D1, err1] = quad2d(G, 0, 1/ep - myeps, 0, 2*pi, 'Singular', true, 'AbsTol', mytol, 'RelTol', mytol);
                [D2, err2] = quad2d(G, 1/ep + myeps, umax, 0, 2*pi, 'Singular', true, 'AbsTol', mytol, 'RelTol', mytol);

                PHItmp(jy, jx) = D1 + D2;


            end
        end

        PHI{jz} = PHItmp;
    end

    %% Save data
    save('Output_phi_integrator_2024Jan.mat');

else
    load('Output_phi_integrator_2024Jan.mat');
end


%% Plot various cross sections in 'z'
for jz = 1:length(Z)
    figure(jz)
    contourf(X,Y,real(PHI{jz}))
    xlabel('x'); xlabel('y');
    title(['z = ', num2str(Z(jz))])
end

