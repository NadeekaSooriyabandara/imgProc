function showDigits(image, roi1, roi2, roi3, roi4, roi5, roi6, roi7)
figure, imshow(image);
hold on;
rectangle('Position',roi1,...
          'Curvature',[0,0],...
         'LineWidth',1,'LineStyle','-');
     rectangle('Position',roi2,...
          'Curvature',[0,0],...
         'LineWidth',1,'LineStyle','-');
     rectangle('Position',roi3,...
          'Curvature',[0,0],...
         'LineWidth',1,'LineStyle','-');
     rectangle('Position',roi4,...
          'Curvature',[0,0],...
         'LineWidth',1,'LineStyle','-');
     rectangle('Position',roi5,...
          'Curvature',[0,0],...
         'LineWidth',1,'LineStyle','-');
     rectangle('Position',roi6,...
          'Curvature',[0,0],...
         'LineWidth',1,'LineStyle','-');
     rectangle('Position',roi7,...
          'Curvature',[0,0],...
         'LineWidth',1,'LineStyle','-');
end