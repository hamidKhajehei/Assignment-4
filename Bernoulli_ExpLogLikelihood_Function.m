function [p] = Bernoulli_ExpLogLikelihood_Function(y,thetas)

p=zeros(1,length(thetas));
n=length(y);
y_sup=ones(1,n)-y;

for i=1:length(thetas)
    t1=ones(1,n).*thetas(i); t2=ones(1,n).*(1-thetas(i));
    p(i)=exp(sum((y.*log(t1))+(y_sup.*log(t2))));
end

end

