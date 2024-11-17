function plotAckley()
% Problem domain
      Lx = 5;
      Ly = 5;
    
      % Make plot of obj fcn levelsets.
      N = 250;
      % figure(1)
      x = linspace(-Lx, Lx, N);
      y = linspace(-Ly, Ly, N);
      [xm, ym] = meshgrid(x, y);
      for i = 1:N
          for j = 1:N
        % Do plot of log(1+fcn) since its contours are much more clear
          zm(i, j) = ( 1+fcn_ackley([xm(i,j); ym(i,j)]) );
          end 
      end
      % contour(xm, ym, zm);
    
      figure(2)
      xlim([-5,5]);
      ylim([-5,5]);
      hold on
      surf(xm, ym, zm);


end