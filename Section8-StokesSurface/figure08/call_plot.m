% The following script plots the relevant cross sections of level sets of
% chi, which are related to the secondary switchings. When traced in one
% direction ('into the fluid') they eventually intersect with the source
% placed at z = -1. When traced into the other direction ('out of the
% fluid') the intersect with the mirrored source at z = 1.

% The diagram in the publication only shows one set of contour lines

clear
close all

open hostokes-imy.fig

% Top-down view 
view([-90, 90])
box on
% export_fig hostokes_topdown.png -m2

% Angled view
view([-80,20]);
export_fig hostokes_angled.png -m2