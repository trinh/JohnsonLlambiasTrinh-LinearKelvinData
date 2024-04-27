
C = cell(11,4);
hold on

    for ii = 1:1
%         [Ctmp,~] = contour(XX{kk},YY{kk},real(CHIZ{kk,2}),[-2.1 -2.1], 'r','LineWidth', 2);
        [Ctmp,~] = contour(X,Y,real(KPHI{2}),[-2.1 -2.1], 'r','LineWidth', 2);
    end

%% clean
C2 = [];

C2 = cleancont(Ctmp,15);

C = [];
C = C2;

