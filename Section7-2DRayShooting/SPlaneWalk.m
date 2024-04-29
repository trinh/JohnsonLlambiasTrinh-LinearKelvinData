
clear
close all

itermax = 6;
L = 6;

Nwalks= 100;

%Q1i
% s0 = 1e-3 + 1.01*1i;
% Q1O
s0 = 1 + 1i*1e-3;
% Q4O
% s0 = 1 - 1i*1e-3;
% Q30
% s0 = -1 - 1i*1e-3;
% Q3i
% s0 = 42*exp(1i*pi/4);
% 
% % Q2i
% s0 = -1e-3 + 1.01*1i;
% Q1i
% s0 = 1e-3 + 1.01*1i;

theta = pi/4;

% step = pi/10;
delta0 = 0.1;
X = [];
Y = [];
CHI = [];
delta = delta0;
% s = s0 + delta*exp(1i*theta);
sol0 = ShootSingleS(s0);

ITER(1) = 0;
S(1) = s0;
X(1) = sol0.x;
Y(1) = sol0.y;
CHI(1) = sol0.chi;
THETA(1) = theta;

s1 = s0;
for j = 2:Nwalks+1
    
%         keyboard
    s2 = s1 +  delta*exp(1i*theta);
    if imag(s2)>0 && real(s2)>0 && real(s2)<2 && imag(s2)<2 
        
    sol = ShootSingleS(s2);
    iter = 0;
    if abs(sol.x)>L || abs(sol.y)>L
        %           if abs(sol.x)>L
        while   abs(sol.x)>L || abs(sol.y)>L
            %             while   abs(sol.x)>L
            
            delta = delta/2;
            s2  = s1 + delta*exp(1i*theta);
            sol = ShootSingleS(s2);
            iter = iter + 1;
            if iter==itermax
                break
            end
        end
    end
    
    %     keyboard
    if iter == itermax || isnan(sol.x)==1 || isnan(sol.y)==1  
        ITER(j) = iter;
        S(j) = NaN;
        X(j) = NaN;
        Y(j) = NaN;
        CHI(j) = NaN;
    else
        ITER(j) = iter;
        S(j) = s2;
        X(j) = sol.x;
        Y(j) = sol.y;
        CHI(j) = sol.chi;
        THETA(j) = theta;
    end
    
    
        
    
    disp(['walks=',num2str(j-1)]);
    
    delta = delta0;
    if iter == itermax || isnan(sol.x)==1 || isnan(sol.y)==1
        theta = 2*pi*rand;
        %         theta = theta + step;
    else
        s1 = s2;
    end
    else 
        ITER(j) = iter;
        S(j) = NaN;
        X(j) = NaN;
        Y(j) = NaN;
        CHI(j) = NaN;
        theta = 2*pi*rand;
    end
        
    
end

SS = S(~isnan(S));
XX = X(~isnan(X));
YY = Y(~isnan(Y));
CHICHI = CHI(~isnan(CHI));


% name = ['./data/walks/nonlinear/d',num2str(delta),'_s',num2str(s0),'_L',num2str(L),'_N',num2str(Nwalks),'.mat'];
% save(name)

% 
% figure(3)
% plot3(real(SS),imag(SS),real(CHICHI))
% xlabel('Re(s)')
% ylabel('Im(s)')
% zlabel('real(chi)')
% 
% figure(4);figshift
% hold on
% plot3(real(SS),imag(SS),real(XX),'b')
% xlabel('Re(s)')
% ylabel('Im(s)')
% zlabel('real(x)')
% 
% figure(5);figshift
% hold on
% plot3(real(SS),imag(SS),real(YY),'r')
% xlabel('Re(s)')
% ylabel('Im(s)')
% zlabel('real(y)')

figure(6);figshift
hold on
plot(real(SS),imag(SS),'r')
xlabel('Re(s)')
ylabel('Im(s)')

figure(7);figshift
hold on
plot3(real(XX),real(YY),real(CHICHI),'b')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('real(chi)')



figure(8);figshift
hold on
plot3(real(XX),real(YY),imag(CHICHI),'b')
xlabel('Re(x)')
ylabel('Re(y)')
zlabel('imag(chi)')
    export_fig(figure(6),'./splane','-pdf')
    export_fig(figure(7),'./xplane','-pdf')
