clear;
close all;

A = [88 88 89 90 92 94 96 97];

A_haar = zeros(1, length(A));
A_up = zeros(1, length(A));
A_rec = zeros(1, length(A));

for i=1:2:(length(A)-1)
    k = floor(i/2)+1;                               % Computing the index of the mean value
    A_haar(k) = (A(i) + A(i+1))/2;                  % Computing the mean value of the 2 neigbor values
    A_haar(k + length(A)/2) = A_haar(k) - A(i+1);   % Computing the difference of the mean value from the max value
end

for i=1:(length(A)/2)           % We traverse the vector from start to n/2 to take only the mean values
    A_up(2*i-1) = A_haar(i);    % Upsampling the vector by copying the value at index i of vector A_haar 
    A_up(2*i) = A_haar(i);      % to 2*i and 2*i-1 of the new vector A_up
end

for i=1:2:(length(A)-1)
    k = floor(i/2)+1;                                   % Computing the index of the variance from the max value in vector A_haar
    A_rec(i) = A_up(i) + A_haar(k+length(A)/2);         % The value at index i in vector A_rec is the sum of value at index i of the A_up and the variance we computed in vector A_haar
    A_rec(i+1) = A_up(i+1) - A_haar(k+length(A)/2);     % Similarly, value at index i in vector A_rec is the subtraction of the variance we computed in vector A_haar from the value at index i of the A_up and
end

diff = immse(A,A_rec); %We use this function to check if mse is 0 which means the 2 vectors are equal
