function [ RV ] = gen_RV( n, EPS )
%GEN_RV Summary of this function goes here
%   Detailed explanation goes here
    RV = zeros(1,n);
    for i = 1:n
        if rand < EPS
            RV(i) = 2;
        end
    end

end

