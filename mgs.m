function [ Q, R ] = mgs( A )
%CGS Summary of this function goes here
%   Detailed explanation goes here
    [~, m] = size(A);
    
    Q=zeros(m,m);
    R=zeros(m,m);
    
    for k = 1:m
       a=A(:,k);
       for i = 1:k-1
           R(i,k)=(Q(:,i))'*A(:,k);
           if(k>1)
            a=a-Q(:,i)*R(i,k);
           end
       end

       R(k,k)=norm(a,2);
       if(R(k,k)==0)
           fprintf('Error\n');
           return;
       end
       Q(:,k)=(1/R(k,k))*a;
    end

end
