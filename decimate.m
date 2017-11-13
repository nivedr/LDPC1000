function [ lambda_new ] = decimate( lambda, n)
% Round off ?(x) to in such a way that:
%   i.  n*?(x) now has all integer coefficients
%   ii. n*?(x) coefficients sum up to n

    % generate first estimate of lambda by simply rounding
    lambda_new = round(n*lambda)/n;
    
    % if the sum does not add to n, randomly subtract 1's from different
    % coefficients till it adds up to n
    if(abs(sum(lambda_new)-1) >= 1/n)
        EC = n*(sum(lambda_new)-1);
        t = datasample(find(lambda_new>0), abs(EC), 'Replace',false);
        lambda_new(t) = lambda_new(t)-sign(EC)*1/n;
    end
end

