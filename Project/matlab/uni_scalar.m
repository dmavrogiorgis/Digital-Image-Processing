function x_out = uni_scalar(x_in, R)
    L = 2^R;
    delta = (max(x_in) - min(x_in))/L;
    
    x_len = length(x_in);
    Q = zeros(1,x_len);
    for i = 1:x_len
        Q(i) = delta * sign(x_in(i)) * floor(abs(x_in(i))/delta + 1/2);
    end
    x_out = Q;
end