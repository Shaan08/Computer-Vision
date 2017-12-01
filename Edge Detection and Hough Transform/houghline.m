function [linepar acc] = ...
  houghline(curves, magnitude, nrho, ntheta, threshold, nlines, verbose)

  % ------------------------ Allocate accumulator space ------------------------
  acc = zeros(nrho, ntheta);

  % ----------- Define a coordinate system in the accumulator space ------------

  % TODO careful: spacing between a_min and a_max using linspace is
  % (a_max - a_min) / (n-1). Hence nrho and htheta should be 2*a_max + 1 in the
  % function calling this one.
  % UPDATE: not for rho


  % We suppose an image of size NxN
  % rho: from -sqrt(2) * D to + sqrt(2) * D.
  % D is the diagonal distance of the image. D = sqrt(2 * N^2) = N * sqrt(2)
  rho_max_abs = (nrho) / 2; % See Gonzalez
  rho_coord_sys = linspace(-rho_max_abs, rho_max_abs, nrho);

  % -90 <= theta <= 90
  theta_max_abs = pi / 2;
  theta_coord_sys = linspace(-theta_max_abs, theta_max_abs, ntheta);


  % ---------------------- Loop over all the input curves ----------------------

  insize = size(curves, 2);
  try_pointer = 1;
  num_curves = 0;

  while try_pointer <= insize

    curve_length = curves(2, try_pointer);
    num_curves = num_curves + 1;
    try_pointer = try_pointer + 1;

    % For each point on each curve
    for curve_idx = 1:curve_length

      % round() or else x or y are not integers
      x = curves(2, try_pointer);
      y = curves(1, try_pointer);

      mag_x_y = magnitude(round(x),round(y));

      try_pointer = try_pointer + 1;

      % Check if valid point with respect to threshold
      if mag_x_y < threshold
        continue;
      end

      % Loop over a set of theta values
      for theta_idx = 1 : ntheta

        theta = theta_coord_sys(theta_idx);
        rho = x * cos(theta) + y * sin(theta);

        % Find the accumulator cell rho must be in
        rho_placed = find(rho_coord_sys < rho, 1, 'last');

        %acc(rho_placed, theta_idx) = acc(rho_placed, theta_idx) + 1;
        % It introduces a bias to more distinct edges
        %acc(rho_placed, theta_idx) = acc(rho_placed, theta_idx) + mag_x_y;
        acc(rho_placed, theta_idx) = acc(rho_placed, theta_idx) + log(mag_x_y);

      end
    end
  end


  % ---------------- Extract local maxima from the accumulator -----------------
  %acc = binsepsmoothiter(acc, 0.0, 10);

  [pos value anms] = locmax8(acc);
  [dummy indexvector] = sort(value);
  nmaxima = size(value, 1);


  % Fill up the linepar matrix
  linepar = zeros(2, nlines);

  % Compute a line for each one of the strongest responses in the accumulator --
  for idx = 1:nlines
    rhoidxacc = pos(indexvector(nmaxima - idx + 1), 1);
    thetaidxacc = pos(indexvector(nmaxima - idx + 1), 2);

    rho = rho_coord_sys(rhoidxacc);
    theta = theta_coord_sys(thetaidxacc);

    % theta will be used for (rho, theta) -> (x,y).
    % prevent from division by zero
    if theta == 0
      theta = 1e-5;
    end

    linepar(:, idx) = [rho; theta];
  end

  if verbose > 0
    %anms(anms ~= 0) = 1;
    figure
    showgrey(anms)
  end

  if verbose > 1
    figure
    showgrey(binsepsmoothiter(acc, 0.5, 1));
  end

end
