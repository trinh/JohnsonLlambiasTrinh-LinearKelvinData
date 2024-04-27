% GENERATING THE ANALYTIC EXTENSION OF CHI(X,Y,Z)
%
%   Script accompanying Johnson-Llambias & Trinh to regenerate the Stokes
%   surfaces -- i.e. the chi(x, y, z) values for (x, y, z) in R^3.
%
%   The only parameter value is the source height, set to h = -1

clear
close all

zz = linspace(0,-1,11);
CHIZ = cell(11,4);
H = 0:-0.1:-1;

% Load in the singulant (chi) data within z-slices
for ii = 1:11 %z levels
    if ii == 1
        name = ['./z-0h1.mat'];
    elseif ii == 11
        name = ['./z-1h1.mat'];
    else
        name = ['./z-0',num2str(abs(10*zz(ii))),'h1.mat'];
    end
    load(name)

    CHI = KPHI;
    XX{ii} = X;
    YY{ii} = Y;

    % Iterate through four relevant branches
    for jj = 1:4
        half = size(CHI{jj},1)/2;
        if ii > 4
            CHIZ{ii,jj} = [CHI{jj}(1:half,:)];
            XX{ii} = XX{ii}(1:half,:);
            YY{ii} = YY{ii}(1:half,:);
        else
            CHIZ{ii,jj} = [CHI{jj}];

        end
    end
end


%% Plot chi along slices

figure(4); clf(4);
% We plot the contours of Re(chi) along chosen levels
alpha(0.5)
hold on
for ii = [1 5 10]

    % Combine plots via symmetry of the Y-plane
    Xtemp = XX{ii};
    Ytemp = YY{ii};
    Ztemp = real(CHIZ{ii,2});

    YYY = [Ytemp; -flipud(Ytemp)];
    XXX = [Xtemp; Xtemp];
    ZZZ = [Ztemp; flipud(Ztemp)];

    disp(['Chosen level = ', num2str(H(ii))]);
    surf(XXX,YYY, H(ii) + 0*XXX, ZZZ);
%     surf(XX{ii},YY{ii},H(ii)*ones(size(XX{ii})),real(CHIZ{ii,2}))
%     surf(XX{ii},-YY{ii},H(ii)*ones(size(XX{ii})),real(CHIZ{ii,2}))
    caxis([-4 -1]);
    shading interp
end
view([-70, 30]);
set(gcf, 'Position', [164         452        1215         848]);
box on
grid on

%% Special contours for visualisation

% For visualisation purposes, we select a contour of Re(chi)
% This chosen contour is outlined in the diagram across different
% values of 'z'.
visualise_special = 1;
chosen_level = -2.1;
XY_special = cell(11,4);

if visualise_special == 1

    figure(11); clf(11); % figure is only used temporarily
    for kk = 1:11
        for ii = 1:1
            [XYtmp,~] = contour(XX{kk}, YY{kk}, real(CHIZ{kk,2}), chosen_level*[1, 1], 'r','LineWidth', 2);
            %         [Ctmp,~] = contour(X,Y, imag(CHIZ{kk,2} - CHIZ{kk,3}),[0 0], 'r','LineWidth', 2);
            XY_special{kk,ii} = XYtmp(:,2:end);
        end
    end
    close(11);

    % For visualisation, we may want to 'clean' the above contour data
    cleancontour = 0;

    % 'Clean' the contour by removing all contours exceeding 'y' value of Lymax
    Lymax = 10;

    if cleancontour == 0
        % do nothing
    else
        C2 = [];
        for kk = 1:11
            for ii = 1:1
                C2{kk,ii} = cleancont(XY_special{kk,ii}, Lymax);
            end
        end
        XY_special = C2;

        % Remove the marker values from the contour data
        for kk = 1:11
            for ii = 1:1
                for jj = length(XY_special{kk,ii}):-1:1
                    if XY_special{kk,ii}(2,jj)> Lymax || XY_special{kk,ii}(2,jj)<0
                        XY_special{kk,ii}(:,jj) =[];
                    end
                end
            end
        end

        % (UNAPPLIED) Aid visualisation by bringing contours closer to the axis
        % for kk = 1:10
        %     for ii = 1:4
        %         C{kk,ii}(2,:) = C{kk,ii}(2,:)/2;
        %
        %     end
        % end
    end

    %% interpolate at equal intervals on line
    npts = 80;
    for ii = 1:11
        stepLengths = sqrt(sum(diff(XY_special{ii,1}',[],1).^2,2));
        stepLengths = [0; stepLengths]; % add the starting point
        cumulativeLen = cumsum(stepLengths);
        finalStepLocs = linspace(0,cumulativeLen(end), npts);
        tmp = interp1(cumulativeLen, XY_special{ii,1}', finalStepLocs);
        hh = H(ii)*ones(1,npts);
        XY_special{ii,1} = [tmp';hh];
        C2{ii,1} = [XY_special{ii,1}(1,:);-XY_special{ii,1}(2,:);XY_special{ii,1}(3,:)];
    end

    for ii = 1:10
        [V,F] = getPatchBetweenTwoLines3D(XY_special{ii,1}', XY_special{ii+1,1}', npts);
        p = patch('Faces', F, 'Vertices', V);
        set(p, 'FaceColor', 'w', 'EdgeColor', 0.2*[1,1,1]);

        [V2,F2] = getPatchBetweenTwoLines3D(C2{ii,1}', C2{ii+1,1}', npts);
        p2 = patch('Faces', F2, 'Vertices', V2);
        set(p2, 'FaceColor', 'w', 'EdgeColor', 0.2*[1,1,1]);
    end
end

%% A 'simpler plot' (not used) of the above version 
% Simpler version just uses basic points; can be used to diagnose
% ii = 1;
% figure(2)
% hold on
% for kk = 1:11
%     plot3(XY_special{kk,ii}(1,:),XY_special{kk,ii}(2,:),zz(kk)*ones(size(XY_special{kk,1})), '.r', 'MarkerSize', 15)
%     xlabel('x')
%     ylabel('y')
%     zlabel('z')
%     title('Re(Chi)= 1, h = -1')
% end


%%Now plot free-surface

%% 

freezeColors
% freezeColors(colorbar)

%% We plot the free-surface, as calculated by Lustri & Chapman (4.17)
name = ['./fig3data.mat'];
load(name)

%% calculate jump term S
hh = xx(2)-xx(1);
CHIX = chix(CHI,hh); %Get chi derivative ((4.18) lustri)
S = cell(size(CHI));

for k = 1:length(CHI)
    S{k} = 2*pi*1i/sqrt(ep)*phi.*CHIX{k}.*exp(-CHI{k}/ep);
end

%% We plot the free-surface, as calculated by Lustri & Chapman (4.17)

% figure(4)
adjustz = 0.3;

% We cap the surface values for visual colours only
zmax = 0.2;
Z = 20000*real(S{6});
Z(Z > zmax) = zmax;
Z(Z < -zmax) = -zmax;
% s = surf(X, Y, Z + adjustz);
s = surf(X, Y, adjustz + 0*Z, Z);
% s = pcolor(X, Y, Z);
% set(s, 'EdgeColor', 'none', 'FaceColor', 'interp');
set(s, 'FaceColor', 'interp', 'EdgeColor', 'none');
caxis([-zmax, zmax]);

% s = surf(X,Y,2000*real(S{6}) + adjustz);
colormap(brewermap([],'Blues'))
xlabel('$x$');
ylabel('$y$');
zlabel('$z$');

