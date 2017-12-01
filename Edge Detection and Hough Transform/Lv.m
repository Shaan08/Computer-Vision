function pixels = Lv(inpic, kernel_type, shape)

  if (nargin < 3)
    shape = 'same';
  end

  [dxmask dymask] = get_delta_dir_kernels(kernel_type);

  Lx = filter2(dxmask, inpic, shape);
  Ly = filter2(dymask, inpic, shape);
  pixels = Lx.^2 + Ly.^2;

end
