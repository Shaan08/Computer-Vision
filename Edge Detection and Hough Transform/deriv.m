function [dxtools dytools] = deriv(in_img, kernel_type, shape)

  [delta_x delta_y] = get_delta_dir_kernels(kernel_type);

  dxtools = conv2(in_img, delta_x, shape);
  dytools = conv2(in_img, delta_y, shape);

end
