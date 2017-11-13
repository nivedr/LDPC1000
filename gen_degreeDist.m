function [ Lambda, Rho ] = gen_degreeDist( lambda, rho )
% Generates  ? and ?  from   ? and ?
%        (degree dist.)    (edge dist.)
    Lambda = polyint(lambda,0);
    Lambda = Lambda/sum(Lambda);

    Rho = polyint(rho,0);
    Rho = Rho/sum(Rho);
end

