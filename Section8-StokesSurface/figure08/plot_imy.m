clear
close all
load('data_chi_imy.mat')
%CHI is a cell array with each column a set of chi branches for a
%particular value of Im(y). Each cell is matrix data for chi.

%% get contour data for ho stokes line

for kk = 1:length(IM)
    figure(2)
    [c,~] = contour(real(X),real(Y),imag(CHI{1,kk}-CHI{5,kk}),[0 0], 'Linewidth', 2);
    Cho{kk} = c;
end
close

% for kk = 1:length(IM)
%     figure(2)
%     [cr,~] = contour(real(X),real(Y),real(CHI{5,kk}),[0 0], 'Linewidth', 2);
%     Cre{kk} = cr;
% end
close
%% Get singular points of phi, x^2+y^2+h^2 = 0
for kk = 1:length(IM)
    if  (IM(kk)>h) || (IM(kk)<-h)
        xs(kk) = sqrt(-(1i*IM(kk)).^2-h^2); %for x to be real, y must be pure imaginary and |y|>h.
    else
        xs(kk) = NaN;
    end
end
%% plot ho stokes surf

figure(3)
hold on

for kk = 1:length(IM)
    im = IM(kk);
    
    if im>0  %reverse the branches (to account for matlab switching between them across im(y)=0
        plot3(Cho{kk}(1,:),-Cho{kk}(2,:),IM(kk)*ones(size(Cho{kk}(2,:))),'k.')
%         plot3(Cre{kk}(1,:),-Cre{kk}(2,:),IM(kk)*ones(size(Cre{kk}(2,:))),'k.', 'MarkerSize', 4)
    else
        plot3(Cho{kk}(1,:),Cho{kk}(2,:),IM(kk)*ones(size(Cho{kk}(2,:))),'k.')
%         plot3(Cre{kk}(1,:),Cre{kk}(2,:),IM(kk)*ones(size(Cre{kk}(2,:))),'k.','MarkerSize', 4)
    end
    %plot singular points
    plot3(xs(kk),0,IM(kk),'r*','MarkerSize', 4)
    plot3(-xs(kk),0,IM(kk),'r*','MarkerSize', 4)
end
xlabel('x')
ylabel('Re(y)')
zlabel('Im(y)')
xlim([1,20])
ylim([-10,10])

%%
figure(3)
hold on
for kk = [1 50 101 150 200]
    im = IM(kk);
    if im>0%reverse the branches (to account for matlab switching between them across im(y)=0
        surf(X,-real(Y),im*ones(size(Y)),real(CHI{1,kk}))
        
        alpha(0.7)
    else
        surf(X,real(Y),im*ones(size(Y)),real(CHI{1,kk}))
        alpha(0.7)
    end
    colorbar
    shading interp
end