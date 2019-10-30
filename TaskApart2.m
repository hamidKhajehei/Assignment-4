clc; clear; close all;


    ass4_code1 = {
    'data {'
    '   int<lower=0> J; // number of flips'
    '   int<lower=0,upper=1> y[J]; // coin flips'
    '}'
    'parameters {'
    '    real<lower=0,upper=1> theta; // prob of getting a head '
    '}'
    'transformed parameters {'
    '// no transformed variables to use'
    '}'
    'model {'
    '    theta ~ beta(1, 1); // prior distribution for theta'
    '    y ~ bernoulli(theta); // likelihood, note that stan will create the posterior automatically.' 
    '}'
    };

    y1 = [1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1 ,1 ,1];
    
  
    ass4_dat1 = struct('J',length(y1),...
                   'y',y1);

    fit1 = stan('model_code', ass4_code1,'data',ass4_dat1,'iter',15000);
    
    print(fit1)
    theta1 = fit1.extract('permuted',true).theta;
    
%     figure
%     histogram(theta1,50)
%     hold on
%     plotPost(theta1)
    
    SampleSize= length(theta1);
    p= sum((theta1>=0.5));  % number of times that theta has been greater than 0.5
    PP1= p/SampleSize; % probability of theta>0.5

    
%%   additional measurement

y2 =  [1, 0, 0, 0, 0, 0, 0, 1, 1, 0];
new_data = struct('J',length(y2),'y',y2);

% Passing in StanFit object skips recompilation
fit2 = stan('fit',fit1,'data',new_data,'iter',15000);
print(fit2);

theta2 = fit2.extract('permuted',true).theta;    

figure
% histogram(theta1,50)
% hold on
histogram(theta2,50)
hold on
plotPost(theta2)
box on

SampleSize= length(theta2);
p= sum((theta2>=0.5));  % number of times that theta has been greater than 0.5
PP2= p/SampleSize; % probability of theta>0.5

% HDIlim = HDIofMCMC(theta1,0.95)