% length of message & code bits
n = 1000;
k = 500;

%% dc : degree of edge distribution from CN perspective polynomial (trial & err)
% rho is chosen to be check regular. Optimal degree is found out to be 7
dc = 7;

%% Compute the best lambda for a given value of rho
[lambda, rho, eps] = gen_Lambda(1000, dc);

% To load the optimally computed lambda and rho, uncomment the next 2 lines
% load('lambda.mat');
% load('rho.mat');

%% Evaluate DE based on computed lambda and rho
%eval_DE(lambda, rho, P);

%% Generate node degree distributions
% these have been named lambda and rho which is the same as the edge
% distributions
disp('Generating lambda');
[lambda, rho] = gen_degreeDist(lambda,rho);
lambda = decimate(lambda,3);
LDPCM = gen_LDPCM(lambda, rho, n, k);

% Generated LDPCmatrices for n=1000,2000 & 4000 are stored in the mat files
% LDPCM_1/2/4000.mat. Uncomment one of the next 3 lines to use that matrix
% load('LDPCM_1000.mat');
% load('LDPCM_2000.mat');
% load('LDPCM_4000.mat');

%% Running SPA (erasure filling algorithm)

% Create VNs, CNs and edges connecting them based on the LDPC matrix
[VN, CN] = gen_decoder(LDPCM);

% Set erasure rate for the channel to generate received vector
EPS = 0.35;

% Generate noisy codeword and run sum-product (erasure filling) algorithm
CW = gen_RV(n, EPS);
[estimate, errors] = SPA( VN, CN, CW );

% plot the errors vs. iterations for the computed codeword and output BER
figure;
plot(1:length(errors),errors);
sum(estimate==2)
