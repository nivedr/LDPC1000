function [ lambda, rho, E ] = gen_Lambda( N, dc )
% Generates the optimal lambda for a given rho. The degree of rho is 'dc'
% N is a parameter that governs the fine-ness of the grid created for the
% linear program function constraint to be evaluated at

    % Degree is at most 25 for Lambda   ->   lambda  has max degree 24
    %                       (edge dist.)  (degree dist.)
    lambda = zeros(1,24);

    % generate rho
    rho(dc+2) = 0;
    rho(dc+1) = 1;
    rho = fliplr(rho);
    
    
    Xmat = [];
    E = 0.0; %initialization for error threshold
    
    % need to maximize: \sum lambda_i/i
    for t = (2:25)
        f(t-1) =-1/t;
    end

    b = linspace(0,1,N);
    x_lambda = 1-polyval(rho,1-b);
    
    % create grid on which p^-1(Ie) > 1-E.L(1-Ie) is constrained
    for x = x_lambda
        Xmat = [Xmat; x.^(1:24)];
    end

    del = 0.001;
    
    % In EXIT chart method, we require the graphs for the check node and
    % bit node codes to be of the form: Iev = 1-E.L(1-Iav) ; Iac = p^-1(Iec)
    % The check node chart should be higher than the bit node chart:
    % p^-1(Ie) > 1-E.L(1-Ie)
    % This is not tractable for irregular check node degrees, but is ok
    % if we consider the equation: Ie > p(1-E.L(1-Ie)) | Density Evolution
    
    while del > 1e-5
        A = E*Xmat;
        [lambda_est, R, ~] = linprog( f, A, b', ones(1,24), 1, zeros(24,1), ones(24,1) );

        lambda = lambda_est;
        rate =  1 + 1/(dc+1)/R;
        
        % Keep updating ?, until the rate approaches close to 1/2
        del = 0.4*(rate-0.5);
        E = E+del;
    end
    lambda = [fliplr(lambda'),0];
end


