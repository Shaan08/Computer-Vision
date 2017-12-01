function [delta_x_kernel delta_y_kernel] = get_delta_dir_kernels(kernel_type)

  % Simple difference operator
  if kernel_type == 1
    delta_x_kernel = [-1 0 1];
    delta_y_kernel = [-1 0 1]';
  end

  % Central differences operator
  if kernel_type == 2
    delta_x_kernel = [-0.5 0 0.5];
    delta_y_kernel = [-0.5; 0; 0.5];
  end

  % Roberts cross edge operator
  % http://homepages.inf.ed.ac.uk/rbf/HIPR2/roberts.htm
  if kernel_type == 3
    delta_x_kernel = [1 0; 0 -1];
    delta_y_kernel = [0 1; -1 0];
  end

  % Sobel operator
  % http://homepages.inf.ed.ac.uk/rbf/HIPR2/sobel.htm
  if kernel_type == 4
    delta_x_kernel = [-1 0 1; -2 0 2; -1 0 1];
    delta_y_kernel = [1 2 1; 0 0 0; -1 -2 -1];
  end

  % Second order central differences
  if kernel_type == 5
    delta_x_kernel = [1 -2 1];
    delta_y_kernel = [1; -2; 1];
  end

end
