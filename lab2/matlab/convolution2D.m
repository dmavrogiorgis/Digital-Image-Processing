function im_output = convolution2D(im_input, fil_input, type)

    [im_rows, im_cols] = size(im_input);
    [fil_rows, fil_cols] = size(fil_input);
    
    h = rot90(fil_input, 2);

    fill_num = floor(fil_rows/2);
    
    if type == "zero" 
        im_padded = padarray(im_input, [fill_num fill_num]);
    elseif type == "replicate"
        im_padded = padarray(im_input, [fill_num fill_num], 'replicate' );
    else
        error('Wrong type of padding!');
    end
    
    
    im_temp_output = zeros(im_rows, im_cols);
    
    for x = 1:im_rows
       for y = 1:im_cols
         for i = 1:fil_rows
            for j = 1:fil_cols
                im_temp_output(x,y) = im_temp_output(x,y) + h(i,j)*im_padded(i+x-1, j+y-1);
            end
         end
       end
    end
    im_output = uint8(im_temp_output);
end