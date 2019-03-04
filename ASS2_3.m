data=xlsread('heart_DD.csv')
m=length(data(:,1));
percent80=ceil(m*0.8);
percent10=ceil(m*0.1);
x=data{1:percent80,1:13};
X=[ones(percent80,1) x x.^2];


Y=data{1:percent80,14};
y=data{1:percent80,14};
Alpha=0.01;
lambda=100;


%80% 
 n=length(X(1,:)); 
 for w=2:n
    if max(abs(X(:,w)))~=0
    X(:,w)=(X(:,w)-mean((X(:,w))))./std(X(:,w));
    end
 end
 theta=zeros(n,1);
 h=1./(1+exp(-X*theta));  
 k=1;
 J(k)=-(1/percent80)*sum(Y.*log(h)+(1-Y).*log(1-h))+(lambda/(2*percent80))*sum((theta).^2);  %cost function
 grad=zeros(size(theta,1),1);     %gradient vector
 for i=1:size(grad)
     grad(i)=(1/percent80)*sum((h-Y)'*X(:,i));
 end
R=1;
while R==1
Alpha=Alpha*1;
theta=theta-(Alpha/percent80)*X'*(h-Y);
h=1./(1+exp(-X*theta));  %sigmoid function
k=k+1
J(k)=(-1/percent80)*sum(Y.*log(h)+(1-Y).*log(1-h))+(lambda/(2*percent80))*sum((theta).^2);
if J(k-1)-J(k) <0 
    break
end 
q=(J(k-1)-J(k))./J(k-1);
if q <.00001
    R=0;
end
end






x1=data{percent80+1:percent80+percent10,1:13};
X1=[ones(percent10,1) x1 x1.^10 ];

y1=data{percent80+1:percent80+percent10,14};
Y1=y1;
n1=length(X1(1,:)); 
 for w1=2:n1
    if max(abs(X1(:,w1)))~=0
    X1(:,w1)=(X1(:,w1)-mean((X1(:,w1))))./std(X1(:,w1));
    end
 end
 theta10=theta;
 h1=1./(1+exp(-X1*theta10));  %sigmoid function
 k1=1;
 J1(k1)=-(1/percent10)*sum(Y1.*log(h1)+(1-Y1).*log(1-h1))+(lambda/(2*percent10))*sum((theta10).^2);  %cost function


 
m10_10=percent80+percent10+1;
p=m-(percent80+percent10);
x2=data{percent10:end,1:13};
X2=[ones(p,1) x2 x2.^10];

y2=data{percent10:end,14};
Y2=y2;
n2=length(X2(1,:)); 
 for w2=2:n2
    if max(abs(X2(:,w2)))~=0
    X2(:,w2)=(X2(:,w2)-mean((X2(:,w2))))./std(X2(:,w2));
    end
 end
 theta20=theta10;
 h2=1./(1+exp(-X2*theta20));  %sigmoid function
 k2=1;
 J2(k2)=-(1/percent10)*sum(Y2.*log(h2)+(1-Y2).*log(1-h2))+(lambda/(2*percent10))*sum((theta20).^2);  %cost function
 
 plot(J)