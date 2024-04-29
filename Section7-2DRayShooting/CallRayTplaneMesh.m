%Computes Complex-ray on the rectangle [-txmax,txmax]x[-tymax,tymax]
%first solve out from orgin and along horizontal strip
%[-txmax,txmax]x[-tymax], then along vertical strips

clear
close all

mytol = 1e-9;

% branch choice of y0 and p0 -- different signs corresponds
% to a wedge shape Stokes line, which in Lustri linear gave
% transverse waves, while same sign provides almost straight
% line, which in Lustri linear gave longitudinal waves

% Definition of phi0
sstrength = -0.000001;
h = 0.5;
y0sign = 1;
p0sign = 1;

%%%%%%%%%%%% Choose S %%%%%%%%%%%%%%%%%%

s1lower = -1;
s1upper  = 0;
s2lower = 0;
s2upper = -2;

Ns1 = 100;
Ns2 = 200;
[sx, sy] = meshgrid(linspace(s1lower,s1upper, Ns1), linspace(s2upper, s2lower, Ns2));

S = sx + 1i*sy;



s0 = (sqrt(2))*exp(1i*pi/2);
seps = 0.015;
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

txmax = 50;
tymax = 50;
Nx = 20;
Ny = 20;
tmesh = makemesh(txmax, tymax, Nx, Ny);
tzero_index = floor(Nx+1/2);



ndone = 0;
total = Ns1*Ns2;

for k = 1:size(S, 2)
    for j = 1:size(S,1)
        
        %% prepare matrices for storage
        Nsys = 6;
        xmat = 0*tmesh;
        ymat = 0*tmesh;
        pmat = 0*tmesh;
        qmat = 0*tmesh;
        chimat = 0*tmesh;
        wmat = 0*tmesh;
        
        %% Solve t-plane from (0, 0) to lower left then along bottom edge
        s0  = S(j,k);
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
        
        %% Plot
%         
        [Cx, hx] = contour(real(tmesh), imag(tmesh), imag(xmat), [0 0], 'b','LineWidth', 2);
        hold on;
        [Cy, hy] = contour(real(tmesh), imag(tmesh), imag(ymat), [0 0], 'r','LineWidth', 2);
        [Cchi, hchi] = contour(real(tmesh), imag(tmesh), imag(chimat), [0 0], 'k','LineWidth', 2);
        
        % get contour data
        
%         Cx = contourc(real(tmesh), imag(tmesh), imag(xmat));
%         Cy = contourc(real(tmesh), imag(tmesh), imag(ymat));
%         Cchi = contourc(real(tmesh), imag(tmesh), imag(xmat));
        %% Store real-space intersection results
        
        tt = InterX(Cx(:,2:end),Cy(:,2:end));
        if isempty(tt) == 0 %intersection found
            
            tt1 = tt(1);
            tt2 = tt(2);
            xx = interp2(real(tmesh),imag(tmesh),xmat,tt1,tt2);
            yy = interp2(real(tmesh),imag(tmesh),ymat,tt1,tt2);
            chichi = interp2(real(tmesh),imag(tmesh),chimat,tt1,tt2);
            
            if abs(real(xx))<=5 && abs(real(yy))<=5
            
            TT(j,k) = tt1+1i*tt2;
            XX(j,k) = xx;
            YY(j,k) = yy;
            CHICHI(j,k) = chichi;
            else
            TT(j,k) = NaN;
            XX(j,k) = NaN;
            YY(j,k) = NaN;
            CHICHI(j,k) = NaN;
            end
        else %no intersection found
            TT(j,k) = NaN;
            XX(j,k) = NaN;
            YY(j,k) = NaN;
            CHICHI(j,k) = NaN;
        end
        ndone = ndone+1;
        percentage = ndone/(total)*100;

        if total>1000
        if ceil(ndone/10) == ndone/10
                    disp([num2str(percentage), '%']);
        end
        else
                    disp([num2str(percentage), '%']);
        end
        
    end
end
%% save data

name = ['./data/sx',num2str(s1lower),'_',num2str(s1upper),'sy',...
    num2str(s2lower),'_', num2str(s1upper),'N',num2str(Ns1),'.mat'];
save(name);


%% plots


% figure(2);figshift
% contour(real(XX),real(YY), imag(CHICHI),[0 0], 'k')
% xlabel('x')
% ylabel('y')
% 
figure(3);figshift
surf(real(XX),real(YY), real(CHICHI))
xlabel('x')
ylabel('y')
zlabel('Re(chi)')


figure(4);figshift
contour(real(XX),real(YY), real(CHICHI))
xlabel('x')
ylabel('y')


% figure(5);figshift
% surf(real(XX),real(YY), imag(CHICHI))
% xlabel('x')
% ylabel('y')
% zlabel('Im(chi)')



figure(6);figshift
surf(real(S(5:end,8:end)),imag(S(5:end,8:end)), real(XX(5:end,8:end)))
xlabel('Re(s)')
ylabel('Im(s)')




figure(7);figshift
surf(real(XX),real(YY), imag(CHICHI))
xlabel('x')
ylabel('y')
zlabel('Re(chi)')


