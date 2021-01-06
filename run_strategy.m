% Example: Equal Weighted Porfolio Strategy

% Initialize Model Parameters
T = 50;
d = 10;
eta = 0.0002;
Krank = floor(0.25*d);
preK = orth( normrnd(0,1,d,d) );
diagK = diag( [ normrnd(0,0.01,Krank,1);zeros(d-Krank,1)] );
K = preK * diagK * preK'; % Randomly generated matrix of rank Krank
K = K'*K;
Sigma = 0.05*eye(d);
mu = 0.0005*normrnd(0,1,d,1);
s0 = 100*ones(d,1);

% Initialize Simulation Environment
model_params = struct('mu',mu,'K',K,'Sigma',Sigma,'eta',eta);
sim_obj = MarketSimulator(T,s0,model_params);

% Run strategy on environment
sim_obj = example_strategy_2(sim_obj); % proportional weight strategy
% sim_obj = example_strategy_1(sim_obj); % constant weight strategy

% Plot simulated price history
figure(1);
clf();
plot(1:(T+1),sim_obj.s_hist);
title('Stock Price Evolution')

% Plot portfolio weights
figure(2);
clf();
plot(1:T,sim_obj.w_hist);
title('Portfolio Weight Evolution')

% Plot portfolio 1-period returns + mean
figure(3);
clf();
hold on;
plot(1:T,sim_obj.r_hist);
plot(1:T,ones(1,T) * mean(sim_obj.r_hist))
hold off;
title('Portfolio 1-Period-Return Evolution')

% Plot portfolio cumulative growth
figure(4);
clf();
plot(1:T,sim_obj.R_hist-1);
title('Portfolio Cumulative Growth')



