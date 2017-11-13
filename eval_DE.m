function [ output_args ] = eval_DE( lambda, rho, P )
%UNTITLED Summary of this function goes here

    % maximum tolerable error between successive iterations of density fn
    tol = 1e-4;
    i = 1;
    p(1) = P;
    delta = 1;
    
    while delta > tol
        p(i+1) = P*polyval(lambda, 1 - polyval(rho, 1-p(i))); 
        delta = abs(p(i+1) - p(i));
        i = i + 1;
    end
    figure;
    plot(1:length(p),p);
    xlim([1 length(p)]);
    xlabel('Number of iterations');
    ylabel('Erasure probabilities');
end

% P_e threshold for (3,6) regular ensemble: 0.4365
% P_e threshold for computed ensemble:

