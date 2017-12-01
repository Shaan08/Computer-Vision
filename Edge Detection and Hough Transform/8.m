%pic = triangle128;
 pic = houghtest256;
 %pic = few256;
%pic = phonecalc256;
%pic = godthem256;

% Suppose image of dimension N x N
N = size(pic, 2);

% theta: from -90 to +90 (plus 0)
ntheta = 180 + 1;

% rho: from -sqrt(2) * D to + sqrt(2) * D (plus 0). D is the diagonal distance
% of the image.
nrho = 2 * 2 * (N-1);

[lines acc] = houghedgeline(pic, 4, 8, nrho, ntheta, 10, 2);

lines_N = size(lines, 1);
lines_M = size(lines, 2);

xy_lines = zeros(lines_N, lines_M);

for i = 1 : lines_M
  x_0 = 0;
  y_0 = (lines(1,i) - x_0 * cos(lines(2,i))) / sin(lines(2,i));

  % Big enough to remove local errors
  dx = N^2;
  dy = (lines(1,i) - dx * cos(lines(2,i))) / sin(lines(2,i));

  xy_lines(1, 4 * (i-1) + 1) = 0;
  xy_lines(2, 4 * (i-1) + 1) = 3;

  xy_lines(2, 4 * (i-1) + 2) = x_0 - dx;
  xy_lines(1, 4 * (i-1) + 2) = y_0 - dy;

  xy_lines(2, 4 * (i-1) + 3) = x_0;
  xy_lines(1, 4 * (i-1) + 3) = y_0;

  xy_lines(2, 4 * (i-1) + 4) = x_0 + dx;
  xy_lines(1, 4 * (i-1) + 4) = y_0 + dy;
end

figure
overlaycurves(pic, xy_lines);
