function [S] = super_resolution_gray(I, f, delta)
% https://pdfs.semanticscholar.org/14fb/a4d942155b8678c1a601a683b943d67e42f3.pdf
% super_resolution_grey(I, f, delta) Performs super-resolution on I by a factor f
% NB: delta is between 0 and 1 ans is used for edge correction.
% If delta == -1, no edge correction is performed

  [m, n] = size(I);
  I3 = enlarge_3_by_3(I);
  S = uint8(zeros(f*m, f*n));
  C = canny_edge(imresize(I,3)); % Edge image used for edge correction
  
  % If parfor is used...
  % TD = cell(255, 1); % Will contain the threshold decomposition of 3*I
  wb = waitbar(0, '0% completed', 'Name', 'Super resolving image...', 'CreateCancelBtn', 'setappdata(gcbf,''canceling'',1)');
  setappdata(wb, 'canceling', 0);
  for k=1:255
      % Check for clicked Cancel button
      if getappdata(wb, 'canceling')
          break
      end
      T = I3 >= k;
      if max(T(:)) == 0 % If completely black, i.e. == zeros
          % If parfor is used...
          % TD{k} = zeros(f*m, f*n);
          T = uint8(zeros(f*m, f*n));
      elseif min(T(:)) == 1 % If completely white, i.e. == ones
          % If parfor is used...
          % TD{k} = ones(f*m, f*n);
          T = uint8(ones(f*m, f*n));
      else
          [TB, boundaries] = extract_boundary(T);
          [TC, Cboundaries] = extract_critical_data_points(TB, boundaries);
          [E, ~] = edge_correction(TC,Cboundaries, C, f, delta); % Critical data points after enlargement
          BP = breaking_points(E); % breaking points
          fitted = curve_fitting(E, BP, f); % curve fitted with cubic Bezier curves
          CF = uint8(zeros(f*m, f*n)); % the BW image
          nb = length(fitted); % number of closed boundaries
          for q=1:nb
              BD = fitted{q};
              nbp = length(BD); % number of points in boundary
              for x=1:nbp
                  i = round(BD(x,1)); j = round(BD(x,2));
                  % Some prudence just in case!
                  if i<1, i=1; end
                  if j<1, j=1; end
                  if i>f*m, i=f*m; end
                  if j>f*n, j=f*n; end
                  CF(i,j) = 1;
              end
          end
          
          T = imfill(CF,'holes');
          % If parfor is used...
          % TD{k} = T;
      end
      
      S = S + T;
      waitbar(k/255, wb, sprintf('%d%% completed', round(100*k/255)));
  end
  delete(wb); % delete waitbar
  
% If parfor is used...
%   % Add up all binary images
%   for i=1:255
%       S = S + TD{i};
%   end  

