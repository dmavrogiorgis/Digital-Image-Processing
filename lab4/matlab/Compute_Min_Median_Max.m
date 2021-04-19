function img_output = Compute_Min_Median_Max(img_input, kernel, type)
    
    [img_rows, img_cols] = size(img_input);
    [kernel_rows, kernel_cols] = size(kernel);
    
    h = rot90(kernel, 2);
    
    fill_num = floor(kernel_rows/2);
    
    im_padded = padarray(img_input, [fill_num fill_num], 'symmetric');
    
    img_temp_output = zeros(img_rows, img_cols);
    
    matrix_to_row_vec = zeros(1, kernel_rows*kernel_cols);
    
    for x = 1:img_rows
       for y = 1:img_cols
         for i = 1:kernel_rows
            for j = 1:kernel_cols
                 matrix_to_row_vec((i-1)*kernel_rows + j) = h(i,j)*im_padded(i+x-1,j+y-1);
            end
         end
         
         if type == "median"
             matrix_to_row_vec = sort(matrix_to_row_vec);
             img_temp_output(x,y) = median(matrix_to_row_vec);
         elseif type == "min"
             img_temp_output(x,y) = min(matrix_to_row_vec);
         elseif type == "max"
             img_temp_output(x,y) = max(matrix_to_row_vec);
         else
             error('Wrong type of method!');
         end
       end
    end
    
    img_output = uint8(img_temp_output);
end