function out_vect = inverse_haar_transform(in_vect)
    in_len = length(in_vect);
    
    haar_up = zeros(1, in_len);
    haar_rec = zeros(1, in_len);
    for i=1:(in_len/2)               % We traverse the vector from start to n/2 to take only the mean values
        haar_up(2*i-1) = in_vect(i);    % Upsampling the vector by copying the value at index i of vector A_haar 
        haar_up(2*i) = in_vect(i);      % to 2*i and 2*i-1 of the new vector A_up
    end

    for i=1:2:(in_len-1)
        k = floor(i/2)+1;                                       % Computing the index of the variance from the max value in vector A_haar
        haar_rec(i) = haar_up(i) + in_vect(k+in_len/2);         % The value at index i in vector A_rec is the sum of value at index i of the A_up and the variance we computed in vector A_haar
        haar_rec(i+1) = haar_up(i+1) - in_vect(k+in_len/2);     % Similarly, value at index i in vector A_rec is the subtraction of the variance we computed in vector A_haar from the value at index i of the A_up and
    end
    out_vect = haar_rec;
end