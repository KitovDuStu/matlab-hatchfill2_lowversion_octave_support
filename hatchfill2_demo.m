%HATCHFILL2_DEMO   Demonstration script for HATCHFILL2 function
%  4 examples from original HATCHFILL by Neil Tandon
%  a bar plot example
%  the final question need something from Yair Altman to solve
clear; close all; drawnow
%if exist('octave_core_file_name'); handle = @(x)x; end;
%here is not global too?



%%% In this example, the 2 contour of a contour plot
%%% is filled with hatching.
load([mfilename '_data']);  %__filename__

% plot background data
figure;  hold on;
% plot hatching region:
% zone(40:60,15:20) = nan; % force errorneous case
lev=[2 2];
[~,h] = contourf(lat,p,temp,150:10:320);
caxis([190 270]);  %有fill属性
set(h,'linestyle','none');  %tikz has too?
[c2,h2] = contourf(lat2,p2,zone,lev);
%[c2,h2] = contourf(lat2,p2,zone,[2 2],'Fill','off'); % plots only the 2 contour
%set(h2,'linestyle','-','Tag','HatchingRegion');
set(h2,'linestyle','none','Tag','HatchingRegion');
hold off;                                 % if you want to have more control
ax1 = gca;
ax2 = copyobj(ax1,figure);

% Example 1: Default hatching
hp = findobj(ax1,'Tag','HatchingRegion');
hh = hatchfill2(hp,'cross','LineWidth',1,'Fill','off');   %why
title('Example 1: hatchfill2(hp,''HatchColor'',''w'',''FaceColor'',''none'')');
if ~exist('octave_core_file_name');
% Example 2: Set logarithmic yscale and reverse yaxis & speckle
set(ax2,'ylim',[50 700],'yscale','log','ydir','reverse');
hp = findobj(ax2,'Tag','HatchingRegion');
% h1 = hatchfill2(hp,'speckle','HatchColor','w');

h1 = hatchfill2(hp,'HatchColor','w');
title('Example 2: hatchfill2(hp,''speckle'',''HatchColor'',''w'') on log-scaled reversed y-axes');


end;

% Example 3: Cross-hatching of multi-face patch
xdata = [2 2 0 2 5;
   2 8 2 4 5;
   8 8 2 4 8];
ydata = [4 4 4 2 0;
   8 4 6 2 2;
   4 0 4 0 0];
figure;
hp = patch(xdata,ydata,linspace(0,1,size(xdata,2)),'EdgeColor','none');
if ~exist('octave_core_file_name');
 hatchfill2(hp,'cross','HatchAngle',45,'HatchDensity',20,'HatchColor','b','HatchLineWidth',2);
else;hatchfill2(hp);
end;
% hatchfill2(hp,'speckle','HatchAngle',45,'HatchDensity',50,'HatchColor','b','HatchLineWidth',2);
title('Example 3: Hatching a patch object with multiple faces');


% Example 4: bar plot hatching
c = load('count.dat');  %not distributed on github
Y = c(1:6,:);
figure;
hp = bar(Y);
if ~exist('octave_core_file_name');
hatchfill2(hp(1),'single','HatchAngle',0);
hatchfill2(hp(2),'cross','HatchAngle',45);
hatchfill2(hp(3),'single','HatchAngle',90);
else;
hatchfill2(hp(1),'single');
hatchfill2(hp(2),'cross');
hatchfill2(hp(3),'single');
end;
title('Example 4: Hatching bars of a bar plot');

if 1;
  figure;
  % Example 5: 3D hatching
  t = linspace(0,3,101)';
  x = cos(2*pi*t);
  y = sin(2*pi*t);
  plot3(t,x,y)

  %REAL PROJECTION
  hx = patch('XData',[t(1);t;t(end)],'YData',[0;x;0],'ZData',zeros(length(t)+2,1),'FaceColor','b','EdgeColor','b','LineWidth',1,'EdgeAlpha',0.5,'FaceAlpha',0.15);
  params={'LineWidth',1,'FaceColor','none','HatchStyle','single','HatchAngle',90,'HatchDensity',50};
  if exist('octave_core_file_name');params={}; end;
  hatchfill2(hx,'cross',params{:});
  %IMAG PROJECTION
  hy = patch('XData',[t(1);t;t(end)],'YData',zeros(length(t)+2,1),'ZData',[0;y;0],'FaceColor','b','EdgeColor','b','LineWidth',1,'EdgeAlpha',0.5,'FaceAlpha',0.15);
  params={'LineWidth',1,'FaceColor','none','HatchStyle','single','HatchAngle',90,'HatchDensity',50};
  if exist('octave_core_file_name');params={};end;
  hatchfill2(hy,'cross',params{:});
end;
