% Make the Figs 4 for the publication 

clear
close all

open splane.fig
box on
xlabel('');
ylabel('');
export_fig 'ray_splane.pdf'

%%

open xyrealchi.fig
view([-55, 40]);
grid on
box on
axis equal
xlabel('');
ylabel('');
zlabel('');
export_fig 'ray_xyrealchi.pdf'

%%

open xyimagchi.fig
view([-40, 10]);
grid on
box on
axis equal
xlabel('');
ylabel('');
zlabel('');
export_fig 'ray_xyimagchi.pdf'
