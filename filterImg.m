function retval = filterImg(im, f, varargin)
  % Check number of input arguments
  if (nargin < 2)
    print_usage();
  end
  
  % Check image
  if (~ismatrix(im))
    error("imfilter: first input argument must be an image");
  end
  [imrows, imcols, imchannels, tmp] = size(im);
  if (tmp ~= 1 || (imchannels ~= 1 && imchannels ~= 3))
    error("imfilter: first input argument must be an image");
  end
  C = class(im);
  
  % Check filter (XXX: matlab support 3D filter, but I have no idea what they do with them)
  if (~ismatrix(f))
    error("imfilter: second input argument must be a matrix");
  end
  [frows, fcols, tmp] = size(f);
  if (tmp ~= 1)
    error("imfilter: second argument must be a 2-dimensional matrix");
  end
  
  % Parse options
  res_size = "same";
  res_size_options = {"same", "full"};
  pad = 0;
  pad_options = {"symmetric", "replicate", "circular"};
  ftype = "corr";
  ftype_options = {"corr", "conv"};
  for i = 1:length(varargin)
    v = varargin{i};
    if (any(strcmpi(v, pad_options)) || isscalar(v))
      pad = v;
    elseif (any(strcmpi(v, res_size_options)))
      res_size = v;
    elseif (any(strcmpi(v, ftype_options)))
      ftype = v;
    else
      warning("imfilter: cannot handle input argument number %d", i+2);
    end
  end
  
  % Pad the image
  im = padarray(im, floor([frows/2, fcols/2]), pad);
  if (mod(frows,2) == 0)
    im = im(1:end-1, :, :);
  end
  if (mod(fcols,2) == 0)
    im = im(:, 1:end-1, :);
  end
  
  % Do the filtering
  if (strcmpi(res_size, "same"))
    res_size = "valid";
  else % res_size == "full"
    res_size = "same";
  end
  if (strcmpi(ftype, "corr"))
    for i = imchannels:-1:1
      retval(:,:,i) = filter2(f, im(:,:,i), res_size);
    end
  else
    for i = imchannels:-1:1
      retval(:,:,i) = conv2(im(:,:,i), f, res_size);
    end
  end
  
  % Change the class of the output to the class of the input
  % (the filtering functions returns doubles)
  retval = cast(retval, C);
  
    end