function pixels = Lvvvtilde(inpic, shape)

  if (nargin < 2)
    shape = 'same';
  end

  %------------------------ Lx, Ly ------------------------

  % Get the first order derivative kernels
  [dxmask dymask] = get_delta_dir_kernels(2);

  % Include them into a 5x5 matrix
  dxmask_5 = zeros(5,5);
  dxmask_5(3, 2:4) = dxmask;

  dymask_5 = zeros(5,5);
  dymask_5(2:4, 3) = dymask;

  Lx = filter2(dxmask_5, inpic, shape);
  Ly = filter2(dymask_5, inpic, shape);


  %------------------------ Lxx, Lyy ------------------------

  % Get the second order derivative kernel
  [dxxmask dyymask] = get_delta_dir_kernels(5);

  % Include them into a 5x5 matrix
  dxxmask_5 = zeros(5,5);
  dxxmask_5(3, 2:4) = dxxmask;

  dyymask_5 = zeros(5,5);
  dyymask_5(2:4, 3) = dyymask;

  Lxx = filter2(dxxmask_5, inpic, shape);
  Lyy = filter2(dyymask_5, inpic, shape);


  %------------------------ Lxxx ------------------------

  dxxxmask_5 = conv2(dxmask_5, dxxmask_5, 'same');

  Lxxx = filter2(dxxxmask_5, inpic, shape);


  %------------------------ Lxxy ------------------------

  dxxymask_5 = conv2(dxxmask_5, dymask_5, 'same');

  Lxxy = filter2(dxxymask_5, inpic, shape);


  %------------------------ Lxxy ------------------------

  dxyymask_5 = conv2(dxmask_5, dyymask_5, 'same');

  Lxyy = filter2(dxyymask_5, inpic, shape);


  %------------------------ Lxxx ------------------------

  dyyymask_5 = conv2(dymask_5, dyymask_5, 'same');

  Lyyy = filter2(dyyymask_5, inpic, shape);



  pixels = Lx.^3 .* Lxxx + 3 * Lx.^2 .* Ly .* Lxxy + 3 * Lx .* Ly.^2 .* Lxyy + Ly.^3 .* Lyyy;

end
