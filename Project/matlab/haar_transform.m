function out_vect = haar_transform(in_vect)
    in_len = length(in_vect);
    
    haar_vect = zeros(1, in_len);
    for i=1:2:(in_len-1)
        k = floor(i/2)+1;                                        % Computing the index of the mean value
        haar_vect(k) = (in_vect(i) + in_vect(i+1))/2;            % Computing the mean value of the 2 neigbor values
        haar_vect(k + in_len/2) = haar_vect(k) - in_vect(i+1);   % Computing the difference of the mean value from the max value
    end
    
    out_vect = haar_vect;
end



