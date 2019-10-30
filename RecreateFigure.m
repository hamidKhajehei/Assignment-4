clc; clear; close all;

initial=0.5;
nsamples=10000;
jump=0.1;

thetas=0:0.01:1;
y=[ones(1,17),zeros(1,3)];
N=20;
z=17;

a=250;
b=250;
%
likelihood=Bernoulli_ExpLogLikelihood_Function(y,thetas);

for i = 1:length(thetas)
prior1(i)=betapdf(thetas(i),a,b);
end


priorF1 = @(thetas,a,b) log(betapdf(thetas,a,b)); 
LikeF1 = @(thetas,z,N) (z*log(thetas)+(N-z)*log(1-thetas));
pdfF1 = @(thetas) exp( priorF1(thetas,a,b) + LikeF1(thetas,z,N) );
posterior1 = slicesample(initial,nsamples,'pdf',pdfF1,'width',jump);

%
figure;
subplot(3,3,1);
area(thetas,prior1);
title('Prior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|250,250)');
%
subplot(3,3,4);
area(thetas,likelihood);
title('Likelihood (Bernoulli)');
xlabel('\theta');
ylabel('(D|\theta)');
%
subplot(3,3,7);
hist(posterior1,50);
title('Posterior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|117,103)');
xlim([0,1])
 %Column 2: a=18.25 b=6.75
a=18.25;
b=6.75;

for i = 1:length(thetas)
prior2(i)=betapdf(thetas(i),a,b);
end

priorF2 = @(thetas,a,b) log(betapdf(thetas,a,b)); 
LikeF2 = @(thetas,z,N) (z*log(thetas)+(N-z)*log(1-thetas));
pdfF2 = @(thetas) exp( priorF2(thetas,a,b) + LikeF2(thetas,z,N) );
posterior2 = slicesample(initial,nsamples,'pdf',pdfF2,'width',jump);

%
subplot(3,3,2);
area(thetas,prior2);
title('Prior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|18.25,6.75)');
%
subplot(3,3,5);
area(thetas,likelihood);
title('Likelihood (Bernoulli)');
xlabel('\theta');
ylabel('(D|\theta)');
%
subplot(3,3,8);
hist(posterior2,50);
title('Posterior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|35.25,9.75)');
xlim([0,1])
 %Column 3: a=b=1
a=1;
b=1;

for i = 1:length(thetas)
prior3(i)=betapdf(thetas(i),a,b);
end

priorF3 = @(thetas,a,b) log(betapdf(thetas,a,b)); 
LikeF3 = @(thetas,z,N) (z*log(thetas)+(N-z)*log(1-thetas));
pdfF3 = @(thetas) exp( LikeF3(thetas,z,N)+ priorF3(thetas,a,b));
posterior3 = slicesample(initial,nsamples,'pdf',pdfF3,'width',jump);

%
subplot(3,3,3);
area(thetas,prior3);
title('Prior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|1,1)');
ylim([0,2])
%
subplot(3,3,6);
area(thetas,likelihood);
title('Likelihood (Bernoulli)');
xlabel('\theta');
ylabel('(D|\theta)');
%
subplot(3,3,9);
hist(posterior3,50);
title('Posterior (beta)');
xlabel('\theta');
ylabel('dbeta(\theta|18,4)');
xlim([0,1])
